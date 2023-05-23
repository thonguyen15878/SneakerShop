

import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    final brightness = isDarkTheme ? Brightness.dark : Brightness.light;
    final colorScheme = Theme.of(context).colorScheme.copyWith(
      background: isDarkTheme ? Colors.grey.shade700 : Colors.white,
      brightness: brightness,
    );

    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme ? Colors.black : Colors.grey.shade300,
      primaryColor: isDarkTheme ? Colors.black : Colors.grey.shade300,
      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      hintColor: isDarkTheme ? Colors.grey.shade300 : Colors.grey.shade800,
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: brightness,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
        colorScheme: colorScheme,
      ),
      colorScheme: colorScheme,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: isDarkTheme ? Colors.white : Colors.black,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
    );
  }
}
