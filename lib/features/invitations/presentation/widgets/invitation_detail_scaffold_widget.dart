import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';
import 'package:youpass/features/invitations/presentation/routes/invitation_detail_route_args.dart';
import 'package:youpass/features/home/presentation/utils/app_drawer_navigation.dart';

typedef InvitationDetailBuilder = Widget Function(
  BuildContext context,
  InvitationEntity invitation,
);

/// Loads invitation detail once and renders [builder] when ready.
class InvitationDetailScaffoldWidget extends StatefulWidget {
  const InvitationDetailScaffoldWidget({
    super.key,
    required this.args,
    required this.title,
    required this.builder,
  });

  final InvitationDetailRouteArgs args;
  final String title;
  final InvitationDetailBuilder builder;

  @override
  State<InvitationDetailScaffoldWidget> createState() =>
      _InvitationDetailScaffoldWidgetState();
}

class _InvitationDetailScaffoldWidgetState
    extends State<InvitationDetailScaffoldWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  InvitationEntity? invitation;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    invitation = widget.args.initialInvitation;
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadDetail());
  }

  Future<void> _loadDetail() async {
    final provider = context.read<InvitationsProvider>();
    final loaded = await provider.loadInvitationDetail(widget.args.invitationId);

    if (!mounted) {
      return;
    }

    setState(() {
      invitation = loaded ?? invitation;
      isLoading = false;
      errorMessage = loaded == null ? provider.errorMessage : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final item = invitation;

    return AppDrawerNavigation.wrap(
      scaffoldKey: scaffoldKey,
      context: context,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          AppDrawerNavigation.menuIconButton(
            context: context,
            scaffoldKey: scaffoldKey,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : item == null
              ? Center(child: Text(errorMessage ?? strings.errorGeneric))
              : widget.builder(context, item),
    );
  }
}
