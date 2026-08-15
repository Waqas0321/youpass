import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:youpass/staff_app/features/auth/presentation/providers/staff_auth_provider.dart';
import 'package:youpass/staff_app/features/home/presentation/providers/staff_work_mode_provider.dart';

void syncStaffWorkModeFromAuth(BuildContext context) {
  final profile = context.read<StaffAuthProvider>().profile;
  context.read<StaffWorkModeProvider>().syncForProfile(profile);
}
