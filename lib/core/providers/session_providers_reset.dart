import 'package:youpass/features/home/presentation/providers/home_provider.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';

void resetSessionProviders({
  required HomeProvider homeProvider,
  required InvitationsProvider invitationsProvider,
}) {
  invitationsProvider.reset();
  homeProvider.reset();
}
