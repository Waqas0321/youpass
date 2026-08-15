import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_pin_input_widget.dart';

class StaffSupervisorPinConfirmResult {
  const StaffSupervisorPinConfirmResult({
    required this.pin,
    this.notes,
  });

  final String pin;
  final String? notes;
}

Future<StaffSupervisorPinConfirmResult?> showStaffSupervisorPinConfirmDialog({
  required BuildContext context,
  required String title,
  required String pinLabel,
  required String confirmLabel,
  required String cancelLabel,
  String? notesLabel,
  String? notesPlaceholder,
  bool requireNotes = false,
}) {
  return showDialog<StaffSupervisorPinConfirmResult>(
    context: context,
    builder: (dialogContext) {
      return _StaffSupervisorPinConfirmDialog(
        title: title,
        pinLabel: pinLabel,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        notesLabel: notesLabel,
        notesPlaceholder: notesPlaceholder,
        requireNotes: requireNotes,
      );
    },
  );
}

class _StaffSupervisorPinConfirmDialog extends StatefulWidget {
  const _StaffSupervisorPinConfirmDialog({
    required this.title,
    required this.pinLabel,
    required this.confirmLabel,
    required this.cancelLabel,
    this.notesLabel,
    this.notesPlaceholder,
    this.requireNotes = false,
  });

  final String title;
  final String pinLabel;
  final String confirmLabel;
  final String cancelLabel;
  final String? notesLabel;
  final String? notesPlaceholder;
  final bool requireNotes;

  @override
  State<_StaffSupervisorPinConfirmDialog> createState() =>
      _StaffSupervisorPinConfirmDialogState();
}

class _StaffSupervisorPinConfirmDialogState
    extends State<_StaffSupervisorPinConfirmDialog> {
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_pinController.text.length != 4) {
      return;
    }

    if (widget.requireNotes && _notesController.text.trim().isEmpty) {
      return;
    }

    Navigator.of(context).pop(
      StaffSupervisorPinConfirmResult(
        pin: _pinController.text,
        notes: widget.requireNotes ? _notesController.text.trim() : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: AppText(
        widget.title,
        variant: AppTextVariant.title,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.requireNotes) ...[
            AppText(
              widget.notesLabel ?? '',
              variant: AppTextVariant.label,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: widget.notesPlaceholder,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
          ],
          AppText(
            widget.pinLabel,
            variant: AppTextVariant.label,
          ),
          const SizedBox(height: 8),
          StaffPinInputWidget(
            controller: _pinController,
            style: StaffPinInputStyle.boxes,
            density: StaffPinInputDensity.compact,
            onCompleted: _submit,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(widget.cancelLabel),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(widget.confirmLabel),
        ),
      ],
    );
  }
}
