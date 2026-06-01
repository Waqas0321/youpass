import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/auth_icon_text_field.dart';
import 'package:youpass/core/widgets/auth_picker_field.dart';
import 'package:youpass/core/widgets/youpass_primary_button.dart';
import 'package:youpass/features/auth/presentation/widgets/gender_picker_sheet.dart';
import 'package:youpass/features/auth/presentation/widgets/phone_input_widget.dart';
import 'package:youpass/features/auth/presentation/widgets/register_terms_widget.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({super.key});

  @override
  State<RegisterFormWidget> createState() => RegisterFormWidgetState();
}

class RegisterFormWidgetState extends State<RegisterFormWidget> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController idDocumentController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();

  DateTime? birthDate;
  String? selectedGender;
  bool termsAccepted = false;

  @override
  void dispose() {
    fullNameController.dispose();
    idDocumentController.dispose();
    phoneController.dispose();
    emailController.dispose();
    instagramController.dispose();
    super.dispose();
  }

  String? formatBirthDate() {
    if (birthDate == null) {
      return null;
    }

    return DateFormat.yMMMd().format(birthDate!);
  }

  Future<void> pickBirthDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: birthDate ?? DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (pickedDate != null) {
      setState(() => birthDate = pickedDate);
    }
  }

  Future<void> pickGender() async {
    final gender = await GenderPickerSheet.show(context);

    if (gender != null) {
      setState(() => selectedGender = gender);
    }
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final strings = context.l10n;
    final fieldGap = layout.spacing(20);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthIconTextField(
          label: strings.fullNameLabel,
          controller: fullNameController,
          hintText: strings.fullNameHint,
          icon: Icons.person_outline,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: fieldGap),
        AuthIconTextField(
          label: strings.idDocumentLabel,
          controller: idDocumentController,
          hintText: strings.idDocumentHint,
          icon: Icons.badge_outlined,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: fieldGap),
        AuthPickerField(
          label: strings.birthDateLabel,
          hintText: strings.birthDateHint,
          icon: Icons.calendar_today_outlined,
          value: formatBirthDate(),
          onTap: pickBirthDate,
        ),
        SizedBox(height: fieldGap),
        AuthPickerField(
          label: strings.genderLabel,
          hintText: strings.genderHint,
          icon: Icons.person_outline,
          value: selectedGender,
          onTap: pickGender,
        ),
        SizedBox(height: fieldGap),
        PhoneInputWidget(phoneController: phoneController),
        SizedBox(height: fieldGap),
        AuthIconTextField(
          label: strings.emailLabel,
          controller: emailController,
          hintText: strings.emailHint,
          icon: Icons.mail_outline,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: fieldGap),
        AuthIconTextField(
          label: strings.instagramLabel,
          controller: instagramController,
          hintText: strings.instagramHint,
          icon: Icons.camera_alt_outlined,
          textInputAction: TextInputAction.done,
        ),
        SizedBox(height: layout.spacing(24)),
        RegisterTermsWidget(
          isAccepted: termsAccepted,
          onChanged: (value) => setState(() => termsAccepted = value),
        ),
        SizedBox(height: layout.spacing(24)),
        YouPassPrimaryButton(
          label: strings.createAccountButton,
          onPressed: () {},
        ),
      ],
    );
  }
}
