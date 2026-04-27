import 'dart:convert';

class BackendInvoiceResponse {
  final String id;
  final String series;
  final int number;
  final String type;
  final String status;
  final String issueDate;
  final double totalAmount;

  const BackendInvoiceResponse({
    required this.id,
    required this.series,
    required this.number,
    required this.type,
    required this.status,
    required this.issueDate,
    required this.totalAmount,
  });

  factory BackendInvoiceResponse.fromJson(Map<String, dynamic> json) {
    return BackendInvoiceResponse(
      id: json['id'] as String,
      series: json['series'] as String? ?? '',
      number: (json['number'] as num?)?.toInt() ?? 0,
      type: json['type'] as String? ?? '',
      status: json['status'] as String? ?? '',
      issueDate: json['issueDate'] as String? ?? '',
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0,
    );
  }
}

class FiscalStatusResponse {
  final String invoiceId;
  final String status;
  final int retryCount;
  final String? sentAt;
  final String? respondedAt;
  final String? responseCode;
  final String? responseDescription;
  final String? secureVerificationCode;
  final String? verificationUrl;

  const FiscalStatusResponse({
    required this.invoiceId,
    required this.status,
    required this.retryCount,
    this.sentAt,
    this.respondedAt,
    this.responseCode,
    this.responseDescription,
    this.secureVerificationCode,
    this.verificationUrl,
  });

  factory FiscalStatusResponse.fromJson(Map<String, dynamic> json) {
    return FiscalStatusResponse(
      invoiceId: json['invoiceId'] as String,
      status: json['status'] as String? ?? '',
      retryCount: (json['retryCount'] as num?)?.toInt() ?? 0,
      sentAt: json['sentAt'] as String?,
      respondedAt: json['respondedAt'] as String?,
      responseCode: json['responseCode'] as String?,
      responseDescription: json['responseDescription'] as String?,
      secureVerificationCode: json['secureVerificationCode'] as String?,
      verificationUrl: json['verificationUrl'] as String?,
    );
  }
}

class FiscalInteraction {
  final String invoiceId;
  final String invoiceSeries;
  final int invoiceNumber;
  final String issueDate;
  final double totalAmount;
  final String status;
  final int retryCount;
  final String? sentAt;
  final String? respondedAt;
  final String? secureVerificationCode;
  final String? verificationUrl;
  final String? responseCode;
  final String? responseDescription;

  const FiscalInteraction({
    required this.invoiceId,
    required this.invoiceSeries,
    required this.invoiceNumber,
    required this.issueDate,
    required this.totalAmount,
    required this.status,
    required this.retryCount,
    this.sentAt,
    this.respondedAt,
    this.secureVerificationCode,
    this.verificationUrl,
    this.responseCode,
    this.responseDescription,
  });

  factory FiscalInteraction.fromJson(Map<String, dynamic> json) {
    return FiscalInteraction(
      invoiceId: json['invoiceId'] as String,
      invoiceSeries: json['invoiceSeries'] as String? ?? '',
      invoiceNumber: (json['invoiceNumber'] as num?)?.toInt() ?? 0,
      issueDate: json['issueDate'] as String? ?? '',
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0,
      status: json['status'] as String? ?? '',
      retryCount: (json['retryCount'] as num?)?.toInt() ?? 0,
      sentAt: json['sentAt'] as String?,
      respondedAt: json['respondedAt'] as String?,
      secureVerificationCode: json['secureVerificationCode'] as String?,
      verificationUrl: json['verificationUrl'] as String?,
      responseCode: json['responseCode'] as String?,
      responseDescription: json['responseDescription'] as String?,
    );
  }
}

class InvoiceEmissionResult {
  final BackendInvoiceResponse invoice;
  final FiscalStatusResponse? fiscalStatus;

  const InvoiceEmissionResult({
    required this.invoice,
    required this.fiscalStatus,
  });
}

Map<String, dynamic> decodeJsonObject(String source) {
  return jsonDecode(source) as Map<String, dynamic>;
}

List<Map<String, dynamic>> decodeJsonObjectList(String source) {
  final decoded = jsonDecode(source) as List<dynamic>;
  return decoded.whereType<Map<String, dynamic>>().toList();
}
