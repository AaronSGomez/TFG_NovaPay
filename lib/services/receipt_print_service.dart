import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

import '../data/models/ticket.dart';
import '../data/models/user.dart';
import '../data/models/verifactu_models.dart';
import '../presentation/controllers/auth_controller.dart';
import 'user_service.dart';

class ReceiptPrintService {
  static const String _aeatQrBaseUrl =
      'https://www2.agenciatributaria.gob.es/wlpl/inwinv/es/es.aeat.dit.adu.einv.qr.QRWidget?csv=';

  // Default values para fallback (en caso de que no haya usuario admin)
  static const String _defaultEmitterName = String.fromEnvironment(
    'NOVAPAY_EMITTER_NAME',
    defaultValue: 'NOVAPAY DEMO S.L.',
  );
  static const String _defaultEmitterNif = String.fromEnvironment('NOVAPAY_EMITTER_NIF', defaultValue: 'B33333333');
  static const String _defaultEmitterAddress = String.fromEnvironment(
    'NOVAPAY_EMITTER_ADDRESS',
    defaultValue: 'DOMICILIO PRUEBA, 123, CIUDAD',
  );
  static const String _defaultTaxType = String.fromEnvironment('NOVAPAY_TAX_TYPE', defaultValue: 'IVA_REDUCIDO');

  final UserService _userService;
  final DateFormat _dateTimeFormat = DateFormat('dd/MM/yyyy HH:mm');
  final NumberFormat _money = NumberFormat.currency(locale: 'es_ES', symbol: '€');

  ReceiptPrintService(this._userService);

  Future<void> printTicket({
    required Ticket ticket,
    required BackendInvoiceResponse invoice,
    FiscalStatusResponse? fiscalStatus,
    String? emitterName,
    String? emitterNif,
    String? emitterAddress,
    double? cashGiven,
    double? cashChange,
  }) async {
    // Obtener datos del emisor: primero los parámetros, luego del admin, luego defaults
    final adminUser = await _getAdminUser();

    final finalEmitterName = emitterName ?? adminUser?.companyName ?? _defaultEmitterName;

    final finalEmitterNif = emitterNif ?? adminUser?.taxId ?? _defaultEmitterNif;

    final finalEmitterAddress = emitterAddress ?? adminUser?.address ?? _defaultEmitterAddress;
    final attendedBy = _resolveAttendedBy();
    final tableLabel = _resolveTableLabel(ticket);
    final paymentLabel = _paymentMethodLabel(ticket.paymentMethod);
    final backendEditable = adminUser?.backendEditable ?? false;
    final logoImage = await _loadLogoForThermalPrint(adminUser?.logoPath);

    final doc = pw.Document();
    final qrPayload = _resolveVerificationUrl(fiscalStatus);
    final taxInfo = _taxInfoFromType(_defaultTaxType);
    final totals = _computeTotalsWithVat(ticket.totalAmount, taxInfo.ratePercent);
    final baseFont = await PdfGoogleFonts.notoSansRegular();
    final boldFont = await PdfGoogleFonts.notoSansBold();

    pw.TextStyle baseStyle({double fontSize = 10, PdfColor? color}) {
      return pw.TextStyle(font: baseFont, fontBold: boldFont, fontSize: fontSize, color: color);
    }

    pw.TextStyle boldStyle({double fontSize = 10, PdfColor? color}) {
      return pw.TextStyle(
        font: boldFont,
        fontBold: boldFont,
        fontWeight: pw.FontWeight.bold,
        fontSize: fontSize,
        color: color,
      );
    }

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        margin: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (logoImage != null) ...[
                pw.Center(child: pw.Image(logoImage, width: 110, height: 110, fit: pw.BoxFit.contain)),
                pw.SizedBox(height: 6),
              ],
              pw.Center(child: pw.Text(finalEmitterName, style: boldStyle(fontSize: 16))),
              pw.SizedBox(height: 8),
              pw.Center(child: pw.Text(finalEmitterName, style: baseStyle())),
              pw.Center(child: pw.Text(finalEmitterNif, style: baseStyle())),
              pw.Center(child: pw.Text(finalEmitterAddress, style: baseStyle())),
              pw.SizedBox(height: 6),
              pw.Center(child: pw.Text('Fecha: ${_dateTimeFormat.format(ticket.createdAt)}', style: baseStyle())),
              pw.SizedBox(height: 6),
              pw.Text('Ticket: ${invoice.series}-${invoice.number}', style: baseStyle()),
              pw.Text('Tipo de Factura: Simplificada', style: baseStyle()),
              pw.Text('Atendido por: $attendedBy', style: baseStyle()),
              pw.Text('Numero de mesa: $tableLabel', style: baseStyle()),
              pw.Text('Pago: $paymentLabel', style: baseStyle()),
              pw.Divider(),
              pw.Text(
                'Descripcion: ${ticket.lines.length} linea(s) de bienes/servicios',
                style: baseStyle(fontSize: 9),
              ),
              pw.SizedBox(height: 4),
              ...ticket.lines.map(
                (line) => pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 2),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(flex: 5, child: pw.Text('${line.quantity}x ${line.productName}', style: baseStyle())),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(_money.format(line.totalLine), style: baseStyle()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Base imponible', style: baseStyle()),
                  pw.Text(_money.format(totals.baseAmount), style: baseStyle()),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('IVA ${taxInfo.ratePercent.toStringAsFixed(0)}% (${taxInfo.label})', style: baseStyle()),
                  pw.Text(_money.format(totals.taxAmount), style: baseStyle()),
                ],
              ),
              pw.SizedBox(height: 6), // Espacio antes del total
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('TOTAL (IVA incluido)', style: boldStyle()),
                  pw.Text(_money.format(ticket.totalAmount), style: boldStyle()),
                ],
              ),
              if (ticket.paymentMethod == PaymentMethod.efectivo && cashGiven != null) ...[
                pw.SizedBox(height: 4),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Cliente entrega', style: baseStyle()),
                    pw.Text(_money.format(cashGiven), style: baseStyle()),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Cambio', style: baseStyle()),
                    pw.Text(_money.format(cashChange ?? 0), style: baseStyle()),
                  ],
                ),
              ],
              if (fiscalStatus?.secureVerificationCode != null) ...[
                pw.SizedBox(height: 8),
                pw.Text('CSV: ${fiscalStatus!.secureVerificationCode}', style: baseStyle(fontSize: 8)),
              ],
              if (fiscalStatus?.verificationUrl != null) ...[
                pw.SizedBox(height: 4),
                pw.Text('Verificacion AEAT:', style: baseStyle(fontSize: 8)),
                pw.UrlLink(
                  destination: fiscalStatus!.verificationUrl!,
                  child: pw.Text(fiscalStatus.verificationUrl!, style: baseStyle(fontSize: 7, color: PdfColors.blue)),
                ),
              ],
              pw.SizedBox(height: 8),
              pw.Center(child: pw.Text('Gracias por su visita', style: boldStyle(fontSize: 11))),
              pw.SizedBox(height: 6),
              // QRs footer
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.BarcodeWidget(barcode: pw.Barcode.qrCode(), data: ticket.uuid, width: 70, height: 70),
                  pw.SizedBox(width: 8),
                  if (backendEditable && qrPayload != null)
                    pw.BarcodeWidget(barcode: pw.Barcode.qrCode(), data: qrPayload, width: 70, height: 70),
                ],
              ),
              pw.SizedBox(height: 2),
              pw.Center(child: pw.Text('Identificador | Verificación', style: baseStyle(fontSize: 7))),
              pw.SizedBox(height: 2),
              pw.Center(child: pw.Text('Estado fiscal: ${fiscalStatus?.status ?? 'PENDIENTE'}', style: baseStyle())),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => doc.save());
  }

  ({String label, double ratePercent}) _taxInfoFromType(String taxType) {
    switch (taxType) {
      case 'IVA_GENERAL':
        return (label: 'IVA general', ratePercent: 21);
      case 'IVA_SUPERREDUCIDO':
        return (label: 'IVA superreducido', ratePercent: 4);
      case 'EXENTO':
        return (label: 'Exento', ratePercent: 0);
      case 'NO_SUJETO':
        return (label: 'No sujeto', ratePercent: 0);
      case 'IVA_REDUCIDO':
      default:
        return (label: 'IVA reducido', ratePercent: 10);
    }
  }

  ({double baseAmount, double taxAmount}) _computeTotalsWithVat(double totalAmount, double taxRatePercent) {
    if (taxRatePercent <= 0) {
      return (baseAmount: totalAmount, taxAmount: 0);
    }

    final divisor = 1 + (taxRatePercent / 100);
    final base = totalAmount / divisor;
    final tax = totalAmount - base;
    return (baseAmount: base, taxAmount: tax);
  }

  String? _resolveVerificationUrl(FiscalStatusResponse? fiscalStatus) {
    if (fiscalStatus == null) {
      return null;
    }

    if (fiscalStatus.verificationUrl != null && fiscalStatus.verificationUrl!.isNotEmpty) {
      return fiscalStatus.verificationUrl;
    }

    final csv = fiscalStatus.secureVerificationCode;
    if (csv == null || csv.isEmpty) {
      return null;
    }
    return '$_aeatQrBaseUrl$csv';
  }

  /// Obtiene el usuario admin desde la base de datos.
  /// Retorna null si no hay admin o si hay error.
  Future<User?> _getAdminUser() async {
    try {
      return await _userService.getAdmin();
    } catch (e) {
      // Si hay error, retorna null y usa valores por defecto
      return null;
    }
  }

  String _resolveAttendedBy() {
    try {
      if (Get.isRegistered<AuthController>()) {
        final current = Get.find<AuthController>().currentUser.value;
        final name = '${current?.username ?? ''} ${current?.lastName ?? ''}'.trim();
        if (name.isNotEmpty) return name;
      }
    } catch (_) {
      // Fallback below
    }
    return 'N/D';
  }

  String _resolveTableLabel(Ticket ticket) {
    if (ticket.tableNumber != null) return ticket.tableNumber.toString();
    if (ticket.tableOrLabel != null && ticket.tableOrLabel!.trim().isNotEmpty) return ticket.tableOrLabel!.trim();
    return 'N/D';
  }

  String _paymentMethodLabel(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.efectivo:
        return 'Contado';
      case PaymentMethod.mixto:
        return 'Mixto';
      case PaymentMethod.tarjeta:
        return 'Tarjeta';
    }
  }

  Future<pw.MemoryImage?> _loadLogoForThermalPrint(String? logoPath) async {
    if (logoPath == null || logoPath.isEmpty) return null;
    final file = File(logoPath);
    if (!file.existsSync()) return null;

    try {
      final bytes = await file.readAsBytes();
      final decoded = img.decodeImage(bytes);
      if (decoded == null) return null;

      // Escala de grises + contraste para mejorar salida en impresora térmica.
      final gray = img.grayscale(decoded);
      final contrasted = img.adjustColor(gray, contrast: 1.2);
      final png = Uint8List.fromList(img.encodePng(contrasted));
      return pw.MemoryImage(png);
    } catch (_) {
      return null;
    }
  }
}
