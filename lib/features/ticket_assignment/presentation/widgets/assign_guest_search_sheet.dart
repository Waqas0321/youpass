import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/assign_guest_lookup_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/usecases/lookup_assign_guests_usecase.dart';
import 'package:youpass/features/ticket_assignment/presentation/ticket_assignment_design_spec.dart';
import 'package:youpass/features/ticket_assignment/presentation/utils/assign_guest_selection.dart';
import 'package:youpass/features/ticket_assignment/presentation/utils/contact_picker_helper.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';
import 'package:youpass/l10n/app_localizations.dart';

class AssignGuestSearchSheet extends StatefulWidget {
  const AssignGuestSearchSheet({super.key});

  static Future<AssignGuestSelection?> show(BuildContext context) {
    return showModalBottomSheet<AssignGuestSelection>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(TicketAssignmentDesignSpec.cardRadius(context)),
        ),
      ),
      builder: (_) => const AssignGuestSearchSheet(),
    );
  }

  @override
  State<AssignGuestSearchSheet> createState() => AssignGuestSearchSheetState();
}

class AssignGuestSearchSheetState extends State<AssignGuestSearchSheet> {
  final searchController = TextEditingController();
  Timer? debounce;
  List<AssignGuestLookupEntity> results = const [];
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onQueryChanged);
  }

  @override
  void dispose() {
    debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  void _onQueryChanged() {
    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 350), () {
      final query = searchController.text.trim();
      if (query.length < 2) {
        setState(() {
          results = const [];
          errorMessage = null;
          isLoading = false;
        });
        return;
      }
      _search(query);
    });
  }

  Future<void> _search(String query) async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final matches = await sl<LookupAssignGuestsUseCase>().call(query);
      if (!mounted) {
        return;
      }
      setState(() {
        results = matches;
        isLoading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        results = const [];
        isLoading = false;
        errorMessage = error.toString();
      });
    }
  }

  Future<void> _pickPhoneContact() async {
    final contact = await ContactPickerHelper.pickContact();
    if (!mounted || contact == null) {
      return;
    }

    final defaultCountry =
        context.read<AuthProvider>().userProfile?.countryCode ?? 'CL';
    Navigator.of(context).pop(
      AssignGuestSelection(
        displayName: contact.displayName,
        phone: contact.phone,
        countryCode: defaultCountry,
      ),
    );
  }

  void _selectRegisteredGuest(AssignGuestLookupEntity guest) {
    Navigator.of(context).pop(
      AssignGuestSelection(
        displayName: guest.fullName,
        phone: guest.phone,
        phoneDisplay: guest.phoneDisplay.isNotEmpty ? guest.phoneDisplay : guest.phone,
        countryCode: guest.countryCode,
        isRegistered: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        TicketsDesignSpec.px(context, 20),
        TicketsDesignSpec.px(context, 12),
        TicketsDesignSpec.px(context, 20),
        TicketsDesignSpec.px(context, 20) + bottomInset,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: TicketsDesignSpec.px(context, 40),
              height: TicketsDesignSpec.px(context, 4),
              decoration: BoxDecoration(
                color: TicketsScreenTheme.cardBorder(context),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          SizedBox(height: TicketsDesignSpec.px(context, 16)),
          Text(
            AppStrings.ticketAssignmentSearchGuestTitle(strings),
            style: TextStyle(
              fontSize: TicketsDesignSpec.px(context, 18),
              fontWeight: FontWeight.w700,
              color: TicketsScreenTheme.title(context),
            ),
          ),
          SizedBox(height: TicketsDesignSpec.px(context, 8)),
          Text(
            AppStrings.ticketAssignmentSearchGuestSubtitle(strings),
            style: TextStyle(
              fontSize: TicketsDesignSpec.px(context, 13),
              color: TicketsScreenTheme.body(context),
              height: 1.35,
            ),
          ),
          SizedBox(height: TicketsDesignSpec.px(context, 14)),
          TextField(
            controller: searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: AppStrings.ticketAssignmentSearchGuestHint(strings),
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  TicketAssignmentDesignSpec.fieldRadius(context),
                ),
              ),
            ),
          ),
          SizedBox(height: TicketsDesignSpec.px(context, 12)),
          if (isLoading)
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: TicketsDesignSpec.px(context, 16),
              ),
              child: const Center(child: CircularProgressIndicator()),
            )
          else if (errorMessage != null)
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: TicketsDesignSpec.px(context, 8),
              ),
              child: Text(
                errorMessage!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: TicketsDesignSpec.px(context, 13),
                ),
              ),
            )
          else if (results.isEmpty && searchController.text.trim().length >= 2)
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: TicketsDesignSpec.px(context, 8),
              ),
              child: Text(
                AppStrings.ticketAssignmentSearchGuestEmpty(strings),
                style: TextStyle(
                  fontSize: TicketsDesignSpec.px(context, 13),
                  color: TicketsScreenTheme.body(context),
                ),
              ),
            )
          else
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.35,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: results.length,
                separatorBuilder: (_, __) =>
                    SizedBox(height: TicketsDesignSpec.px(context, 8)),
                itemBuilder: (context, index) {
                  final guest = results[index];
                  return _GuestResultTile(
                    guest: guest,
                    strings: strings,
                    onTap: () => _selectRegisteredGuest(guest),
                  );
                },
              ),
            ),
          SizedBox(height: TicketsDesignSpec.px(context, 12)),
          OutlinedButton.icon(
            onPressed: _pickPhoneContact,
            icon: const Icon(Icons.contacts_outlined),
            label: Text(AppStrings.ticketAssignmentPickContact(strings)),
          ),
          SizedBox(height: TicketsDesignSpec.px(context, 8)),
          Text(
            AppStrings.ticketAssignmentSearchGuestManualHint(strings),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: TicketsDesignSpec.px(context, 12),
              color: TicketsScreenTheme.body(context),
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _GuestResultTile extends StatelessWidget {
  const _GuestResultTile({
    required this.guest,
    required this.strings,
    required this.onTap,
  });

  final AssignGuestLookupEntity guest;
  final AppLocalizations strings;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: TicketsScreenTheme.cardBackground(context),
      borderRadius: BorderRadius.circular(
        TicketAssignmentDesignSpec.fieldRadius(context),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          TicketAssignmentDesignSpec.fieldRadius(context),
        ),
        child: Container(
          padding: EdgeInsets.all(TicketsDesignSpec.px(context, 12)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              TicketAssignmentDesignSpec.fieldRadius(context),
            ),
            border: Border.all(color: TicketsScreenTheme.cardBorder(context)),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: TicketsDesignSpec.px(context, 18),
                backgroundColor:
                    TicketsScreenTheme.accent(context).withValues(alpha: 0.12),
                child: Icon(
                  Icons.person,
                  color: TicketsScreenTheme.accent(context),
                  size: TicketsDesignSpec.px(context, 18),
                ),
              ),
              SizedBox(width: TicketsDesignSpec.px(context, 10)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      guest.fullName,
                      style: TextStyle(
                        fontSize: TicketsDesignSpec.px(context, 14),
                        fontWeight: FontWeight.w700,
                        color: TicketsScreenTheme.title(context),
                      ),
                    ),
                    SizedBox(height: TicketsDesignSpec.px(context, 2)),
                    Text(
                      guest.phoneDisplay.isNotEmpty
                          ? guest.phoneDisplay
                          : guest.phone,
                      style: TextStyle(
                        fontSize: TicketsDesignSpec.px(context, 12),
                        color: TicketsScreenTheme.body(context),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: TicketsDesignSpec.px(context, 8),
                  vertical: TicketsDesignSpec.px(context, 4),
                ),
                decoration: BoxDecoration(
                  color: TicketsScreenTheme.accent(context).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  AppStrings.ticketAssignmentRegisteredBadge(strings),
                  style: TextStyle(
                    fontSize: TicketsDesignSpec.px(context, 10),
                    fontWeight: FontWeight.w700,
                    color: TicketsScreenTheme.accent(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
