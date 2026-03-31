import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Verifactu register payload', () {
    Map<String, dynamic> buildPayload({
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
    }) {
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
      return payload;
    }

    test('without previous hash, payload does not include clientHash', () {
      final payload = buildPayload(
        companyName: 'Empresa Demo',
        taxId: 'B12345678',
        address: 'Calle Mayor 1',
        email: 'demo@novapay.test',
        password: 'NovaPaySeguro123!',
        passwordConfirmation: 'NovaPaySeguro123!',
        planCode: 'PLAN_5000',
        billingCycle: 'MONTHLY',
        isNewSystem: true,
        clientHash: null,
      );

      expect(payload['isNewSystem'], isTrue);
      expect(payload.containsKey('clientHash'), isFalse);

      final asJson = jsonEncode(payload);
      expect(asJson.contains('clientHash'), isFalse);
    });

    test('with previous hash, payload includes clientHash', () {
      final payload = buildPayload(
        companyName: 'Empresa Demo',
        taxId: 'B12345678',
        address: 'Calle Mayor 1',
        email: 'demo@novapay.test',
        password: 'NovaPaySeguro123!',
        passwordConfirmation: 'NovaPaySeguro123!',
        planCode: 'PLAN_8000',
        billingCycle: 'YEARLY',
        isNewSystem: false,
        clientHash: 'abc123hash',
      );

      expect(payload['isNewSystem'], isFalse);
      expect(payload['clientHash'], 'abc123hash');
    });
  });
}
