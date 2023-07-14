import 'package:e_commerce_app/core/global/app_enums/enums.dart';
import 'package:e_commerce_app/core/helper_methods/helper_methods.dart';

class ThemeUtils {
  static bool? _isDarkTheme;
  static Future<void> saveThemeMode(bool myTheme) async {
    _isDarkTheme = await prefs!.setBool(AppEnum.isDarkTheme.name, myTheme);
    await loadThemeToMemory();
  }

  static Future<void> loadThemeToMemory() async {
    _isDarkTheme = prefs!.getBool(AppEnum.isDarkTheme.name) ?? false;
  }

  static bool getTheme() {
    return _isDarkTheme ?? false;
  }
}
