// lib/presentation/pages/admin/sections/personal_area_section.dart
import 'package:flutter/material.dart';

import '../../../../data/models/user.dart';
import '../../../widgets/profile/profile_form_widget.dart';

class PersonalAreaSection extends StatelessWidget {
  final User user;
  final VoidCallback? onOpenVerifactu;

  const PersonalAreaSection({super.key, required this.user, this.onOpenVerifactu});

  @override
  Widget build(BuildContext context) {
    return ProfileFormWidget(user: user, isAdminContext: true, onOpenVerifactu: onOpenVerifactu);
  }
}
