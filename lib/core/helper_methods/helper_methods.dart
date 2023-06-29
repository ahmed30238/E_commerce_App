import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

navigateAndRemove({required BuildContext context, required String path}) {
  Navigator.pushNamedAndRemoveUntil(context, path, (route) => false);
}

navigateTo({required BuildContext context, required String path}) {
  Navigator.pushNamed(context, path);
}

SharedPreferences? prefs;