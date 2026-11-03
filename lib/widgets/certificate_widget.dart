import 'package:flutter/cupertino.dart';
import '../theme/app_theme.dart';

class CertificateWidget extends StatelessWidget {
  final String title;
  final String name;
  final String careerOrArea;
  final String commitmentText;
  final String dateText;

  const CertificateWidget({
    super.key,
    required this.title,
    required this.name,
    required this.careerOrArea,
    required this.commitmentText,
    required this.dateText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.bgYellow,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.ink, width: 1.5),
            ),
            child: Text(
              title.toUpperCase(),
              style: const TextStyle(
                color: AppColors.ink,
                fontSize: 14,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.0,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.red,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
          if (careerOrArea.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              careerOrArea,
              style: const TextStyle(
                color: AppColors.grayMuted,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.cyan.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.ink.withValues(alpha: 0.2), width: 1),
            ),
            child: Text(
              commitmentText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.ink,
                fontSize: 15,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            dateText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.grayMuted,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
