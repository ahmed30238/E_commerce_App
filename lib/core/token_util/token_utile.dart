import 'package:e_commerce_app/core/global/app_enums/enums.dart';
import 'package:e_commerce_app/core/helper_methods/helper_methods.dart';

class TokenUtil {
  static String _token = "No Token";

  static Future<void> saveToken(String myToken) async {
    _token =
        prefs!.setString(AppEnum.token.name.toString(), myToken).toString();
    await loadTokenToMemory();
  }

  static Future<void> loadTokenToMemory() async {
    _token = prefs!.getString(AppEnum.token.name.toString()).toString();
  }

  static String getTokenFromMemory() {
    return _token;
  }

  static void clearToken() {
    _token = '';
  }
}

