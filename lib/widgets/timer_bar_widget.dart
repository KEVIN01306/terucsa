import 'package:flutter/cupertino.dart';
import '../theme/app_theme.dart';

class TimerBarWidget extends StatelessWidget {
  final int totalSeconds;
  final int currentSeconds;

  const TimerBarWidget({
    super.key,
    required this.totalSeconds,
    required this.currentSeconds,
  });

  @override
  Widget build(BuildContext context) {
    final double fraction = (totalSeconds > 0)
        ? (currentSeconds / totalSeconds).clamp(0.0, 1.0)
        : 0.0;

    Color barColor;
    if (currentSeconds <= 10) {
      barColor = AppColors.danger;
    } else if (currentSeconds <= 20) {
      barColor = AppColors.warning;
    } else {
      barColor = AppColors.cyan;
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 16,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.ink, width: 2.5),
          ),
          child: Stack(
            children: [
              AnimatedFractionallySizedBox(
                duration: const Duration(milliseconds: 300),
                alignment: Alignment.centerLeft,
                widthFactor: fraction,
                child: Container(
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${currentSeconds}s',
          style: TextStyle(
            color: currentSeconds <= 10 ? AppColors.danger : AppColors.ink,
            fontSize: 28,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }
}
