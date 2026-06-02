import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/invitations/domain/entities/payment_method_request_entity.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
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

  @override
  void dispose() {
    cardNumberController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    nameController.dispose();
    super.dispose();
  }

  Future<void> handleSave() async {
    setState(() => isSaving = true);

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

    setState(() => isSaving = false);
    if (saved) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: InvitationsDesignSpec.dialogBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: InvitationsDesignSpec.dialogBorder),
        ),
        child: Padding(
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
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: InvitationsDesignSpec.titleText,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: isSaving
                        ? null
                        : () => Navigator.of(context).pop(false),
                    icon: const Icon(Icons.close),
                    color: InvitationsDesignSpec.bodyText,
                  ),
                ],
              ),
              Text(
                AppStrings.invitationsPaymentSubtitle(strings),
                style: const TextStyle(
                  fontSize: 13,
                  color: InvitationsDesignSpec.bodyText,
                ),
              ),
              const SizedBox(height: 16),
              PaymentMethodFieldWidget(
                label: AppStrings.invitationsCardNumber(strings),
                controller: cardNumberController,
                hint: AppStrings.invitationsCardNumberHint(strings),
                icon: Icons.credit_card_outlined,
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
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PaymentMethodFieldWidget(
                      label: AppStrings.invitationsCardCvv(strings),
                      controller: cvvController,
                      hint: AppStrings.invitationsCardCvvHint(strings),
                      icon: Icons.info_outline,
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
                children: [
                  const Icon(
                    Icons.lock_outline,
                    size: 16,
                    color: InvitationsDesignSpec.metaIcon,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    AppStrings.invitationsPaymentSecureNote(strings),
                    style: const TextStyle(
                      fontSize: 12,
                      color: InvitationsDesignSpec.bodyText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 44,
                child: ElevatedButton(
                  onPressed: isSaving ? null : handleSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: InvitationsDesignSpec.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isSaving
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          AppStrings.invitationsSaveCard(strings),
                          style: const TextStyle(fontWeight: FontWeight.w700),
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
