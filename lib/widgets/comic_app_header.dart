import 'package:flutter/cupertino.dart';
import '../theme/app_theme.dart';
import 'kicker_tag.dart';

class ComicAppHeader extends StatelessWidget {
  final String kicker;
  final String title;
  final String subtitle;

  const ComicAppHeader({
    super.key,
    required this.kicker,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.red,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        border: const Border(
          bottom: BorderSide(color: AppColors.ink, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KickerTag(
            text: kicker,
            backgroundColor: AppColors.ink,
            textColor: AppColors.bgYellow,
            angle: -0.04, // ligera rotación estilo cómic
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
              height: 1.15,
              letterSpacing: 0.5,
              shadows: [
                Shadow(
                  color: AppColors.ink,
                  offset: Offset(2.5, 2.5),
                  blurRadius: 0,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
