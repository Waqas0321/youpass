import 'package:flutter/material.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/domain/entities/welcome_entity.dart';
import 'package:youpass/features/auth/presentation/screens/login_screen.dart';
import 'package:youpass/features/auth/presentation/screens/register_screen.dart';
import 'package:youpass/features/auth/presentation/screens/splash_screen.dart';
import 'package:youpass/features/auth/presentation/screens/verification_screen.dart';
import 'package:youpass/features/auth/presentation/screens/welcome_screen.dart';
import 'package:youpass/features/auth/routes/welcome_route_args.dart';
import 'package:youpass/features/auth/routes/verification_route_args.dart';
import 'package:youpass/features/home/presentation/screens/home_screen.dart';
import 'package:youpass/features/profile/presentation/screens/profile_screen.dart';
import 'package:youpass/features/profile/presentation/screens/profile_wallet_screen.dart';
import 'package:youpass/features/events/presentation/routes/all_events_route_args.dart';
import 'package:youpass/features/events/presentation/screens/all_events_screen.dart';
import 'package:youpass/features/favorites/presentation/routes/producer_events_route_args.dart';
import 'package:youpass/features/favorites/presentation/screens/my_favorites_screen.dart';
import 'package:youpass/features/favorites/presentation/screens/producer_events_screen.dart';
import 'package:youpass/features/tickets/presentation/screens/my_tickets_screen.dart';
import 'package:youpass/features/ticket_assignment/presentation/routes/assign_tickets_route_args.dart';
import 'package:youpass/features/ticket_assignment/presentation/routes/invitation_claim_route_args.dart';
import 'package:youpass/features/ticket_assignment/presentation/screens/assign_tickets_screen.dart';
import 'package:youpass/features/ticket_assignment/presentation/screens/invitation_claim_screen.dart';
import 'package:youpass/features/invitations/presentation/routes/event_ticket_route_args.dart';
import 'package:youpass/features/invitations/presentation/screens/event_ticket_screen.dart';
import 'package:youpass/features/invitations/presentation/screens/my_invitations_screen.dart';
import 'package:youpass/core/widgets/route_not_found_screen.dart';
import 'package:youpass/routes/app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
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
        return MaterialPageRoute(
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
              );
        return MaterialPageRoute(
          builder: (_) => WelcomeScreen(args: welcomeArgs),
        );
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case AppRoutes.profileWallet:
        return MaterialPageRoute(builder: (_) => const ProfileWalletScreen());
      case AppRoutes.myTickets:
        return MaterialPageRoute(builder: (_) => const MyTicketsScreen());
      case AppRoutes.myFavorites:
        return MaterialPageRoute(builder: (_) => const MyFavoritesScreen());
      case AppRoutes.allEvents:
        final args = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => AllEventsScreen(
            args: args is AllEventsRouteArgs
                ? args
                : const AllEventsRouteArgs(),
          ),
        );
      case AppRoutes.producerEvents:
        final args = settings.arguments;
        if (args is! ProducerEventsRouteArgs) {
          return MaterialPageRoute(builder: (_) => const MyFavoritesScreen());
        }
        return MaterialPageRoute(
          builder: (_) => ProducerEventsScreen(args: args),
        );
      case AppRoutes.myInvitations:
        return MaterialPageRoute(builder: (_) => const MyInvitationsScreen());
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