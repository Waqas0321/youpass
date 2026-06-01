import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_button.dart';
import 'package:youpass/core/widgets/app_loader.dart';
import 'package:youpass/core/widgets/app_scaffold.dart';
import 'package:youpass/core/widgets/auth_content_container.dart';
import 'package:youpass/features/auth/domain/entities/user_entity.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';
import 'package:youpass/features/home/presentation/widgets/home_content_widget.dart';
import 'package:youpass/features/home/presentation/widgets/home_header_widget.dart';
import 'package:youpass/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().loadHomeData();
    });
  }

  Future<void> handleLogout() async {
    await context.read<AuthProvider>().logout();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final homeProvider = context.watch<HomeProvider>();
    final user = authProvider.currentUser;
    final layout = ResponsiveLayout(context);

    return AppScaffold(
      title: context.l10n.homeTitle,
      body: AuthContentContainer(
        child: Padding(
          padding: layout.screenPadding,
          child: buildBody(homeProvider, user, layout),
        ),
      ),
    );
  }

  Widget buildBody(
    HomeProvider homeProvider,
    UserEntity? user,
    ResponsiveLayout layout,
  ) {
    if (homeProvider.status == HomeStatus.loading) {
      return const AppLoader();
    }

    if (homeProvider.status == HomeStatus.error) {
      return Center(
        child: AppText(
          homeProvider.errorMessage ?? context.l10n.errorGeneric,
          variant: AppTextVariant.error,
        ),
      );
    }

    if (homeProvider.homeData == null || user == null) {
      return const AppLoader();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HomeHeaderWidget(homeData: homeProvider.homeData!),
        SizedBox(height: layout.spacing(24)),
        HomeContentWidget(user: user),
        const Spacer(),
        AppButton(label: context.l10n.logoutButton, onPressed: handleLogout),
      ],
    );
  }
}
