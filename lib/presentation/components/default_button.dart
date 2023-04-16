import 'package:flutter/material.dart';

Widget defaultButton({
  required Function() onTap,
  Color borderColor = Colors.grey,
  required String text,
  Color textColor = Colors.black,
  FontWeight fontWeight = FontWeight.bold,
  double fontSize = 18,
  Color containerColor = Colors.transparent,
  required context,
  double width = 140,
  double height = 40,
  String? fontFamily,


}) =>
    InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: containerColor,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontFamily: fontFamily,fontSize: fontSize,fontWeight:fontWeight ),
            
          ),
        ),
      ),
    );
