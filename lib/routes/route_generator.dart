import 'package:flutter/material.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/domain/entities/post_registration_navigation_entity.dart';
import 'package:youpass/features/auth/domain/entities/welcome_entity.dart';
import 'package:youpass/features/auth/presentation/screens/login_screen.dart';
import 'package:youpass/features/auth/presentation/screens/register_screen.dart';
import 'package:youpass/features/auth/presentation/screens/splash_screen.dart';
import 'package:youpass/features/auth/presentation/screens/verification_screen.dart';
import 'package:youpass/features/auth/presentation/screens/welcome_screen.dart';
import 'package:youpass/features/auth/routes/welcome_route_args.dart';
import 'package:youpass/features/auth/routes/verification_route_args.dart';
import 'package:youpass/features/home/presentation/screens/main_shell_screen.dart';
import 'package:youpass/features/home/presentation/screens/party_drink_menu_screen.dart';
import 'package:youpass/features/home/presentation/screens/party_drink_courtesies_screen.dart';
import 'package:youpass/features/home/presentation/screens/party_drink_purchases_screen.dart';
import 'package:youpass/features/home/presentation/screens/party_drink_purchase_success_screen.dart';
import 'package:youpass/features/home/presentation/party_drinks/routes/party_drink_menu_route_args.dart';
import 'package:youpass/features/home/presentation/party_drinks/routes/party_drink_purchase_success_route_args.dart';
import 'package:youpass/features/profile/presentation/screens/profile_screen.dart';
import 'package:youpass/features/profile/presentation/screens/change_phone_screen.dart';
import 'package:youpass/features/profile/presentation/screens/profile_wallet_screen.dart';
import 'package:youpass/features/profile/presentation/screens/category_benefits_screen.dart';
import 'package:youpass/features/profile/presentation/routes/faq_route_args.dart';
import 'package:youpass/features/profile/presentation/screens/faq_screen.dart';
import 'package:youpass/features/profile/presentation/screens/notification_advanced_settings_screen.dart';
import 'package:youpass/features/events/presentation/routes/all_events_route_args.dart';
import 'package:youpass/features/events/presentation/screens/all_events_screen.dart';
import 'package:youpass/features/events/presentation/routes/event_detail_route_args.dart';
import 'package:youpass/features/events/presentation/screens/event_detail_screen.dart';
import 'package:youpass/features/favorites/presentation/routes/producer_events_route_args.dart';
import 'package:youpass/features/favorites/presentation/screens/my_favorites_screen.dart';
import 'package:youpass/features/favorites/presentation/screens/producer_events_screen.dart';
import 'package:youpass/features/vip_venue/presentation/routes/vip_purchase_route_args.dart';
import 'package:youpass/features/vip_venue/presentation/screens/floor_plan_screen.dart';
import 'package:youpass/features/vip_venue/presentation/screens/purchase_summary_screen.dart';
import 'package:youpass/features/vip_venue/presentation/screens/table_selection_screen.dart';
import 'package:youpass/features/vip_venue/presentation/screens/ticket_selection_screen.dart';
import 'package:youpass/features/tickets/presentation/screens/my_tickets_screen.dart';
import 'package:youpass/features/ticket_assignment/presentation/routes/assign_tickets_route_args.dart';
import 'package:youpass/features/ticket_assignment/presentation/routes/invitation_claim_route_args.dart';
import 'package:youpass/features/ticket_assignment/presentation/screens/assign_tickets_screen.dart';
import 'package:youpass/features/ticket_assignment/presentation/screens/invitation_claim_screen.dart';
import 'package:youpass/features/invitations/presentation/routes/event_ticket_route_args.dart';
import 'package:youpass/features/invitations/presentation/screens/event_ticket_screen.dart';
import 'package:youpass/features/invitations/presentation/screens/guaranteed_pass_active_screen.dart';
import 'package:youpass/features/invitations/presentation/screens/invitation_detail_screen.dart';
import 'package:youpass/features/invitations/presentation/screens/my_invitations_screen.dart';
import 'package:youpass/features/invitations/presentation/routes/guaranteed_pass_active_route_args.dart';
import 'package:youpass/features/invitations/presentation/routes/invitation_detail_route_args.dart';
import 'package:youpass/core/widgets/route_not_found_screen.dart';
import 'package:youpass/routes/app_routes.dart';
import 'package:youpass/staff_app/routes/staff_route_generator.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final staffRoute = StaffRouteGenerator.maybeGenerate(settings);
    if (staffRoute != null) {
      return staffRoute;
    }

    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const RegisterScreen(),
        );
      case AppRoutes.verification:
        final args = settings.arguments;
        final verificationArgs = args is VerificationRouteArgs
            ? args
            : VerificationRouteArgs(
                phone: '912345678',
                countryIsoCode: CountryCodeList.defaultCountry.isoCode,
                purpose: OtpPurpose.login,
                phoneDisplay: '+56 9 1234 5678',
                resendCooldownSeconds: 60,
              );
        return MaterialPageRoute<bool>(
          settings: settings,
          builder: (_) => VerificationScreen(args: verificationArgs),
        );
      case AppRoutes.welcome:
        final args = settings.arguments;
        final welcomeArgs = args is WelcomeRouteArgs
            ? args
            : const WelcomeRouteArgs(
                welcome: WelcomeEntity(
                  title: '',
                  subtitle: '',
                  durationSeconds: 2,
                ),
                navigation: PostRegistrationNavigationEntity(),
              );
        return MaterialPageRoute(
          builder: (_) => WelcomeScreen(args: welcomeArgs),
        );
      case AppRoutes.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const MainShellScreen(),
        );
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case AppRoutes.profileWallet:
        return MaterialPageRoute(builder: (_) => const ProfileWalletScreen());
      case AppRoutes.profileBenefits:
        return MaterialPageRoute(builder: (_) => const CategoryBenefitsScreen());
      case AppRoutes.profileFaq:
        final args = settings.arguments;
        final faqArgs = args is FaqRouteArgs ? args : null;
        return MaterialPageRoute(
          builder: (_) => FaqScreen(contact: faqArgs?.contact),
        );
      case AppRoutes.profileNotificationAdvanced:
        return MaterialPageRoute(
          builder: (_) => const NotificationAdvancedSettingsScreen(),
        );
      case AppRoutes.profileChangePhone:
        return MaterialPageRoute<bool>(
          settings: settings,
          builder: (_) => const ChangePhoneScreen(),
        );
      case AppRoutes.myTickets:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const MyTicketsScreen(),
        );
      case AppRoutes.myFavorites:
        return MaterialPageRoute(builder: (_) => const MyFavoritesScreen());
      case AppRoutes.producerEvents:
        final args = settings.arguments;
        if (args is! ProducerEventsRouteArgs) {
          return MaterialPageRoute(builder: (_) => const MyFavoritesScreen());
        }
        return MaterialPageRoute(
          builder: (_) => ProducerEventsScreen.fromRouteArgs(args),
        );
      case AppRoutes.allEvents:
        final args = settings.arguments;
        final allEventsArgs = args is AllEventsRouteArgs
            ? args
            : const AllEventsRouteArgs();
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AllEventsScreen(args: allEventsArgs),
        );
      case AppRoutes.eventDetail:
        final args = settings.arguments;
        if (args is! EventDetailRouteArgs) {
          return MaterialPageRoute(builder: (_) => const MainShellScreen());
        }
        return MaterialPageRoute(
          builder: (_) => EventDetailScreen.fromRouteArgs(args),
        );
      case AppRoutes.vipTicketSelection:
        final args = settings.arguments;
        if (args is! VipPurchaseRouteArgs) {
          return MaterialPageRoute(builder: (_) => const MainShellScreen());
        }
        return MaterialPageRoute(
          builder: (_) => TicketSelectionScreen.fromRouteArgs(args),
        );
      case AppRoutes.vipFloorPlan:
        final args = settings.arguments;
        if (args is! VipPurchaseRouteArgs) {
          return MaterialPageRoute(builder: (_) => const MainShellScreen());
        }
        return MaterialPageRoute(
          builder: (_) => FloorPlanScreen.fromRouteArgs(args),
        );
      case AppRoutes.vipTableSelection:
        final args = settings.arguments;
        if (args is! VipPurchaseRouteArgs) {
          return MaterialPageRoute(builder: (_) => const MainShellScreen());
        }
        return MaterialPageRoute(
          builder: (_) => TableSelectionScreen.fromRouteArgs(args),
        );
      case AppRoutes.vipPurchaseSummary:
        final args = settings.arguments;
        if (args is! VipPurchaseRouteArgs) {
          return MaterialPageRoute(builder: (_) => const MainShellScreen());
        }
        return MaterialPageRoute(
          builder: (_) => PurchaseSummaryScreen.fromRouteArgs(args),
        );
      case AppRoutes.myInvitations:
        return MaterialPageRoute(builder: (_) => const MyInvitationsScreen());
      case AppRoutes.partyDrinkMenu:
        final menuArgs = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => PartyDrinkMenuScreen.fromRouteArgs(
            menuArgs is PartyDrinkMenuRouteArgs ? menuArgs : null,
          ),
          settings: settings,
        );
      case AppRoutes.partyDrinkPurchases:
        return MaterialPageRoute(builder: (_) => const PartyDrinkPurchasesScreen());
      case AppRoutes.partyDrinkCourtesies:
        return MaterialPageRoute(builder: (_) => const PartyDrinkCourtesiesScreen());
      case AppRoutes.partyDrinkPurchaseSuccess:
        final args = settings.arguments;
        if (args is! PartyDrinkPurchaseSuccessRouteArgs) {
          return MaterialPageRoute(builder: (_) => const PartyDrinkMenuScreen());
        }
        return MaterialPageRoute(
          builder: (_) => PartyDrinkPurchaseSuccessScreen.fromRouteArgs(args),
        );
      case AppRoutes.guaranteedPassDetail:
      case AppRoutes.invitationDetail:
        final args = settings.arguments;
        if (args is! InvitationDetailRouteArgs) {
          return MaterialPageRoute(builder: (_) => const MyInvitationsScreen());
        }
        return MaterialPageRoute(
          builder: (_) => InvitationDetailScreen(args: args),
        );
      case AppRoutes.guaranteedPassActive:
        final args = settings.arguments;
        if (args is! GuaranteedPassActiveRouteArgs) {
          return MaterialPageRoute(builder: (_) => const MainShellScreen());
        }
        return MaterialPageRoute(
          builder: (_) => GuaranteedPassActiveScreen(args: args),
        );
      case AppRoutes.eventTicket:
        final args = settings.arguments;
        if (args is! EventTicketRouteArgs) {
          return MaterialPageRoute(builder: (_) => const MyInvitationsScreen());
        }
        return MaterialPageRoute(
          builder: (_) => EventTicketScreen.fromRouteArgs(args),
        );
      case AppRoutes.assignTickets:
        final args = settings.arguments;
        if (args is AssignTicketsRouteArgs) {
          return MaterialPageRoute(
            builder: (_) => AssignTicketsScreen(
              ticketId: args.ticketId,
              orderId: args.orderId,
              isVip: args.isVip,
            ),
          );
        }
        return MaterialPageRoute(builder: (_) => const RouteNotFoundScreen());
      case AppRoutes.invitationClaim:
        final args = settings.arguments;
        if (args is InvitationClaimRouteArgs) {
          return MaterialPageRoute(
            builder: (_) => InvitationClaimScreen(token: args.token),
          );
        }
        return MaterialPageRoute(builder: (_) => const RouteNotFoundScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const RouteNotFoundScreen(),
        );
    }
  }
}