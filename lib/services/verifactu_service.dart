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

class VerifactuRegistrationResult {
  final String message;
  final String? companyId;
  final String? clientId;
  final String? planCode;
  final String? billingCycle;
  final String? baseAmount;
  final String? invoiceLimit;
  final String? overagePerInvoice;

  const VerifactuRegistrationResult({
    required this.message,
    this.companyId,
    this.clientId,
    this.planCode,
    this.billingCycle,
    this.baseAmount,
    this.invoiceLimit,
    this.overagePerInvoice,
  });

  factory VerifactuRegistrationResult.fromJson(Map<String, dynamic> json) {
    return VerifactuRegistrationResult(
      message: (json['message'] as String?) ?? 'Registro backend completado',
      companyId: json['companyId'] as String?,
      clientId: json['clientId'] as String?,
      planCode: json['planCode'] as String?,
      billingCycle: json['billingCycle'] as String?,
      baseAmount: json['baseAmount'] as String?,
      invoiceLimit: json['invoiceLimit'] as String?,
      overagePerInvoice: json['overagePerInvoice'] as String?,
    );
  }
}

class VerifactuSubscriptionSummary {
  final String clientId;
  final String companyId;
  final String planCode;
  final String billingCycle;
  final String periodStart;
  final String periodEnd;
  final int serviceDaysRemaining;
  final String paymentStatus;
  final int includedInvoices;
  final int consumedInvoices;
  final int remainingInvoices;
  final int overageInvoices;
  final String baseAmount;
  final String overagePerInvoice;
  final String estimatedOverage;
  final String estimatedTotal;

  const VerifactuSubscriptionSummary({
    required this.clientId,
    required this.companyId,
    required this.planCode,
    required this.billingCycle,
    required this.periodStart,
    required this.periodEnd,
    required this.serviceDaysRemaining,
    required this.paymentStatus,
    required this.includedInvoices,
    required this.consumedInvoices,
    required this.remainingInvoices,
    required this.overageInvoices,
    required this.baseAmount,
    required this.overagePerInvoice,
    required this.estimatedOverage,
    required this.estimatedTotal,
  });

  factory VerifactuSubscriptionSummary.fromJson(Map<String, dynamic> json) {
    return VerifactuSubscriptionSummary(
      clientId: (json['clientId'] as String?) ?? '',
      companyId: (json['companyId'] as String?) ?? '',
      planCode: (json['planCode'] as String?) ?? '',
      billingCycle: (json['billingCycle'] as String?) ?? '',
      periodStart: (json['periodStart'] as String?) ?? '',
      periodEnd: (json['periodEnd'] as String?) ?? '',
      serviceDaysRemaining: (json['serviceDaysRemaining'] as num?)?.toInt() ?? 0,
      paymentStatus: (json['paymentStatus'] as String?) ?? 'DESCONOCIDO',
      includedInvoices: (json['includedInvoices'] as num?)?.toInt() ?? 0,
      consumedInvoices: (json['consumedInvoices'] as num?)?.toInt() ?? 0,
      remainingInvoices: (json['remainingInvoices'] as num?)?.toInt() ?? 0,
      overageInvoices: (json['overageInvoices'] as num?)?.toInt() ?? 0,
      baseAmount: (json['baseAmount'] as String?) ?? '0.00',
      overagePerInvoice: (json['overagePerInvoice'] as String?) ?? '0.00',
      estimatedOverage: (json['estimatedOverage'] as String?) ?? '0.00',
      estimatedTotal: (json['estimatedTotal'] as String?) ?? '0.00',
    );
  }
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
    final hasClientId = config.verifactuClientId != null && config.verifactuClientId!.trim().isNotEmpty;
    final registered = config.verifactuRegistered && hasClientId;
    if (!registered) {
      if (config.verifactuRegistered) {
        config
          ..verifactuRegistered = false
          ..verifactuClientId = null
          ..verifactuLastAuthAt = null;
        await _configService.saveConfig(config);
      }
      return const VerifactuBackendState(
        registered: false,
        canUseBackend: false,
        requiresAuth: false,
        isNewSystem: false,
        lastAuthAt: null,
      );
    }

    final lastAuth = config.verifactuLastAuthAt;
    final hasLocalToken = hasActiveJwtSession;
    final authExpired = lastAuth == null || DateTime.now().difference(lastAuth) > _maxAuthAge;
    final requiresAuth = !hasLocalToken || authExpired;

    return VerifactuBackendState(
      registered: true,
      canUseBackend: hasLocalToken && !authExpired,
      requiresAuth: requiresAuth,
      isNewSystem: config.verifactuIsNewSystem,
      lastAuthAt: lastAuth,
    );
  }

  Future<VerifactuRegistrationResult> registerBackendUser({
    required String companyName,
    required String taxId,
    required String address,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String planCode,
    required String billingCycle,
    required bool isNewSystem,
    String? clientHash,
  }) async {
    final normalizedHash = clientHash?.trim();
    final payload = {
      'companyName': companyName,
      'taxId': taxId,
      'address': address,
      'email': email,
      'password': password,
      'passwordConfirmation': passwordConfirmation,
      'planCode': planCode,
      'billingCycle': billingCycle,
      'isNewSystem': isNewSystem,
    };
    if (!isNewSystem && normalizedHash != null && normalizedHash.isNotEmpty) {
      payload['clientHash'] = normalizedHash;
    }

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

    final responseJson = decodeJsonObject(response.body);
    final registrationResult = VerifactuRegistrationResult.fromJson(responseJson);

    final cfg = await _configService.getConfig();
    cfg
      ..verifactuRegistered = true
      ..verifactuIsNewSystem = isNewSystem
      ..verifactuClientHash = password
      ..verifactuClientId = taxId
      ..verifactuLastAuthAt = null;
    await _configService.saveConfig(cfg);

    return registrationResult;
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

  Future<void> authenticateBackendWithCredentials({
    required String email,
    required String password,
    String? fallbackClientId,
  }) async {
    final response = await _httpClient.post(
      Uri.parse('$_baseUrl/api/v1/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email.trim(), 'password': password}),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw VerifactuApiException(
        'No se pudo iniciar sesión con email y contraseña',
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }

    final body = decodeJsonObject(response.body);
    final token = (body['access_token'] as String?) ?? (body['accessToken'] as String?);
    final expiresIn = ((body['expires_in'] as num?) ?? (body['expiresIn'] as num?) ?? 3600).toInt();
    final clientIdFromLogin =
        ((body['clientId'] as String?) ??
                (body['client_id'] as String?) ??
                (body['taxId'] as String?) ??
                (body['tax_id'] as String?))
            ?.trim();
    final fallback = fallbackClientId?.trim();
    final resolvedClientId = (clientIdFromLogin != null && clientIdFromLogin.isNotEmpty)
        ? clientIdFromLogin
        : ((fallback != null && fallback.isNotEmpty) ? fallback : null);
    if (token == null || token.isEmpty) {
      throw Exception('Token JWT vacío en respuesta de login por email.');
    }

    _accessToken = token;
    _tokenExpiresAt = DateTime.now().add(Duration(seconds: expiresIn - 5));

    final cfg = await _configService.getConfig();
    cfg
      ..verifactuClientId = (resolvedClientId != null && resolvedClientId.isNotEmpty)
          ? resolvedClientId
          : cfg.verifactuClientId
      ..verifactuRegistered = (resolvedClientId != null && resolvedClientId.isNotEmpty) ? true : cfg.verifactuRegistered
      ..verifactuClientHash = password
      ..verifactuLastAuthAt = DateTime.now();

    if (cfg.verifactuClientId == null || cfg.verifactuClientId!.trim().isEmpty) {
      cfg.verifactuRegistered = false;
    }

    await _configService.saveConfig(cfg);
  }

  Future<void> requestPasswordRecovery({required String email}) async {
    final response = await _httpClient.post(
      Uri.parse('$_baseUrl/api/v1/auth/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email.trim()}),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw VerifactuApiException(
        'No se pudo iniciar la recuperación de contraseña',
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }
  }

  Future<void> logoutBackend() async {
    _accessToken = null;
    _tokenExpiresAt = null;

    final cfg = await _configService.getConfig();
    cfg.verifactuLastAuthAt = null;
    await _configService.saveConfig(cfg);
  }

  Future<void> resetLocalVerifactuState() async {
    _accessToken = null;
    _tokenExpiresAt = null;

    final cfg = await _configService.getConfig();
    cfg
      ..verifactuRegistered = false
      ..verifactuIsNewSystem = false
      ..verifactuClientId = null
      ..verifactuClientHash = null
      ..verifactuLastAuthAt = null;
    await _configService.saveConfig(cfg);
  }

  bool get hasActiveJwtSession {
    if (_accessToken == null || _tokenExpiresAt == null) {
      return false;
    }
    return DateTime.now().isBefore(_tokenExpiresAt!);
  }

  Future<void> changePassword({required String currentPassword, required String newPassword}) async {
    final cfg = await _configService.getConfig();
    final clientId = cfg.verifactuClientId;
    if (clientId == null || clientId.trim().isEmpty) {
      throw const VerifactuLocalModeException('No hay clientId configurado para cambiar contraseña.');
    }

    await _ensureToken(forceRefresh: true);

    final response = await _httpClient.post(
      Uri.parse('$_baseUrl/api/v1/auth/change-password'),
      headers: {..._jsonAuthHeaders, 'X-Client-Id': clientId.trim()},
      body: jsonEncode({'currentPassword': currentPassword, 'newPassword': newPassword, 'temporalPassword': null}),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw VerifactuApiException(
        'No se pudo cambiar la contraseña',
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }

    cfg.verifactuClientHash = newPassword;
    await _configService.saveConfig(cfg);
    _accessToken = null;
    _tokenExpiresAt = null;
  }

  Future<VerifactuSubscriptionSummary> fetchSubscriptionSummary() async {
    final cfg = await _configService.getConfig();
    final clientId = cfg.verifactuClientId;
    if (clientId == null || clientId.trim().isEmpty) {
      throw const VerifactuLocalModeException('No hay clientId configurado para consultar consumo.');
    }

    final response = await _httpClient.get(
      Uri.parse('$_baseUrl/api/v1/verifactu/subscription/${clientId.trim()}'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw VerifactuApiException(
        'No se pudo obtener el resumen de suscripción',
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }

    return VerifactuSubscriptionSummary.fromJson(decodeJsonObject(response.body));
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
