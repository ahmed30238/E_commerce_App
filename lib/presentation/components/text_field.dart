import 'package:flutter/material.dart';

Widget defaultTextFormField({
  bool isPassword = false,
  required TextEditingController controller,
  required String label,
  double fontSize = 20,
  Color textColor = Colors.deepOrange,
  required Function()? onTap,
  required IconData suffixIcon,
  required String? Function(String? value) validator,
}) =>
    TextFormField(
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: onTap!,
        ),
      ),
      validator: validator,
    );
