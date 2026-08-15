import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/auth_layout_constants.dart';
import 'package:youpass/core/config/app_product_config.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/core/locale/locale_provider.dart';
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
import 'package:youpass/features/auth/presentation/utils/register_otp_flow.dart';
import 'package:youpass/features/auth/presentation/widgets/gender_checkbox_group_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_instagram_icon.dart';
import 'package:youpass/features/auth/presentation/widgets/phone_input_widget.dart';
import 'package:youpass/features/auth/presentation/widgets/register_terms_widget.dart';
import 'package:youpass/features/auth/routes/register_route_args.dart';
import 'package:youpass/l10n/app_localizations.dart';

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

  bool get hasVerifiedOtp =>
      widget.routeArgs?.otpCode != null &&
      widget.routeArgs!.otpCode!.isNotEmpty;

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

  String? validatePhoneStep(AppLocalizations l10n) {
    final country = phoneInputKey.currentState?.currentCountry ??
        CountryCodeList.defaultCountry;
    final phoneDigits = PhoneFormatter.digitsOnly(phoneController.text);
    return PhoneValidators.validateNationalNumber(
      l10n,
      phoneDigits,
      isoCode: country.isoCode,
    );
  }

  String? validateDetailsForm(AppLocalizations l10n) {
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
    if (emailController.text.trim().isEmpty) {
      return l10n.registerEmailRequired;
    }
    if (!termsAccepted) {
      return l10n.registerTermsRequired;
    }

    return null;
  }

  ({String phoneDigits, String countryIsoCode}) resolveVerifiedPhone() {
    final country = phoneInputKey.currentState?.currentCountry ??
        CountryCodeList.defaultCountry;
    final phoneDigits = widget.routeArgs?.phone?.isNotEmpty == true
        ? widget.routeArgs!.phone!
        : PhoneFormatter.digitsOnly(phoneController.text);
    final countryIsoCode = widget.routeArgs?.countryIsoCode?.isNotEmpty == true
        ? widget.routeArgs!.countryIsoCode!
        : country.isoCode;

    return (phoneDigits: phoneDigits, countryIsoCode: countryIsoCode);
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

  Future<void> sendPhoneCodeAndNavigate() async {
    final l10n = context.l10n;
    final validationError = validatePhoneStep(l10n);
    if (validationError != null) {
      AppSnackBar.show(context, validationError);
      return;
    }

    final country = phoneInputKey.currentState?.currentCountry ??
        CountryCodeList.defaultCountry;
    final phoneDigits = PhoneFormatter.digitsOnly(phoneController.text);

    await RegisterOtpFlow.sendCodeAndOpenVerification(
      context: context,
      phoneDigits: phoneDigits,
      countryIsoCode: country.isoCode,
    );
  }

  Future<void> submitRegistration() async {
    final l10n = context.l10n;
    final validationError = validateDetailsForm(l10n);
    if (validationError != null) {
      AppSnackBar.show(context, validationError);
      return;
    }

    final pendingOtpCode = widget.routeArgs?.otpCode;
    if (pendingOtpCode == null || pendingOtpCode.isEmpty) {
      AppSnackBar.show(context, l10n.errorGeneric);
      return;
    }

    final verifiedPhone = resolveVerifiedPhone();
    final authProvider = context.read<AuthProvider>();
    authProvider.markRegistrationStarted();
    await submitRegistrationWithCode(
      authProvider: authProvider,
      phoneDigits: verifiedPhone.phoneDigits,
      countryIsoCode: verifiedPhone.countryIsoCode,
      code: pendingOtpCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (hasVerifiedOtp) {
      return _buildDetailsStep(context);
    }

    return _buildPhoneStep(context);
  }

  Widget _buildPhoneStep(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final strings = context.l10n;
    final authProvider = context.watch<AuthProvider>();
    final localizedError = authProvider.localizedErrorMessage(strings);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PhoneInputWidget(
          key: phoneInputKey,
          phoneController: phoneController,
          initialCountryIsoCode: widget.routeArgs?.countryIsoCode,
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
          label: strings.sendCodeButton,
          isLoading: authProvider.isSubmitting,
          onPressed: sendPhoneCodeAndNavigate,
        ),
      ],
    );
  }

  Widget _buildDetailsStep(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final strings = context.l10n;
    final fieldGap = AuthLayoutConstants.fieldGap(layout);
    final authProvider = context.watch<AuthProvider>();
    final localizedError = authProvider.localizedErrorMessage(strings);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AbsorbPointer(
          child: PhoneInputWidget(
            key: phoneInputKey,
            phoneController: phoneController,
            initialCountryIsoCode: widget.routeArgs?.countryIsoCode,
          ),
        ),
        SizedBox(height: fieldGap),
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
          onPressed: submitRegistration,
        ),
      ],
    );
  }
}
