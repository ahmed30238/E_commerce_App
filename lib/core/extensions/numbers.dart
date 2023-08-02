import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension EmptyPadding on num {
  //* Spaces
  SizedBox get ph => SizedBox(height: toDouble().h);
  SizedBox get pw => SizedBox(width: toDouble().w);

  //* padding
  EdgeInsets get allPadding => EdgeInsets.all(toDouble());
  EdgeInsets get vPadding => EdgeInsets.symmetric(horizontal: toDouble().h);
  EdgeInsets get hPadding => EdgeInsets.symmetric(vertical: toDouble().h);

  //* borderradius
  BorderRadius get circualrRadius => BorderRadius.circular(toDouble().r);
  BorderRadius get onlyTopRadius => BorderRadius.only(
      topRight: Radius.circular(toDouble().r),
      topLeft: Radius.circular(toDouble().r));
}
