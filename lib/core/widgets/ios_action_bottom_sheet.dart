import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';

/// Shared iOS-style action bottom sheet building blocks.
class IosActionBottomSheet {
  IosActionBottomSheet._();

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => child,
    );
  }

  static Widget body({required List<Widget> children}) {
    return Builder(
      builder: (context) {
        final bottomInset = MediaQuery.paddingOf(context).bottom;
        return Padding(
          padding: EdgeInsets.fromLTRB(12, 0, 12, bottomInset + 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        );
      },
    );
  }

  static Widget gap() {
    return Builder(
      builder: (context) {
        final layout = ResponsiveLayout(context);
        return SizedBox(height: layout.spacing(8));
      },
    );
  }
}

class IosActionGroup extends StatelessWidget {
  const IosActionGroup({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: ColoredBox(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}

class IosSheetTitle extends StatelessWidget {
  const IosSheetTitle({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        layout.spacing(16),
        layout.spacing(14),
        layout.spacing(16),
        layout.spacing(12),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: layout.fontSize(16),
              fontWeight: FontWeight.w700,
              color: CupertinoColors.label.resolveFrom(context),
            ),
          ),
          if (subtitle != null && subtitle!.isNotEmpty) ...[
            SizedBox(height: layout.spacing(4)),
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: layout.fontSize(13),
                color: CupertinoColors.secondaryLabel.resolveFrom(context),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class IosSheetDivider extends StatelessWidget {
  const IosSheetDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 0.5,
      color: CupertinoColors.separator.resolveFrom(context),
    );
  }
}

class IosSheetAction extends StatelessWidget {
  const IosSheetAction({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.color,
    this.fontWeight,
    this.centered = false,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final Color? color;
  final FontWeight? fontWeight;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final textColor = color ?? CupertinoColors.label.resolveFrom(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: layout.spacing(14),
              horizontal: layout.spacing(16),
            ),
            child: centered
                ? Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: layout.fontSize(17),
                      fontWeight: fontWeight ?? FontWeight.w400,
                      color: textColor,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, size: layout.fontSize(20), color: textColor),
                        SizedBox(width: layout.spacing(8)),
                      ],
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: layout.fontSize(17),
                          fontWeight: fontWeight ?? FontWeight.w400,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class IosSheetCancelButton extends StatelessWidget {
  const IosSheetCancelButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IosSheetAction(
      label: label,
      centered: true,
      fontWeight: FontWeight.w600,
      color: ProfileDesignSpec.primary,
      onTap: onTap,
    );
  }
}
