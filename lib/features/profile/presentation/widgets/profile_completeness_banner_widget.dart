import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';

class ProfileCompletenessBannerWidget extends StatelessWidget {
  const ProfileCompletenessBannerWidget({
    super.key,
    required this.completionPercentage,
    required this.missingFields,
    required this.onCompleteTap,
    required this.onDismissTap,
  });

  final int completionPercentage;
  final List<String> missingFields;
  final VoidCallback onCompleteTap;
  final VoidCallback onDismissTap;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = ProfileTheme.of(context);
    final missingPhoto = missingFields.contains('profile_photo');
    final missingInstagram = missingFields.contains('instagram_username');

    final subtitle = missingPhoto && missingInstagram
        ? AppStrings.profileCompleteBannerSubtitleBoth(strings)
        : missingPhoto
            ? AppStrings.profileCompleteBannerSubtitlePhoto(strings)
            : AppStrings.profileCompleteBannerSubtitleInstagram(strings);

    final radius = ProfileDesignSpec.px(context, 12);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          colors: [theme.bannerGradientStart, theme.bannerGradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: theme.bannerBorder),
      ),
      padding: EdgeInsets.all(ProfileDesignSpec.px(context, 14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.checklist_rtl,
                color: theme.primary,
                size: ProfileDesignSpec.px(context, 22),
              ),
              SizedBox(width: ProfileDesignSpec.px(context, 10)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.profileCompleteBannerTitle(strings),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: ProfileDesignSpec.px(context, 15),
                        color: theme.bannerTitleText,
                      ),
                    ),
                    SizedBox(height: ProfileDesignSpec.px(context, 4)),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: ProfileDesignSpec.px(context, 13),
                        color: theme.bannerSubtitleText,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onDismissTap,
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  Icons.close,
                  size: ProfileDesignSpec.px(context, 20),
                  color: theme.bannerSubtitleText,
                ),
              ),
            ],
          ),
          SizedBox(height: ProfileDesignSpec.px(context, 12)),
          ClipRRect(
            borderRadius: BorderRadius.circular(ProfileDesignSpec.px(context, 4)),
            child: LinearProgressIndicator(
              value: completionPercentage / 100,
              minHeight: ProfileDesignSpec.px(context, 6),
              backgroundColor: theme.isDark
                  ? theme.sectionCardBorder
                  : Colors.white.withValues(alpha: 0.6),
              color: theme.primary,
            ),
          ),
          SizedBox(height: ProfileDesignSpec.px(context, 4)),
          Text(
            '$completionPercentage%',
            style: TextStyle(
              fontSize: ProfileDesignSpec.px(context, 12),
              fontWeight: FontWeight.w600,
              color: theme.primary,
            ),
          ),
          SizedBox(height: ProfileDesignSpec.px(context, 10)),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onCompleteTap,
              style: TextButton.styleFrom(
                backgroundColor: theme.primary,
                foregroundColor: theme.bannerCompleteButtonForeground,
                padding: EdgeInsets.symmetric(
                  horizontal: ProfileDesignSpec.px(context, 18),
                  vertical: ProfileDesignSpec.px(context, 8),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ProfileDesignSpec.px(context, 8)),
                ),
              ),
              child: Text(
                AppStrings.profileCompleteBannerButton(strings),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: ProfileDesignSpec.px(context, 13),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
