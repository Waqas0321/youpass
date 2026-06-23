import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/config/otp_policy.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class OtpInputWidget extends StatefulWidget {
  const OtpInputWidget({
    super.key,
    required this.controller,
    this.onChanged,
    this.onCompleted,
    this.autofocus = true,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onCompleted;
  final bool autofocus;

  @override
  State<OtpInputWidget> createState() => OtpInputWidgetState();
}

class OtpInputWidgetState extends State<OtpInputWidget> {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(handleControllerChanged);
    focusNode.addListener(handleFocusChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(handleControllerChanged);
    focusNode.removeListener(handleFocusChanged);
    focusNode.dispose();
    super.dispose();
  }

  void handleControllerChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void handleFocusChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  String get otpValue => widget.controller.text;

  int get activeIndex {
    final length = otpValue.length;
    if (length >= OtpPolicy.codeLength) {
      return OtpPolicy.codeLength - 1;
    }
    return length;
  }

  void handleOtpChanged(String value) {
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    final trimmed = digitsOnly.length > OtpPolicy.codeLength
        ? digitsOnly.substring(0, OtpPolicy.codeLength)
        : digitsOnly;

    if (trimmed != widget.controller.text) {
      widget.controller.value = TextEditingValue(
        text: trimmed,
        selection: TextSelection.collapsed(offset: trimmed.length),
      );
    }

    widget.onChanged?.call(trimmed);

    if (trimmed.length == OtpPolicy.codeLength) {
      widget.onCompleted?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final theme = YouPassThemeExtension.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = layout.otpBoxWidth(constraints.maxWidth);
        final boxHeight = layout.otpBoxHeight;
        final boxRadius = layout.radius(12);

        return AutofillGroup(
          child: GestureDetector(
            onTap: focusNode.requestFocus,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(OtpPolicy.codeLength, (index) {
                  final digit = index < otpValue.length ? otpValue[index] : '';
                  final isActive =
                      focusNode.hasFocus && index == activeIndex;
                  final hasDigit = digit.isNotEmpty;

                  return Container(
                    width: boxWidth,
                    height: boxHeight,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: theme.inputFill,
                      borderRadius: BorderRadius.circular(boxRadius),
                      border: Border.all(
                        color: isActive
                            ? AppColors.primaryMustard
                            : theme.cardBorder,
                        width: isActive ? 1.5 : 1,
                      ),
                    ),
                    child: AppText(
                      hasDigit ? digit : '—',
                      variant: hasDigit
                          ? AppTextVariant.bodyEmphasis
                          : AppTextVariant.otpPlaceholder,
                      fontSize: layout.fontSize(18),
                    ),
                  );
                }),
              ),
              Opacity(
                opacity: 0,
                child: SizedBox(
                  width: constraints.maxWidth,
                  height: boxHeight,
                  child: TextField(
                    controller: widget.controller,
                    focusNode: focusNode,
                    autofocus: widget.autofocus,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    maxLength: OtpPolicy.codeLength,
                    autofillHints: const [AutofillHints.oneTimeCode],
                    enableSuggestions: true,
                    onChanged: handleOtpChanged,
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
          ),
        ),
        );
      },
    );
  }
}
