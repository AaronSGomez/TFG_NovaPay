import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../data/models/ticket.dart';
import '../data/models/verifactu_models.dart';
import 'config_service.dart';

class VerifactuApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? responseBody;

  const VerifactuApiException(this.message, {this.statusCode, this.responseBody});

  @override
  String toString() {
    if (statusCode == null) {
      return message;
    }
    return '$message (HTTP $statusCode) ${responseBody ?? ''}'.trim();
  }
}

class VerifactuLocalModeException implements Exception {
  final String message;
  const VerifactuLocalModeException(this.message);

  @override
  String toString() => message;
}

class VerifactuBackendState {
  final bool registered;
  final bool canUseBackend;
  final bool requiresAuth;
  final bool isNewSystem;
  final DateTime? lastAuthAt;

  const VerifactuBackendState({
    required this.registered,
    required this.canUseBackend,
    required this.requiresAuth,
    required this.isNewSystem,
    required this.lastAuthAt,
  });
}

class VerifactuService {
  static const String _baseUrl = String.fromEnvironment('NOVAPAY_BACKEND_URL', defaultValue: 'http://localhost:8080');
  static const String _clientId = String.fromEnvironment('NOVAPAY_CLIENT_ID', defaultValue: 'novapay-client');
  static const String _clientSecret = String.fromEnvironment(
    'NOVAPAY_CLIENT_SECRET',
    defaultValue: 'novapay-secret-2024',
  );
  static const String _companyId = String.fromEnvironment(
    'NOVAPAY_COMPANY_ID',
    defaultValue: '550e8400-e29b-41d4-a716-446655440000',
  );
  static const String _terminalId = String.fromEnvironment(
    'NOVAPAY_TERMINAL_ID',
    defaultValue: '550e8400-e29b-41d4-a716-446655440001',
  );
  static const String _series = String.fromEnvironment('NOVAPAY_INVOICE_SERIES', defaultValue: 'TPV');
  static const String _defaultTaxType = String.fromEnvironment('NOVAPAY_TAX_TYPE', defaultValue: 'IVA_REDUCIDO');
  static const Duration _maxAuthAge = Duration(days: 15);

  final http.Client _httpClient;
  final ConfigService _configService;
  VerifactuService(this._configService, {http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  String? _accessToken;
  DateTime? _tokenExpiresAt;

  Future<VerifactuBackendState> getBackendState() async {
    final config = await _configService.getConfig();
    final registered = config.verifactuRegistered;
    if (!registered) {
      return const VerifactuBackendState(
        registered: false,
        canUseBackend: false,
        requiresAuth: false,
        isNewSystem: false,
        lastAuthAt: null,
      );
    }

    final lastAuth = config.verifactuLastAuthAt;
    final requiresAuth = lastAuth == null || DateTime.now().difference(lastAuth) > _maxAuthAge;

    return VerifactuBackendState(
      registered: true,
      canUseBackend: !requiresAuth,
      requiresAuth: requiresAuth,
      isNewSystem: config.verifactuIsNewSystem,
      lastAuthAt: lastAuth,
    );
  }

  Future<void> registerBackendUser({
    required String companyName,
    required String taxId,
    required String address,
    required bool isNewSystem,
    String? clientHash,
  }) async {
    final payload = {
      'companyName': companyName,
      'taxId': taxId,
      'address': address,
      'clientHash': clientHash,
      'isNewSystem': isNewSystem,
    };

    final response = await _httpClient.post(
      Uri.parse('$_baseUrl/api/v1/verifactu/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw VerifactuApiException(
        'No se pudo registrar en backend Verifactu',
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }

    final cfg = await _configService.getConfig();
    cfg
      ..verifactuRegistered = true
      ..verifactuIsNewSystem = isNewSystem
      ..verifactuClientHash = (clientHash != null && clientHash.isNotEmpty) ? clientHash : cfg.verifactuClientHash
      ..verifactuClientId = taxId
      ..verifactuLastAuthAt = null;
    await _configService.saveConfig(cfg);
  }

  Future<void> authenticateBackend() async {
    final cfg = await _configService.getConfig();
    if (!cfg.verifactuRegistered) {
      throw const VerifactuLocalModeException('No registrado en backend Verifactu. Se mantiene modo local.');
    }

    await _ensureToken(forceRefresh: true);
    cfg.verifactuLastAuthAt = DateTime.now();
    await _configService.saveConfig(cfg);
  }

  Future<InvoiceEmissionResult> emitTicket(Ticket ticket) async {
    if (ticket.lines.isEmpty) {
      throw Exception('No se puede emitir una factura sin líneas.');
    }

    final state = await getBackendState();
    if (!state.registered) {
      throw const VerifactuLocalModeException('Modo local: la app no está registrada en backend Verifactu.');
    }
    if (state.requiresAuth) {
      throw const VerifactuLocalModeException(
        'Modo local: debes autenticarte en backend Verifactu al menos cada 15 días.',
      );
    }

    await _ensureToken();

    final now = DateTime.now();
    final issueDate = DateFormat('yyyy-MM-dd').format(now);
    final number = now.millisecondsSinceEpoch.remainder(1000000);

    final payload = {
      'series': _series,
      'number': number,
      'type': 'SIMPLIFICADA',
      'companyId': _companyId,
      'terminalId': _terminalId,
      'issueDate': issueDate,
      'lines': ticket.lines
          .map(
            (line) => {
              'description': line.productName,
              'quantity': line.quantity,
              'unitPrice': line.priceAtMoment,
              'taxType': _defaultTaxType,
            },
          )
          .toList(),
      'rectifiedInvoiceId': null,
    };

    final emitResponse = await _httpClient.post(
      Uri.parse('$_baseUrl/api/v1/invoices'),
      headers: _jsonAuthHeaders,
      body: jsonEncode(payload),
    );

    if (emitResponse.statusCode != 201) {
      throw VerifactuApiException(
        'Error al emitir factura',
        statusCode: emitResponse.statusCode,
        responseBody: emitResponse.body,
      );
    }

    final invoice = BackendInvoiceResponse.fromJson(decodeJsonObject(emitResponse.body));

    final fiscalStatus = await pollFiscalStatus(invoice.id);
    return InvoiceEmissionResult(invoice: invoice, fiscalStatus: fiscalStatus);
  }

  Future<FiscalStatusResponse?> pollFiscalStatus(
    String invoiceId, {
    int maxAttempts = 15,
    Duration delay = const Duration(seconds: 2),
  }) async {
    final state = await getBackendState();
    if (!state.canUseBackend) {
      return null;
    }

    await _ensureToken();

    FiscalStatusResponse? latest;
    for (var i = 0; i < maxAttempts; i++) {
      final response = await _httpClient.get(
        Uri.parse('$_baseUrl/api/v1/fiscal/status/$invoiceId'),
        headers: _authHeaders,
      );

      if (response.statusCode == 200) {
        latest = FiscalStatusResponse.fromJson(decodeJsonObject(response.body));
        if (latest.status != 'PENDIENTE_ENVIO' && latest.status != 'ENVIANDO') {
          return latest;
        }
      } else if (response.statusCode == 404) {
        return null;
      }

      await Future.delayed(delay);
    }

    return latest;
  }

  Future<List<FiscalInteraction>> fetchInteractions({int limit = 200}) async {
    final state = await getBackendState();
    if (!state.canUseBackend) {
      return [];
    }

    await _ensureToken();

    final response = await _httpClient.get(
      Uri.parse('$_baseUrl/api/v1/fiscal/interactions?limit=$limit'),
      headers: _authHeaders,
    );

    if (response.statusCode != 200) {
      throw VerifactuApiException(
        'Error al cargar interacciones fiscales',
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }

    return decodeJsonObjectList(response.body).map(FiscalInteraction.fromJson).toList();
  }

  Future<void> _ensureToken({bool forceRefresh = false}) async {
    if (_accessToken != null && _tokenExpiresAt != null && DateTime.now().isBefore(_tokenExpiresAt!) && !forceRefresh) {
      return;
    }

    final cfg = await _configService.getConfig();
    final authClientId = cfg.verifactuClientId ?? _clientId;
    final authSecret = (cfg.verifactuClientHash != null && cfg.verifactuClientHash!.isNotEmpty)
        ? cfg.verifactuClientHash!
        : _clientSecret;

    final response = await _httpClient.post(
      Uri.parse('$_baseUrl/api/v1/auth/token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'clientId': authClientId, 'clientSecret': authSecret}),
    );

    if (response.statusCode != 200) {
      throw VerifactuApiException(
        'No se pudo autenticar con backend fiscal',
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }

    final body = decodeJsonObject(response.body);
    final token = body['accessToken'] as String?;
    final expiresIn = (body['expiresIn'] as num?)?.toInt() ?? 60;
    if (token == null || token.isEmpty) {
      throw Exception('Token JWT vacío en respuesta de autenticación.');
    }

    _accessToken = token;
    _tokenExpiresAt = DateTime.now().add(Duration(seconds: expiresIn - 5));
  }

  Map<String, String> get _authHeaders {
    return {'Authorization': 'Bearer $_accessToken', 'Accept': 'application/json'};
  }

  Map<String, String> get _jsonAuthHeaders {
    return {..._authHeaders, 'Content-Type': 'application/json'};
  }
}
