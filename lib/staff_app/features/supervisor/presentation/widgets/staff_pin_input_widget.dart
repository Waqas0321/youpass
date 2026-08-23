import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/theme/youpass_theme_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';

enum StaffPinInputStyle { dots, boxes }

enum StaffPinInputDensity { regular, compact }

class StaffPinInputWidget extends StatefulWidget {
  const StaffPinInputWidget({
    super.key,
    required this.controller,
    this.length = 4,
    this.style = StaffPinInputStyle.dots,
    this.density = StaffPinInputDensity.regular,
    this.obscureBoxDigits = true,
    this.onChanged,
    this.onCompleted,
    this.autofocus = true,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.expandFullWidth = true,
  });

  final TextEditingController controller;
  final int length;
  final StaffPinInputStyle style;
  final StaffPinInputDensity density;
  final bool obscureBoxDigits;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onCompleted;
  final bool autofocus;
  final MainAxisAlignment mainAxisAlignment;
  final bool expandFullWidth;

  @override
  State<StaffPinInputWidget> createState() => _StaffPinInputWidgetState();
}

class _StaffPinInputWidgetState extends State<StaffPinInputWidget> {
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
    final trimmed =
        digits.length > widget.length ? digits.substring(0, widget.length) : digits;

    if (trimmed != widget.controller.text) {
      widget.controller.value = TextEditingValue(
        text: trimmed,
        selection: TextSelection.collapsed(offset: trimmed.length),
      );
    }

    widget.onChanged?.call(trimmed);

    if (trimmed.length == widget.length) {
      widget.onCompleted?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final theme = YouPassThemeExtension.of(context);
    const accent = AppColors.homeAccentYellow;
    final pin = widget.controller.text;
    final activeIndex = pin.length >= widget.length
        ? widget.length - 1
        : pin.length;
    final isCompact = widget.density == StaffPinInputDensity.compact;
    final boxSize = layout.spacing(isCompact ? 36 : 44);
    final boxGap = layout.spacing(isCompact ? 4 : 6);
    final expandFullWidth =
        widget.expandFullWidth && widget.style == StaffPinInputStyle.boxes;
    final stackAlignment = expandFullWidth
        ? Alignment.center
        : widget.mainAxisAlignment == MainAxisAlignment.start
            ? Alignment.centerLeft
            : Alignment.center;

    Widget buildPinRow({bool fullWidth = false}) {
      if (fullWidth) {
        return Row(
          children: [
            for (var index = 0; index < widget.length; index++) ...[
              if (index > 0) SizedBox(width: boxGap),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: _PinCell(
                    layout: layout,
                    accent: accent,
                    theme: theme,
                    index: index,
                    pin: pin,
                    activeIndex: activeIndex,
                    hasFocus: _focusNode.hasFocus,
                    style: widget.style,
                    obscureBoxDigits: widget.obscureBoxDigits,
                  ),
                ),
              ),
            ],
          ],
        );
      }

      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: widget.mainAxisAlignment,
        children: [
          for (var index = 0; index < widget.length; index++) ...[
            if (index > 0) SizedBox(width: boxGap),
            _PinCell(
              layout: layout,
              accent: accent,
              theme: theme,
              index: index,
              pin: pin,
              activeIndex: activeIndex,
              hasFocus: _focusNode.hasFocus,
              style: widget.style,
              obscureBoxDigits: widget.obscureBoxDigits,
              boxSize: boxSize,
            ),
          ],
        ],
      );
    }

    return GestureDetector(
      onTap: _focusNode.requestFocus,
      child: expandFullWidth
          ? LayoutBuilder(
              builder: (context, constraints) {
                final totalGap = boxGap * (widget.length - 1);
                final cellSize = (constraints.maxWidth - totalGap) / widget.length;

                return Stack(
                  alignment: stackAlignment,
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth,
                      child: buildPinRow(fullWidth: true),
                    ),
                    Opacity(
                      opacity: 0,
                      child: SizedBox(
                        width: constraints.maxWidth,
                        height: cellSize,
                        child: TextField(
                          controller: widget.controller,
                          focusNode: _focusNode,
                          autofocus: widget.autofocus,
                          keyboardType: TextInputType.number,
                          maxLength: widget.length,
                          enableInteractiveSelection: false,
                          showCursor: false,
                          onChanged: _handleChanged,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          : Stack(
              alignment: stackAlignment,
              clipBehavior: Clip.none,
              children: [
                buildPinRow(),
                Opacity(
                  opacity: 0,
                  child: SizedBox(
                    width: layout.spacing(isCompact ? 160 : 200),
                    height: boxSize,
                    child: TextField(
                      controller: widget.controller,
                      focusNode: _focusNode,
                      autofocus: widget.autofocus,
                      keyboardType: TextInputType.number,
                      maxLength: widget.length,
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
    );
  }
}

class _PinCell extends StatelessWidget {
  const _PinCell({
    required this.layout,
    required this.accent,
    required this.theme,
    required this.index,
    required this.pin,
    required this.activeIndex,
    required this.hasFocus,
    required this.style,
    required this.obscureBoxDigits,
    this.boxSize,
  });

  final ResponsiveLayout layout;
  final Color accent;
  final YouPassThemeExtension theme;
  final int index;
  final String pin;
  final int activeIndex;
  final bool hasFocus;
  final StaffPinInputStyle style;
  final bool obscureBoxDigits;
  final double? boxSize;

  @override
  Widget build(BuildContext context) {
    final hasDigit = index < pin.length;
    final isActive = hasFocus && index == activeIndex;

    if (style == StaffPinInputStyle.boxes) {
      return Container(
        width: boxSize,
        height: boxSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(layout.radius(10)),
          border: Border.all(
            color: isActive ? accent : AppColors.homeDividerGrey,
            width: isActive ? 1.5 : 1,
          ),
        ),
        child: hasDigit
            ? (obscureBoxDigits
                ? Container(
                    width: layout.spacing(8),
                    height: layout.spacing(8),
                    decoration: const BoxDecoration(
                      color: AppColors.homeBlack,
                      shape: BoxShape.circle,
                    ),
                  )
                : Text(
                    pin[index],
                    style: TextStyle(
                      color: AppColors.homeBlack,
                      fontSize: layout.fontSize(18),
                      fontWeight: FontWeight.w700,
                    ),
                  ))
            : null,
      );
    }

    return Container(
      width: layout.spacing(16),
      height: layout.spacing(16),
      decoration: BoxDecoration(
        color: hasDigit ? AppColors.primaryMustard : theme.inputFill,
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive ? AppColors.primaryMustard : theme.cardBorder,
          width: isActive ? 2 : 1,
        ),
      ),
    );
  }
}
