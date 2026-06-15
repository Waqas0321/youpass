import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/invitations_error_extension.dart';
import 'package:youpass/core/theme/youpass_dialog_theme.dart';
import 'package:youpass/core/widgets/dialogs/youpass_dialog_primary_button.dart';
import 'package:youpass/core/widgets/dialogs/youpass_themed_dialog_shell.dart';
import 'package:youpass/features/invitations/domain/entities/payment_method_request_entity.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';
import 'package:flutter/services.dart';
import 'package:youpass/features/invitations/presentation/utils/card_expiry_input_formatter.dart';
import 'package:youpass/features/invitations/presentation/widgets/payment_method_field_widget.dart';

class AddPaymentMethodDialog extends StatefulWidget {
  const AddPaymentMethodDialog({
    super.key,
    required this.onSave,
  });

  final Future<bool> Function(PaymentMethodRequestEntity request) onSave;

  static Future<bool> show(
    BuildContext context, {
    required Future<bool> Function(PaymentMethodRequestEntity request) onSave,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AddPaymentMethodDialog(onSave: onSave),
    );
    return result ?? false;
  }

  @override
  State<AddPaymentMethodDialog> createState() => AddPaymentMethodDialogState();
}

class AddPaymentMethodDialogState extends State<AddPaymentMethodDialog> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isSaving = false;
  String? errorMessage;

  @override
  void dispose() {
    cardNumberController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    nameController.dispose();
    super.dispose();
  }

  Future<void> handleSave() async {
    setState(() {
      isSaving = true;
      errorMessage = null;
    });

    final request = PaymentMethodRequestEntity(
      cardNumber: cardNumberController.text,
      expiry: expiryController.text,
      cvv: cvvController.text,
      cardholderName: nameController.text,
    );

    final saved = await widget.onSave(request);
    if (!mounted) {
      return;
    }

    if (saved) {
      Navigator.of(context).pop(true);
      return;
    }

    final provider = context.read<InvitationsProvider>();
    setState(() {
      isSaving = false;
      errorMessage = provider.localizedErrorMessage(context.l10n) ??
          context.l10n.errorGeneric;
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return YouPassThemedDialogShell(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  AppStrings.invitationsPaymentTitle(strings),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: YouPassDialogTheme.title(context),
                  ),
                ),
              ),
              IconButton(
                onPressed: isSaving ? null : () => Navigator.of(context).pop(false),
                icon: const Icon(Icons.close),
                color: YouPassDialogTheme.body(context),
              ),
            ],
          ),
          Text(
            AppStrings.invitationsPaymentSubtitle(strings),
            style: TextStyle(
              fontSize: 13,
              color: YouPassDialogTheme.body(context),
            ),
          ),
          const SizedBox(height: 16),
          PaymentMethodFieldWidget(
            label: AppStrings.invitationsCardNumber(strings),
            controller: cardNumberController,
            hint: AppStrings.invitationsCardNumberHint(strings),
            icon: Icons.credit_card_outlined,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: PaymentMethodFieldWidget(
                  label: AppStrings.invitationsCardExpiry(strings),
                  controller: expiryController,
                  hint: AppStrings.invitationsCardExpiryHint(strings),
                  icon: Icons.calendar_today_outlined,
                  keyboardType: TextInputType.number,
                  inputFormatters: [CardExpiryInputFormatter()],
                  maxLength: 5,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: PaymentMethodFieldWidget(
                  label: AppStrings.invitationsCardCvv(strings),
                  controller: cvvController,
                  hint: AppStrings.invitationsCardCvvHint(strings),
                  icon: Icons.lock_clock_outlined,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  maxLength: 4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          PaymentMethodFieldWidget(
            label: AppStrings.invitationsCardholderName(strings),
            controller: nameController,
            hint: AppStrings.invitationsCardholderNameHint(strings),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.lock_outline,
                size: 16,
                color: YouPassDialogTheme.body(context),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  AppStrings.invitationsPaymentSecureNote(strings),
                  style: TextStyle(
                    fontSize: 12,
                    color: YouPassDialogTheme.body(context),
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
          if (errorMessage != null) ...[
            const SizedBox(height: 12),
            Text(
              errorMessage!,
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.error,
                height: 1.3,
              ),
            ),
          ],
          const SizedBox(height: 16),
          YouPassDialogPrimaryButton(
            label: AppStrings.invitationsSaveCard(strings),
            onPressed: handleSave,
            isLoading: isSaving,
          ),
        ],
      ),
    );
  }
}
