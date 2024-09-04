import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color? borderColor;
  final String text;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? btnColor;
  final double? width;
  final double? height;
  final String? fontFamily;
  final bool? loading;
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onTap,
    this.btnColor,
    this.borderColor,
    this.fontFamily,
    this.fontSize,
    this.fontWeight,
    this.height,
    this.textColor,
    this.width,
    this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor ?? Theme.of(context).colorScheme.primary,
        elevation: 0,
        // fixedSize: Size(width ?? 200.w, height ?? 40.w),
        // minimumSize: Size(height ?? 40.h, width ?? 140.w),
        shape: StadiumBorder(
          side: BorderSide(
            color: borderColor ?? Colors.black,
            width: 1.0,
          ),
        ),
      ),
      child: loading == true
          ? const CircularProgressIndicator.adaptive(
              backgroundColor: Colors.cyan,
            )
          : Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontFamily: fontFamily,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: textColor ?? Theme.of(context).colorScheme.primary,
                  ),
            ),
    );
  }
}

// Widget defaultButton({
//   required Function() onTap,
//   Color borderColor = Colors.grey,
//   required String text,
//   Color textColor = Colors.black,
//   FontWeight fontWeight = FontWeight.bold,
//   double fontSize = 18,
//   Color containerColor = Colors.transparent,
//   required context,
//   double width = 140,
//   double? height,
//   String? fontFamily,
// }) =>
//     InkWell(
//       onTap: onTap,
//       child: Container(
//         width: width,
//         height: height ?? 40.h,
//         decoration: BoxDecoration(
//           color: containerColor,
//           border: Border.all(color: borderColor, width: 1),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Center(
//           child: Text(
//             text,
//             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                 fontFamily: fontFamily,
//                 fontSize: fontSize,
//                 fontWeight: fontWeight,
//                 color: Colors.white),
//           ),
//         ),
//       ),
//     );
