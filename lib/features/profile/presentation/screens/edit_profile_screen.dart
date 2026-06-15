import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/auth/gender_api_mapper.dart';
import 'package:youpass/core/config/app_product_config.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/constants/auth_layout_constants.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_snack_bar.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/auth_icon_text_field.dart';
import 'package:youpass/core/widgets/auth_picker_field.dart';
import 'package:youpass/core/widgets/youpass_outline_button.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/auth/domain/entities/user_profile_entity.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/auth/presentation/widgets/gender_picker_sheet.dart';
import 'package:youpass/features/profile/data/services/profile_api_service.dart';
import 'package:youpass/features/home/presentation/utils/app_drawer_navigation.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_app_bar_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.profile});

  final UserProfileEntity profile;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late final TextEditingController fullNameController;
  late final TextEditingController emailController;
  late final TextEditingController instagramController;
  late DateTime? birthdate;
  late String genderValue;
  bool isSaving = false;
  String? errorText;

  final profileApi = sl<ProfileApiService>();

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController(text: widget.profile.fullName);
    emailController = TextEditingController(text: widget.profile.email);
    instagramController = TextEditingController(
      text: widget.profile.instagramUsername ?? '',
    );
    birthdate = ProfileUpdatePayload.parseBirthdate(widget.profile.birthdate);
    genderValue = widget.profile.gender;
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    instagramController.dispose();
    super.dispose();
  }

  String? formatBirthDate(BuildContext context) {
    if (birthdate == null) {
      return null;
    }

    final locale = Localizations.localeOf(context).toString();
    return DateFormat.yMMMd(locale).format(birthdate!);
  }

  Future<void> pickBirthdate() async {
    final now = DateTime.now();
    final minAge = AppProductConfig.registration.minAgeYears;
    final maxBirthDate = DateTime(now.year - minAge, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: birthdate ?? maxBirthDate,
      firstDate: DateTime(1900),
      lastDate: maxBirthDate,
    );

    if (picked != null) {
      setState(() => birthdate = picked);
    }
  }

  Future<void> pickGender() async {
    final gender = await GenderPickerSheet.show(context);

    if (gender != null) {
      setState(() => genderValue = gender);
    }
  }

  Future<void> save() async {
    final strings = context.l10n;
    final name = fullNameController.text.trim();
    final email = emailController.text.trim();

    if (name.length < 2 || !email.contains('@') || birthdate == null) {
      setState(() => errorText = strings.errorGeneric);
      return;
    }

    if (ProfileUpdatePayload.ageFromBirthdate(birthdate!) < 18) {
      setState(() => errorText = strings.errorGeneric);
      return;
    }

    setState(() {
      isSaving = true;
      errorText = null;
    });

    try {
      await profileApi.updateProfile(
        ProfileUpdatePayload(
          fullName: name,
          email: email,
          birthdate: ProfileUpdatePayload.formatBirthdateForApi(birthdate!),
          gender: genderValue,
          instagramUsername: ProfileUpdatePayload.normalizeInstagram(
            instagramController.text,
          ),
        ).toJson(),
      );

      if (!mounted) {
        return;
      }

      await context.read<AuthProvider>().refreshUserProfile();
      if (!mounted) {
        return;
      }

      AppSnackBar.show(context, AppStrings.profileSaved(strings));
      Navigator.of(context).pop(true);
    } catch (_) {
      if (mounted) {
        setState(() => errorText = strings.errorGeneric);
      }
    } finally {
      if (mounted) {
        setState(() => isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final layout = ResponsiveLayout(context);
    final fieldGap = AuthLayoutConstants.fieldGap(layout);
    final theme = ProfileTheme.of(context);
    final horizontalPadding =
        ProfileDesignSpec.px(context, ProfileDesignSpec.horizontalPadding);

    return AppDrawerNavigation.wrap(
      scaffoldKey: scaffoldKey,
      context: context,
      backgroundColor: theme.screenBackground,
      appBar: ProfileAppBarWidget(
        title: AppStrings.profileEditTitle(strings),
        onBack: () => Navigator.of(context).pop(),
        onMenuTap: () => AppDrawerNavigation.openDrawer(context, scaffoldKey),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          layout.spacing(16),
          horizontalPadding,
          MediaQuery.paddingOf(context).bottom + layout.spacing(24),
        ),
        child: Column(
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
              label: strings.emailLabel,
              controller: emailController,
              hintText: strings.emailHint,
              icon: Icons.mail_outline,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: fieldGap),
            AuthPickerField(
              label: strings.birthDateLabel,
              hintText: strings.birthDateHint,
              icon: Icons.calendar_today_outlined,
              value: formatBirthDate(context),
              onTap: pickBirthdate,
            ),
            SizedBox(height: fieldGap),
            AuthPickerField(
              label: strings.genderLabel,
              hintText: strings.genderHint,
              icon: Icons.person_outline,
              value: GenderApiMapper.toDisplayLabel(genderValue, strings),
              onTap: pickGender,
            ),
            SizedBox(height: fieldGap),
            AuthIconTextField(
              label: strings.instagramLabel,
              controller: instagramController,
              hintText: strings.instagramHint,
              icon: Icons.camera_alt_outlined,
              textInputAction: TextInputAction.done,
            ),
            if (errorText != null) ...[
              SizedBox(height: layout.spacing(12)),
              AppText(
                errorText!,
                variant: AppTextVariant.error,
              ),
            ],
            SizedBox(height: layout.spacing(24)),
            YouPassOutlineButton(
              label: AppStrings.profileSave(strings),
              icon: Icons.save_outlined,
              isLoading: isSaving,
              onPressed: save,
            ),
          ],
        ),
      ),
    );
  }
}
