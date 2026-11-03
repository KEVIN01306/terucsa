import 'package:flutter/cupertino.dart';
import '../theme/app_theme.dart';

class KeyIdeaBox extends StatelessWidget {
  final String text;

  const KeyIdeaBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cyan.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.ink, width: 2),
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 15,
            height: 1.4,
          ),
          children: [
            const TextSpan(
              text: '💡 Idea clave: ',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: AppColors.ink,
              ),
            ),
            TextSpan(
              text: text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
