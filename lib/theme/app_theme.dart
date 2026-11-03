import 'package:flutter/cupertino.dart';

class AppColors {
  static const Color bgYellow = Color(0xFFFFE600);
  static const Color ink = Color(0xFF111111);
  static const Color white = Color(0xFFFFFFFF);
  static const Color red = Color(0xFFFF3366);
  static const Color cyan = Color(0xFF00D2FF);
  static const Color purple = Color(0xFF9D4EDD);
  static const Color success = Color(0xFF00C853);
  static const Color danger = Color(0xFFD50000);
  static const Color warning = Color(0xFFFF9100);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color grayBorder = Color(0xFFDDDDDD);
  static const Color grayMuted = Color(0xFF666666);
  static const Color lightBlue = Color(0xFFE3F2FD);
}

class AppTheme {
  static CupertinoThemeData get cupertinoTheme {
    return const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.red,
      scaffoldBackgroundColor: AppColors.bgYellow,
      barBackgroundColor: AppColors.white,
      textTheme: CupertinoTextThemeData(
        primaryColor: AppColors.ink,
        textStyle: TextStyle(
          color: AppColors.ink,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
        ),
        navTitleTextStyle: TextStyle(
          color: AppColors.ink,
          fontSize: 18,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
        navLargeTitleTextStyle: TextStyle(
          color: AppColors.ink,
          fontSize: 26,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  /// Estilo de borde y sombra característico cómic / pop Cupertino
  static BoxDecoration get comicCardDecoration {
    return BoxDecoration(
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
    );
  }

  /// Estilo de botón primario cómic / Cupertino
  static BoxDecoration comicButtonDecoration({Color color = AppColors.red}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.ink, width: 2.5),
      boxShadow: const [
        BoxShadow(
          color: AppColors.ink,
          offset: Offset(3, 3),
          blurRadius: 0,
        ),
      ],
    );
  }

  /// Estilo para insignias o kickers
  static BoxDecoration kickerDecoration({Color bg = AppColors.ink}) {
    return BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(8),
    );
  }
}
