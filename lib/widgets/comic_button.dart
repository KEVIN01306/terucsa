import 'package:flutter/cupertino.dart';
import '../theme/app_theme.dart';

enum ComicButtonType { primary, secondary, ghost, danger }

class ComicButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ComicButtonType type;
  final IconData? icon;
  final bool fullWidth;

  const ComicButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ComicButtonType.primary,
    this.icon,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    Color borderColor = AppColors.ink;

    switch (type) {
      case ComicButtonType.primary:
        bgColor = AppColors.red;
        textColor = AppColors.white;
        break;
      case ComicButtonType.secondary:
        bgColor = AppColors.cyan;
        textColor = AppColors.ink;
        break;
      case ComicButtonType.ghost:
        bgColor = AppColors.white;
        textColor = AppColors.ink;
        break;
      case ComicButtonType.danger:
        bgColor = AppColors.danger;
        textColor = AppColors.white;
        break;
    }

    final buttonContent = Container(
      width: fullWidth ? double.infinity : null,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 2.5),
        boxShadow: const [
          BoxShadow(
            color: AppColors.ink,
            offset: Offset(2.5, 3),
            blurRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, color: textColor, size: 18),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      pressedOpacity: 0.8,
      child: buttonContent,
    );
  }
}
