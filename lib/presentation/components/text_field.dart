import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final bool? obscureText;
  final TextEditingController? controller;
  final String label;
  final double? fontSize;
  final Color? textColor;
  final VoidCallback? onTap;
  final IconData? suffixIcon;
  final String? Function(String? value) validator;
  const CustomFormField({
    super.key,
    this.controller,
    this.fontSize,
    this.obscureText,
    required this.label,
    this.onTap,
    this.suffixIcon,
    this.textColor,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText ?? false,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        filled: true,
        fillColor: Colors.grey[300],
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          borderSide: BorderSide.none,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          borderSide: BorderSide.none,
        ),
        hintText: label,
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: onTap!,
        ),
      ),
      validator: validator,
    );
  }
}
