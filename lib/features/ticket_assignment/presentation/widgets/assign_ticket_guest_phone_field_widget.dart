import 'package:flutter/material.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/core/l10n/country_code_display_helper.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/models/country_code.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/features/auth/presentation/widgets/country_code_selector_widget.dart';
import 'package:youpass/features/ticket_assignment/presentation/ticket_assignment_design_spec.dart';
import 'package:youpass/features/ticket_assignment/presentation/utils/assign_ticket_phone_helper.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';

class AssignTicketGuestPhoneFieldWidget extends StatefulWidget {
  const AssignTicketGuestPhoneFieldWidget({
    super.key,
    required this.controller,
    this.initialCountryIsoCode,
    this.borderColor,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final String? initialCountryIsoCode;
  final Color? borderColor;
  final bool readOnly;

  @override
  State<AssignTicketGuestPhoneFieldWidget> createState() =>
      AssignTicketGuestPhoneFieldWidgetState();
}

class AssignTicketGuestPhoneFieldWidgetState
    extends State<AssignTicketGuestPhoneFieldWidget> {
  late CountryCode selectedCountry;

  @override
  void initState() {
    super.initState();
    final iso = widget.initialCountryIsoCode?.trim();
    selectedCountry = iso == null || iso.isEmpty
        ? CountryCodeList.defaultCountry
        : CountryCodeList.findByIsoCode(iso);
  }

  CountryCode get currentCountry => selectedCountry;

  void applyPhone(String rawPhone, {String? countryIsoCode}) {
    final resolved = AssignTicketPhoneHelper.resolvePhone(
      rawPhone: rawPhone,
      isoCode: countryIsoCode,
      fallbackCountry: selectedCountry,
    );
    setState(() => selectedCountry = resolved.country);
    widget.controller.text = resolved.nationalDigits;
  }

  void updateCountry(CountryCode country) {
    setState(() => selectedCountry = country);
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final radius = TicketAssignmentDesignSpec.fieldRadius(context);
    final resolvedBorderColor =
        widget.borderColor ?? TicketAssignmentDesignSpec.fieldBorder;

    OutlineInputBorder fieldBorder({double width = 1}) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: resolvedBorderColor, width: width),
      );
    }

    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.phone,
      readOnly: widget.readOnly,
      enableInteractiveSelection: !widget.readOnly,
      style: TextStyle(
        fontSize: TicketsDesignSpec.px(context, 14),
        fontWeight: FontWeight.w500,
        color: TicketsScreenTheme.title(context),
      ),
      decoration: InputDecoration(
        hintText: CountryCodeDisplayHelper.localizedPhoneHint(
          selectedCountry,
          strings,
        ),
        hintStyle: TextStyle(
          fontSize: TicketsDesignSpec.px(context, 14),
          fontWeight: FontWeight.w400,
          color: TicketsScreenTheme.body(context),
        ),
        filled: true,
        fillColor: TicketAssignmentDesignSpec.fieldFill,
        contentPadding: EdgeInsets.zero,
        border: fieldBorder(),
        enabledBorder: fieldBorder(),
        focusedBorder: fieldBorder(width: 1.2),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.readOnly
                ? _ReadOnlyCountryPrefix(
                    country: selectedCountry,
                    borderColor: resolvedBorderColor,
                  )
                : CountryCodeSelectorWidget(
                    selectedCountry: selectedCountry,
                    onCountryChanged: updateCountry,
                  ),
            Container(
              width: 1,
              height: TicketsDesignSpec.px(context, 28),
              color: resolvedBorderColor.withValues(alpha: 0.6),
            ),
          ],
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: TicketsDesignSpec.px(context, 118),
        ),
      ),
    );
  }
}

class _ReadOnlyCountryPrefix extends StatelessWidget {
  const _ReadOnlyCountryPrefix({
    required this.country,
    required this.borderColor,
  });

  final CountryCode country;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: TicketsDesignSpec.px(context, 12),
        vertical: TicketsDesignSpec.px(context, 14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            country.flagEmoji,
            variant: AppTextVariant.emojiMedium,
          ),
          SizedBox(width: TicketsDesignSpec.px(context, 6)),
          AppText(
            country.displayDialCode,
            variant: AppTextVariant.dialCode,
          ),
        ],
      ),
    );
  }
}
