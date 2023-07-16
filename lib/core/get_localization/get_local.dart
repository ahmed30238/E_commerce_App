import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

enum MyLang { hello }

extension on MyLang {
  String tr() => name.tr;
}

class GetLocalization extends Translations {
  final Map<String, String> _arStrings = {};
  final Map<String, String> _enStrings = {};

  static const String en = "en";
  static const String ar = "ar";
  @override
  Map<String, Map<String, String>> get keys {
    _addString(
      key: MyLang.hello.name,
      arValue: "sd",
      enValue: "sad",
    );

    return {en: _enStrings, ar: _arStrings};
  }

  _addString({required String key, String? arValue, String? enValue}) {
    if (arValue != null) _arStrings[key] = arValue;
    if (enValue != null) _enStrings[key] = enValue;
  }
}

class Testing extends StatelessWidget {
  const Testing({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(MyLang.hello.tr());
  }
}
