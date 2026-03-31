// lib/presentation/pages/admin/sections/verifactu_section.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../config/theme.dart';
import '../../../controllers/verifactu_controller.dart';

class VerifactuSection extends StatefulWidget {
  const VerifactuSection({super.key});

  @override
  State<VerifactuSection> createState() => _VerifactuSectionState();
}

class _VerifactuSectionState extends State<VerifactuSection> {
  final _controller = Get.find<VerifactuController>();
  final _money = NumberFormat.currency(locale: 'es_ES', symbol: 'EUR ');
  final _companyCtrl = TextEditingController();
  final _taxIdCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _hashCtrl = TextEditingController();
  bool _isNewSystem = false;
  bool _prefilledFromAdmin = false;

  @override
  void initState() {
    super.initState();
    final admin = _controller.adminUser.value;
    if (admin != null) {
      _companyCtrl.text = admin.companyName ?? '';
      _taxIdCtrl.text = admin.taxId ?? '';
      _addressCtrl.text = admin.address ?? '';
    }
  }

  @override
  void dispose() {
    _companyCtrl.dispose();
    _taxIdCtrl.dispose();
    _addressCtrl.dispose();
    _hashCtrl.dispose();
    super.dispose();
  }

  String _formatDate(String? raw) {
    if (raw == null || raw.isEmpty) {
      return '-';
    }
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) {
      return raw;
    }
    return DateFormat('dd/MM/yyyy HH:mm').format(parsed.toLocal());
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'ACEPTADO':
        return AppTheme.success;
      case 'RECHAZADO':
      case 'ERROR_PERMANENTE':
        return AppTheme.error;
      case 'PENDIENTE_ENVIO':
      case 'ENVIANDO':
      case 'REINTENTO':
        return AppTheme.warning;
      default:
        return AppTheme.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(() {
      final state = _controller.backendState.value;
      final admin = _controller.adminUser.value;
      if (!_prefilledFromAdmin && admin != null) {
        _companyCtrl.text = admin.companyName ?? _companyCtrl.text;
        _taxIdCtrl.text = admin.taxId ?? _taxIdCtrl.text;
        _addressCtrl.text = admin.address ?? _addressCtrl.text;
        _prefilledFromAdmin = true;
      }
      final canUseBackend = state?.canUseBackend ?? false;
      final requiresAuth = state?.requiresAuth ?? false;
      final registered = state?.registered ?? false;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Text('Panel Verifactu', style: theme.textTheme.headlineSmall),
                const Spacer(),
                FilledButton.icon(
                  onPressed: _controller.refreshInteractions,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Actualizar'),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Registro backend Verifactu', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _companyCtrl,
                      decoration: const InputDecoration(labelText: 'Nombre empresa'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _taxIdCtrl,
                      decoration: const InputDecoration(labelText: 'Razon social (CIF/NIF)'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _addressCtrl,
                      decoration: const InputDecoration(labelText: 'Direccion'),
                    ),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Nuevo en sistema Verifactu'),
                      value: _isNewSystem,
                      onChanged: (v) => setState(() => _isNewSystem = v ?? false),
                    ),
                    TextField(
                      controller: _hashCtrl,
                      enabled: !_isNewSystem,
                      decoration: const InputDecoration(
                        labelText: 'Hash Verifactu',
                        helperText: 'Obligatorio si no marcas "Nuevo en sistema Verifactu"',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilledButton.icon(
                          onPressed: _controller.isSubmitting.value
                              ? null
                              : () => _controller.registerBackend(
                                  companyName: _companyCtrl.text.trim(),
                                  taxId: _taxIdCtrl.text.trim(),
                                  address: _addressCtrl.text.trim(),
                                  isNewSystem: _isNewSystem,
                                  hash: _isNewSystem ? null : _hashCtrl.text.trim(),
                                ),
                          icon: const Icon(Icons.app_registration),
                          label: const Text('Registrar'),
                        ),
                        OutlinedButton.icon(
                          onPressed: _controller.isSubmitting.value ? null : _controller.authenticateNow,
                          icon: const Icon(Icons.verified_user),
                          label: const Text('Autenticar ahora'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      !registered
                          ? 'Estado: Modo local (sin registro backend).'
                          : requiresAuth
                          ? 'Estado: Registro OK, requiere autenticación (máx cada 15 días).'
                          : 'Estado: Backend activo.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: () {
              if (!canUseBackend) {
                return Center(
                  child: Text(
                    'Modo local activo: no se harán intentos de conexión al backend al emitir tickets.',
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                );
              }

              if (_controller.isLoading.value && _controller.interactions.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (_controller.errorMessage.value != null && _controller.interactions.isEmpty) {
                return Center(child: Text(_controller.errorMessage.value!, style: theme.textTheme.bodyMedium));
              }

              if (_controller.interactions.isEmpty) {
                return Center(
                  child: Text('Aún no hay interacciones enviadas al backend.', style: theme.textTheme.bodyMedium),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: _controller.interactions.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (_, index) {
                  final item = _controller.interactions[index];
                  final color = _statusColor(item.status);
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(color: AppTheme.border),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Factura ${item.invoiceSeries}-${item.invoiceNumber}',
                                  style: theme.textTheme.titleMedium,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  item.status,
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: color,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 16,
                            runSpacing: 6,
                            children: [
                              Text('Importe: ${_money.format(item.totalAmount)}'),
                              Text('Issue date: ${item.issueDate}'),
                              Text('Reintentos: ${item.retryCount}'),
                              Text('Enviado: ${_formatDate(item.sentAt)}'),
                              Text('Respuesta: ${_formatDate(item.respondedAt)}'),
                            ],
                          ),
                          if (item.secureVerificationCode != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              'CSV: ${item.secureVerificationCode}',
                              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                          if (item.responseDescription != null && item.responseDescription!.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              item.responseDescription!,
                              style: theme.textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              );
            }(),
          ),
        ],
      );
    });
  }
}
