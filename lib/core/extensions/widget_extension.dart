import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget center() => Center(child: this);
  Widget scaffold() => Scaffold(
        body: this,
        appBar: AppBar(),
      );
}
// todo 
extension BtnStyle on ButtonStyle {
ButtonStyle?  green() {
  
    return copyWith(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
      // shape: ,
    );
  }
}



void gh() {
  ElevatedButton(
    style: ElevatedButton.styleFrom(),
    onPressed: () {},
    child: const Text("data"),
  );
}
