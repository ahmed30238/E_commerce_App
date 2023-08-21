import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget center() => Center(child: this);
  Widget scaffold() => Scaffold(
        body: this,
        appBar: AppBar(),
      );
  Form customValidationForm({GlobalKey? formKey}) {
    return Form(
      key: formKey,
      child: this,
    );
  }
}
// todo
extension BtnStyle on ButtonStyle {
  ButtonStyle? green() {
    return copyWith(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
      // shape: ,
    );
  }
}

// extension FormExtension on Widget {
// }

void gh() {
  ElevatedButton(
    style: ElevatedButton.styleFrom(),
    onPressed: () {},
    child: const Text("data"),
  );
}
