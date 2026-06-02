import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/auth_layout_constants.dart';
import 'package:youpass/core/auth/gender_api_mapper.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/core/l10n/otp_delivery_message.dart';
import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/auth_error_extension.dart';
import 'package:youpass/core/widgets/app_snack_bar.dart';
import 'package:youpass/core/utils/phone_formatter.dart';
import 'package:youpass/core/utils/phone_validators.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/auth_icon_text_field.dart';
import 'package:youpass/core/widgets/auth_picker_field.dart';
import 'package:youpass/core/widgets/youpass_primary_button.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/auth/presentation/widgets/gender_picker_sheet.dart';
import 'package:youpass/features/auth/presentation/widgets/phone_input_widget.dart';
import 'package:youpass/features/auth/presentation/widgets/register_terms_widget.dart';
import 'package:youpass/features/auth/routes/register_draft.dart';
import 'package:youpass/features/auth/routes/register_route_args.dart';
import 'package:youpass/features/auth/routes/verification_route_args.dart';
import 'package:youpass/l10n/app_localizations.dart';
import 'package:youpass/routes/app_routes.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({this.routeArgs, super.key});

  final RegisterRouteArgs? routeArgs;

  @override
  State<RegisterFormWidget> createState() => RegisterFormWidgetState();
}

class RegisterFormWidgetState extends State<RegisterFormWidget> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController idDocumentController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final GlobalKey<PhoneInputWidgetState> phoneInputKey =
      GlobalKey<PhoneInputWidgetState>();

  DateTime? birthDate;
  String? selectedGender;
  bool termsAccepted = false;

  bool get codeAlreadySent => widget.routeArgs?.codeAlreadySent ?? false;

  @override
  void initState() {
    super.initState();
    final prefill = widget.routeArgs?.phone;
    if (prefill != null && prefill.isNotEmpty) {
      phoneController.text = prefill;
    }
  }

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

  String formatBirthDateApi() {
    if (birthDate == null) {
      return '';
    }

    return DateFormat('yyyy-MM-dd').format(birthDate!);
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

  String? validateForm(AppLocalizations l10n) {
    if (fullNameController.text.trim().isEmpty) {
      return l10n.registerFullNameRequired;
    }
    if (idDocumentController.text.trim().isEmpty) {
      return l10n.registerIdDocumentRequired;
    }
    if (birthDate == null) {
      return l10n.registerBirthDateRequired;
    }
    if (selectedGender == null) {
      return l10n.registerGenderRequired;
    }

    final country = phoneInputKey.currentState?.currentCountry ??
        CountryCodeList.defaultCountry;
    final phoneDigits = PhoneFormatter.digitsOnly(phoneController.text);
    final phoneError = PhoneValidators.validateNationalNumber(
      l10n,
      phoneDigits,
      isoCode: country.isoCode,
    );
    if (phoneError != null) {
      return phoneError;
    }
    if (emailController.text.trim().isEmpty) {
      return l10n.registerEmailRequired;
    }
    if (!termsAccepted) {
      return l10n.registerTermsRequired;
    }

    return null;
  }

  Future<void> sendCodeAndNavigate() async {
    final l10n = context.l10n;
    final validationError = validateForm(l10n);
    if (validationError != null) {
      AppSnackBar.show(context, validationError);
      return;
    }

    final country = phoneInputKey.currentState?.currentCountry ??
        CountryCodeList.defaultCountry;
    final phoneDigits = PhoneFormatter.digitsOnly(phoneController.text);
    final authProvider = context.read<AuthProvider>();
    final draft = RegisterDraft(
      fullName: fullNameController.text.trim(),
      documentId: idDocumentController.text.trim(),
      birthDate: formatBirthDateApi(),
      gender: GenderApiMapper.toApiValue(selectedGender!, l10n),
      email: emailController.text.trim(),
      instagram: instagramController.text.trim(),
      acceptTerms: termsAccepted,
    );

    if (codeAlreadySent) {
      final prefill = widget.routeArgs!;
      final args = VerificationRouteArgs(
        phone: phoneDigits,
        countryIsoCode: country.isoCode,
        purpose: OtpPurpose.register,
        phoneDisplay: prefill.phoneDisplay ?? resultPhoneDisplay(country, phoneDigits),
        resendCooldownSeconds: prefill.resendCooldownSeconds,
        deliveryChannel: 'whatsapp',
        registerDraft: draft,
      );

      if (!mounted) {
        return;
      }

      Navigator.of(context).pushNamed(
        AppRoutes.verification,
        arguments: args,
      );
      return;
    }

    final whatsAppCheck = await authProvider.checkWhatsApp(
      phone: phoneDigits,
      countryIsoCode: country.isoCode,
      purpose: OtpPurpose.register,
    );

    if (!mounted) {
      return;
    }

    if (whatsAppCheck == null) {
      final message =
          authProvider.localizedErrorMessage(l10n) ?? l10n.errorGeneric;
      AppSnackBar.show(context, message);
      return;
    }

    final result = await authProvider.sendVerificationCode(
      phone: phoneDigits,
      countryIsoCode: country.isoCode,
      purpose: OtpPurpose.register,
    );

    if (!mounted) {
      return;
    }

    if (result == null) {
      final message =
          authProvider.localizedErrorMessage(l10n) ?? l10n.errorGeneric;
      AppSnackBar.show(context, message);
      return;
    }

    final deliveryChannel =
        result.channel.isNotEmpty ? result.channel : whatsAppCheck.deliveryChannel;

    final args = VerificationRouteArgs(
      phone: phoneDigits,
      countryIsoCode: country.isoCode,
      purpose: result.effectivePurpose,
      phoneDisplay: result.phoneDisplay,
      resendCooldownSeconds: result.resendAvailableInSeconds,
      deliveryChannel: deliveryChannel,
      statusMessage: OtpDeliveryMessage.sentConfirmation(l10n, deliveryChannel),
      registerDraft: draft,
    );

    Navigator.of(context).pushNamed(
      AppRoutes.verification,
      arguments: args,
    );
  }

  String resultPhoneDisplay(CountryCode country, String phoneDigits) {
    return '${country.displayDialCode} $phoneDigits';
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final strings = context.l10n;
    final fieldGap = AuthLayoutConstants.fieldGap(layout);
    final authProvider = context.watch<AuthProvider>();
    final localizedError = authProvider.localizedErrorMessage(strings);

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
        PhoneInputWidget(
          key: phoneInputKey,
          phoneController: phoneController,
          initialCountryIsoCode: widget.routeArgs?.countryIsoCode,
        ),
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
        if (localizedError != null) ...[
          SizedBox(height: layout.spacing(12)),
          AppText(
            localizedError,
            variant: AppTextVariant.error,
          ),
        ],
        SizedBox(height: layout.spacing(24)),
        YouPassPrimaryButton(
          label: strings.createAccountButton,
          isLoading: authProvider.isSubmitting,
          onPressed: sendCodeAndNavigate,
        ),
      ],
    );
  }
}
