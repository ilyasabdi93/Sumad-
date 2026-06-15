import 'package:flutter/material.dart';

class SumadColors {
  static const Color primary = Color(0xFFFF6B00);
  static const Color primaryDark = Color(0xFFE65100);
  static const Color primaryLight = Color(0xFFFF8A3D);
  static const Color secondary = Color(0xFFFFAB40);
  static const Color accent = Color(0xFFFF9100);
  
  static const Color backgroundDark = Color(0xFF0D0D0D);
  static const Color surfaceDark = Color(0xFF1A1A1A);
  static const Color cardDark = Color(0xFF242424);
  static const Color cardLight = Color(0xFF2A2A2A);
  
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textHint = Color(0xFF707070);
  static const Color textDark = Color(0xFF1A1A1A);
  
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA726);
  static const Color info = Color(0xFF42A5F5);
  
  static const Color gold = Color(0xFFFFD700);
  static const Color premium = Color(0xFFFFC107);
  
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient darkOverlay = LinearGradient(
    colors: [Colors.transparent, Colors.black87],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient sideOverlay = LinearGradient(
    colors: [Colors.black87, Colors.transparent],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

class SumadTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: SumadColors.primary,
      scaffoldBackgroundColor: SumadColors.backgroundDark,
      backgroundColor: SumadColors.backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: SumadColors.primary,
        secondary: SumadColors.secondary,
        surface: SumadColors.surfaceDark,
        error: SumadColors.error,
        onPrimary: SumadColors.textPrimary,
        onSecondary: SumadColors.textPrimary,
        onSurface: SumadColors.textPrimary,
        onError: SumadColors.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: SumadColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: SumadColors.textPrimary),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: SumadColors.backgroundDark,
        selectedItemColor: SumadColors.primary,
        unselectedItemColor: SumadColors.textHint,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: SumadColors.cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: SumadColors.primary,
          foregroundColor: SumadColors.textPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: SumadColors.primary,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: SumadColors.cardDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: SumadColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: SumadColors.error),
        ),
        labelStyle: const TextStyle(color: SumadColors.textHint),
        hintStyle: const TextStyle(color: SumadColors.textHint),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: SumadColors.textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: SumadColors.textPrimary,
        ),
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: SumadColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: SumadColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: SumadColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: SumadColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: SumadColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: SumadColors.textSecondary,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: SumadColors.textHint,
        ),
      ),
      dividerColor: SumadColors.cardLight.withOpacity(0.3),
      dialogTheme: DialogTheme(
        backgroundColor: SumadColors.surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: SumadColors.cardDark,
        contentTextStyle: const TextStyle(color: SumadColors.textPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: SumadColors.surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: SumadColors.primary,
        circularTrackColor: SumadColors.cardDark,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: SumadColors.primary,
        inactiveTrackColor: SumadColors.cardLight,
        thumbColor: SumadColors.primary,
        overlayColor: SumadColors.primary.withOpacity(0.1),
        trackHeight: 4,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: SumadColors.primary,
      scaffoldBackgroundColor: SumadColors.backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: SumadColors.primary,
        secondary: SumadColors.secondary,
        surface: SumadColors.surfaceLight,
        error: SumadColors.error,
        onPrimary: SumadColors.textPrimary,
        onSecondary: SumadColors.textDark,
        onSurface: SumadColors.textDark,
        onError: SumadColors.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: SumadColors.textDark,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: SumadColors.textDark),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: SumadColors.surfaceLight,
        selectedItemColor: SumadColors.primary,
        unselectedItemColor: SumadColors.textHint,
        type: BottomNavigationBarType.fixed,
        elevation: 2,
      ),
      cardTheme: CardTheme(
        color: SumadColors.surfaceLight,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: SumadColors.primary,
          foregroundColor: SumadColors.textPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: SumadColors.backgroundLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: SumadColors.textHint.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: SumadColors.textHint.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: SumadColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: SumadColors.textDark,
        ),
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: SumadColors.textDark,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: SumadColors.textDark,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: SumadColors.textDark,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: SumadColors.textHint,
        ),
      ),
    );
  }
}