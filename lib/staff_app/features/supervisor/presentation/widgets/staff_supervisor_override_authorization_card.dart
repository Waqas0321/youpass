import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_design.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_section_card.dart';
import 'package:youpass/l10n/app_localizations.dart';

/// Override-screen supervisor authorization: name row, dot PIN, HIGH badge.
class StaffSupervisorOverrideAuthorizationCard extends StatelessWidget {
  const StaffSupervisorOverrideAuthorizationCard({
    super.key,
    required this.l10n,
    required this.pinController,
    required this.supervisorName,
    required this.onPinChanged,
  });

  final AppLocalizations l10n;
  final TextEditingController pinController;
  final String supervisorName;
  final VoidCallback onPinChanged;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return StaffSupervisorSectionCard(
      title: l10n.staffSupervisorEntryAuthorizationTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                Icons.person_outline_rounded,
                color: StaffSupervisorDesign.accent,
                size: layout.spacing(18),
              ),
              SizedBox(width: layout.spacing(6)),
              AppText(
                '${l10n.staffSupervisorAuthorizationSupervisorLabel}:',
                variant: AppTextVariant.body,
                color: AppColors.secondaryGrey,
                fontSize: layout.fontSize(13),
              ),
              SizedBox(width: layout.spacing(6)),
              Icon(
                Icons.person_outline_rounded,
                color: StaffSupervisorDesign.accent,
                size: layout.spacing(18),
              ),
              Flexible(
                child: AppText(
                  supervisorName,
                  variant: AppTextVariant.bodyEmphasis,
                  color: AppColors.homeBlack,
                  fontWeight: FontWeight.w800,
                  fontSize: layout.fontSize(14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: layout.spacing(16)),
          AppText(
            l10n.staffSupervisorAuthorizationPinLabel,
            variant: AppTextVariant.label,
            color: AppColors.secondaryGrey,
            fontSize: layout.fontSize(13),
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: layout.spacing(10)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 3,
                child: StaffSupervisorPinDotsInput(
                  controller: pinController,
                  onChanged: (_) => onPinChanged(),
                ),
              ),
              SizedBox(width: layout.spacing(12)),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      l10n.staffSupervisorOverrideAuthLevelLabel,
                      variant: AppTextVariant.body,
                      color: AppColors.secondaryGrey,
                      fontSize: layout.fontSize(12),
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: layout.spacing(8)),
                    StaffSupervisorHighAuthorizationBadge(
                      label: l10n.staffSupervisorOverrideAuthLevelHigh,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StaffSupervisorPinDotsInput extends StatefulWidget {
  const StaffSupervisorPinDotsInput({
    super.key,
    required this.controller,
    this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  @override
  State<StaffSupervisorPinDotsInput> createState() =>
      _StaffSupervisorPinDotsInputState();
}

class _StaffSupervisorPinDotsInputState extends State<StaffSupervisorPinDotsInput> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_rebuild);
    _focusNode.addListener(_rebuild);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_rebuild);
    _focusNode.dispose();
    super.dispose();
  }

  void _rebuild() {
    if (mounted) {
      setState(() {});
    }
  }

  void _handleChanged(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    final trimmed = digits.length > 4 ? digits.substring(0, 4) : digits;

    if (trimmed != widget.controller.text) {
      widget.controller.value = TextEditingValue(
        text: trimmed,
        selection: TextSelection.collapsed(offset: trimmed.length),
      );
    }

    widget.onChanged?.call(trimmed);
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final pin = widget.controller.text;
    final hasFocus = _focusNode.hasFocus;

    return GestureDetector(
      onTap: _focusNode.requestFocus,
      child: Container(
        height: layout.spacing(48),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(layout.radius(12)),
          border: Border.all(
            color: hasFocus ? StaffSupervisorDesign.accent : AppColors.homeDividerGrey,
            width: hasFocus ? 1.5 : 1,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(4, (index) {
                final filled = index < pin.length;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: layout.spacing(10)),
                  child: Container(
                    width: layout.spacing(filled ? 12 : 10),
                    height: layout.spacing(filled ? 12 : 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: filled
                          ? AppColors.homeBlack
                          : AppColors.homeDividerGrey.withValues(alpha: 0.65),
                    ),
                  ),
                );
              }),
            ),
            Opacity(
              opacity: 0,
              child: SizedBox(
                height: layout.spacing(48),
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  enableInteractiveSelection: false,
                  showCursor: false,
                  onChanged: _handleChanged,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StaffSupervisorHighAuthorizationBadge extends StatelessWidget {
  const StaffSupervisorHighAuthorizationBadge({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: layout.spacing(12),
        vertical: layout.spacing(8),
      ),
      decoration: BoxDecoration(
        color: StaffSupervisorDesign.tileBackground,
        borderRadius: BorderRadius.circular(layout.radius(10)),
        border: Border.all(color: StaffSupervisorDesign.accent),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          StaffSupervisorLockPlusIcon(
            size: layout.spacing(16),
            color: StaffSupervisorDesign.accent,
          ),
          SizedBox(width: layout.spacing(6)),
          AppText(
            label,
            variant: AppTextVariant.bodyEmphasis,
            color: StaffSupervisorDesign.accent,
            fontWeight: FontWeight.w800,
            fontSize: layout.fontSize(12),
            letterSpacing: 0.8,
          ),
        ],
      ),
    );
  }
}

class StaffSupervisorLockPlusIcon extends StatelessWidget {
  const StaffSupervisorLockPlusIcon({
    super.key,
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.lock_outline_rounded, size: size, color: color),
          Positioned(
            bottom: size * 0.14,
            child: Text(
              '+',
              style: TextStyle(
                color: color,
                fontSize: size * 0.42,
                fontWeight: FontWeight.w800,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StaffSupervisorShieldStarIcon extends StatelessWidget {
  const StaffSupervisorShieldStarIcon({
    super.key,
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.shield_outlined, size: size, color: color),
          Positioned(
            top: size * 0.22,
            child: Icon(Icons.star_rounded, size: size * 0.34, color: color),
          ),
        ],
      ),
    );
  }
}
