import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/auth_layout_constants.dart';
import 'package:youpass/core/config/app_product_config.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/core/locale/locale_provider.dart';
import 'package:youpass/core/locale/locale_sync_helper.dart';
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
import 'package:youpass/features/auth/domain/entities/register_request_entity.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/auth/presentation/utils/auth_navigation.dart';
import 'package:youpass/features/auth/presentation/utils/whatsapp_auth_gate.dart';
import 'package:youpass/features/auth/presentation/widgets/gender_checkbox_group_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_instagram_icon.dart';
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

    final initialCountry = widget.routeArgs?.countryIsoCode;
    if (initialCountry != null && initialCountry.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          LocaleSyncHelper.applyCountryIso(context, initialCountry);
        }
      });
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

  String? formatBirthDate(BuildContext context) {
    if (birthDate == null) {
      return null;
    }

    final locale = Localizations.localeOf(context).toString();
    return DateFormat.yMMMd(locale).format(birthDate!);
  }

  String formatBirthDateApi() {
    if (birthDate == null) {
      return '';
    }

    return DateFormat('yyyy-MM-dd').format(birthDate!);
  }

  Future<void> pickBirthDate() async {
    final now = DateTime.now();
    final minAge = AppProductConfig.registration.minAgeYears;
    final maxBirthDate = DateTime(now.year - minAge, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: birthDate ?? maxBirthDate,
      firstDate: DateTime(1900),
      lastDate: maxBirthDate,
    );

    if (pickedDate != null) {
      setState(() => birthDate = pickedDate);
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

  Future<void> submitRegistrationWithCode({
    required AuthProvider authProvider,
    required String phoneDigits,
    required String countryIsoCode,
    required String code,
  }) async {
    final l10n = context.l10n;
    final success = await authProvider.registerAccount(
      RegisterRequestEntity(
        phone: phoneDigits,
        countryIsoCode: countryIsoCode,
        code: code,
        fullName: fullNameController.text.trim(),
        documentId: idDocumentController.text.trim(),
        birthDate: formatBirthDateApi(),
        gender: selectedGender!,
        email: emailController.text.trim(),
        instagram: instagramController.text.trim(),
        acceptTerms: termsAccepted,
        preferredLanguage: context.read<LocaleProvider>().locale.languageCode,
      ),
    );

    if (!mounted) {
      return;
    }

    if (success) {
      AuthNavigation.completeOneTimeLogin(
        context,
        purpose: OtpPurpose.register,
      );
      return;
    }

    final message =
        authProvider.localizedErrorMessage(l10n) ?? l10n.errorGeneric;
    AppSnackBar.show(context, message);
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
    final pendingOtpCode = widget.routeArgs?.otpCode;

    if (pendingOtpCode != null && pendingOtpCode.isNotEmpty) {
      authProvider.markRegistrationStarted();
      await submitRegistrationWithCode(
        authProvider: authProvider,
        phoneDigits: phoneDigits,
        countryIsoCode: country.isoCode,
        code: pendingOtpCode,
      );
      return;
    }

    authProvider.markRegistrationStarted();

    final draft = RegisterDraft(
      fullName: fullNameController.text.trim(),
      documentId: idDocumentController.text.trim(),
      birthDate: formatBirthDateApi(),
      gender: selectedGender!,
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

    if (!WhatsAppAuthGate.canSendOtp(whatsAppCheck)) {
      final message = WhatsAppAuthGate.unavailableMessage(whatsAppCheck);
      AppSnackBar.show(
        context,
        message.isNotEmpty ? message : l10n.errorWhatsAppRequired,
      );
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

    final args = VerificationRouteArgs(
      phone: phoneDigits,
      countryIsoCode: country.isoCode,
      purpose: result.effectivePurpose,
      phoneDisplay: result.phoneDisplay,
      resendCooldownSeconds: result.resendAvailableInSeconds,
      expiresInSeconds: result.expiresInSeconds,
      deliveryChannel: 'whatsapp',
      statusMessage: whatsAppCheck.message.isNotEmpty
          ? whatsAppCheck.message
          : OtpDeliveryMessage.sentConfirmation(l10n),
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
          value: formatBirthDate(context),
          onTap: pickBirthDate,
        ),
        SizedBox(height: fieldGap),
        GenderCheckboxGroupWidget(
          selectedValue: selectedGender,
          onChanged: (value) => setState(() => selectedGender = value),
        ),
        SizedBox(height: fieldGap),
        PhoneInputWidget(
          key: phoneInputKey,
          phoneController: phoneController,
          initialCountryIsoCode: widget.routeArgs?.countryIsoCode,
          onCountryChanged: (country) => LocaleSyncHelper.applyCountry(context, country),
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
          leading: ProfileInstagramIcon(
            color: Theme.of(context)
                .colorScheme
                .onSurfaceVariant
                .withValues(alpha: 0.7),
            size: layout.fontSize(22),
          ),
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
          isEnabled: termsAccepted,
          onPressed: sendCodeAndNavigate,
        ),
      ],
    );
  }
}
