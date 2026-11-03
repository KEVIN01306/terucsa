import 'package:flutter/cupertino.dart';
import '../theme/app_theme.dart';
import '../models/ethical_content.dart';

class StationCardWidget extends StatelessWidget {
  final StationItem station;
  final VoidCallback onTap;
  final Color accentColor;

  const StationCardWidget({
    super.key,
    required this.station,
    required this.onTap,
    this.accentColor = AppColors.cyan,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.ink, width: 3),
          boxShadow: const [
            BoxShadow(
              color: AppColors.ink,
              offset: Offset(4, 5),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.ink, width: 1.5),
                  ),
                  child: Text(
                    station.num,
                    style: const TextStyle(
                      color: AppColors.ink,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const Icon(
                  CupertinoIcons.chevron_right,
                  color: AppColors.ink,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              station.title,
              style: const TextStyle(
                color: AppColors.ink,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              station.desc,
              style: const TextStyle(
                color: AppColors.grayMuted,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
