import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_wallet_section_widget.dart';

class ProfileWalletScreen extends StatelessWidget {
  const ProfileWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final horizontalPadding =
        ProfileDesignSpec.px(context, ProfileDesignSpec.horizontalPadding);

    return Scaffold(
      backgroundColor: ProfileDesignSpec.screenBackground,
      appBar: AppBar(
        backgroundColor: ProfileDesignSpec.screenBackground,
        surfaceTintColor: ProfileDesignSpec.screenBackground,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            color: ProfileDesignSpec.primary,
            size: ProfileDesignSpec.px(context, ProfileDesignSpec.backIconSize),
          ),
        ),
        title: Text(
          AppStrings.profileWalletSection(strings),
          style: TextStyle(
            fontSize: ProfileDesignSpec.px(
              context,
              ProfileDesignSpec.appBarTitleSize,
            ),
            fontWeight: FontWeight.w700,
            color: ProfileDesignSpec.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          ProfileDesignSpec.px(context, 8),
          horizontalPadding,
          ProfileDesignSpec.px(context, 24),
        ),
        child: const ProfileWalletSectionWidget(),
      ),
    );
  }
}
