import 'package:e_commerce_app/core/extensions/locale_context.dart';
import 'package:e_commerce_app/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';

class ContentSettingScreen extends StatelessWidget {
  const ContentSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          context.largeText("Under Construction").center(),
        ],
      ),
    );
  }
}
