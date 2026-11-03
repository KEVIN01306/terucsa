import 'package:flutter/cupertino.dart';
import '../theme/app_theme.dart';

class KickerTag extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double angle;

  const KickerTag({
    super.key,
    required this.text,
    this.backgroundColor = AppColors.ink,
    this.textColor = AppColors.bgYellow,
    this.angle = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    Widget tag = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.ink, width: 1.5),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
        ),
      ),
    );

    if (angle != 0.0) {
      return Transform.rotate(
        angle: angle,
        child: tag,
      );
    }

    return tag;
  }
}
