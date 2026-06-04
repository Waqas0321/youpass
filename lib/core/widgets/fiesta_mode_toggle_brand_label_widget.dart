import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_constants.dart';

class FiestaModeToggleBrandLabelWidget extends StatelessWidget {
  const FiestaModeToggleBrandLabelWidget({
    super.key,
    required this.color,
    required this.fontSize,
  });

  final Color color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.italic,
            color: color,
            letterSpacing: -0.3,
            height: 1,
          ),
          children: [
            TextSpan(text: AppConstants.appName),
            WidgetSpan(
              alignment: PlaceholderAlignment.top,
              child: Transform.translate(
                offset: const Offset(1, -4),
                child: Text(
                  '®',
                  style: TextStyle(
                    fontSize: fontSize * 0.55,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    color: color,
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
