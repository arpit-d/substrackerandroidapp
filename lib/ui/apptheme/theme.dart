import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _prefs;
  bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = false;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefs.setBool(key, _darkTheme);
  }
}

PageTransitionsTheme pageTransitionsTheme = const PageTransitionsTheme(
  builders: const <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: const CupertinoPageTransitionsBuilder(),
  },
);

const MaterialColor primarySwatch =
    const MaterialColor(0xFFEA5455, const <int, Color>{
  50: const Color(0xFFEA5455),
  100: const Color(0xFFEA5455),
  200: const Color(0xFFEA5455),
  300: const Color(0xFFEA5455),
  400: const Color(0xFFEA5455),
  500: const Color(0xFFEA5455),
  600: const Color(0xFFEA5455),
  700: const Color(0xFFEA5455),
  800: const Color(0xFFEA5455),
  900: const Color(0xFFEA5455),
});

const String FONT_NAME = 'Rubik';

ThemeData lightTheme = ThemeData(
   cursorColor : const Color(0xFFEA5455),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Color(0xFF696969)),
      focusedBorder: const OutlineInputBorder(
        borderSide: const BorderSide(
          color: const Color(0xFFEA5455),
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: const BorderSide(
          color: const Color(0xFFE23744),
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: const BorderSide(
          color: const Color(0xFFE23744),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: const BorderSide(
          color: const Color(0xFF2d2d2d),
        ),
      ),
    ),
    primaryIconTheme: const IconThemeData(color: const Color(0xFF2d2d2d)),
    iconTheme: const IconThemeData(color: const Color(0xFF2d2d2d)),
    primarySwatch: primarySwatch,
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    cardTheme: CardTheme(
      elevation: 1,
      margin: const EdgeInsets.fromLTRB(0, 7, 0, 7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0))),
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: const IconThemeData(color: const Color(0xFF2d2d2d)),
      elevation: 0,
      color: const Color(0xFFFFFFFF),
      brightness: Brightness.light,
    ),
    textSelectionColor: const Color(0xFFEA5455),
    textSelectionHandleColor: const Color(0xFF2d2d2d),
    primaryColor: const Color(0xFFEA5455),
    fontFamily: FONT_NAME,
    dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
        const Radius.circular(10.0),
      )),
    ),
    pageTransitionsTheme: pageTransitionsTheme);

ThemeData darkTheme = ThemeData(
  cursorColor : const Color(0xFFEA5455),
    buttonTheme: ButtonThemeData(),
    dialogTheme: const DialogTheme(
      backgroundColor: const Color(0xFF111111),
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
        const Radius.circular(10.0),
      )),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Color(0xFFC0C0C0)),
      focusedBorder: const OutlineInputBorder(
        borderSide: const BorderSide(
          color: const Color(0xFFEA5455),
        ),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: const BorderSide(
          color: const Color(0xFF2d2d2d),
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: const BorderSide(
          color: const Color(0xFFE23744),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: const BorderSide(
          color: const Color(0xFFEA5455),
        ),
      ),
    ),
    textSelectionColor: const Color(0xFFEA5455),
    textSelectionHandleColor: const Color(0xFFFFFFFF),
    canvasColor: const Color(0xFF101010),
    backgroundColor: const Color(0xFF000000),
    bottomSheetTheme: BottomSheetThemeData(
      modalBackgroundColor: const Color(0xFF101010),
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0))),
    ),
    cardColor: const Color(0xFF111111),
    cardTheme: CardTheme(
      elevation: 3,
      margin: const EdgeInsets.fromLTRB(0, 7, 0, 7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    snackBarTheme: SnackBarThemeData(),
    fontFamily: FONT_NAME,
    scaffoldBackgroundColor: const Color(0xFF000000),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
      elevation: 0,
      color: Color(0xFF111111),
      brightness: Brightness.dark,
    ),
    primaryIconTheme: const IconThemeData(color: Color(0xFFEA5455)),
    iconTheme: const IconThemeData(color: Color(0xFFEA5455)),
    pageTransitionsTheme: pageTransitionsTheme,
    brightness: Brightness.dark,
    primarySwatch: primarySwatch,
    accentColor: const Color(0xFFEA5455));
