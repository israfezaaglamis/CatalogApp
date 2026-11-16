import 'package:flutter/material.dart';

class AppColors {
  static const bg = Color(0xFFF1F5F9);
  static const card = Colors.white;
  static const border = Color(0xFFE2E8F0);
  static const primary = Color(0xFF4F46E5);
  static const primarySoft = Color(0xFFE0E7FF);
  static const primaryDark = Color(0xFF4338CA);
  static const text = Color(0xFF1E293B);
  static const muted = Color(0xFF64748B);
  static const danger = Color(0xFFDC2626);
  static const dangerSoft = Color(0xFFFEE2E2);
  static const dangerDark = Color(0xFFB91C1C);
  static const success = Color(0xFF15803D);
  static const successSoft = Color(0xFFDCFCE7);
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    colorSchemeSeed: AppColors.primary,
    scaffoldBackgroundColor: AppColors.bg,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.bg,
      foregroundColor: AppColors.text,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
          color: AppColors.text, fontSize: 18, fontWeight: FontWeight.w700),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: AppColors.border,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
  );
}

/// Hap şeklinde küçük rozet (ekran görüntüsündeki "Yüksek" / "İsra" etiketleri gibi)
class Pill extends StatelessWidget {
  final String text;
  final Color background;
  final Color foreground;
  final IconData? icon;
  const Pill(this.text,
      {super.key,
      this.background = AppColors.primarySoft,
      this.foreground = AppColors.primaryDark,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (icon != null) ...[
          Icon(icon, size: 12, color: foreground),
          const SizedBox(width: 4),
        ],
        Text(text,
            style: TextStyle(
                color: foreground, fontSize: 11, fontWeight: FontWeight.w700)),
      ]),
    );
  }
}
