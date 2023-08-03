import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension LocalExtension on BuildContext {
  AppLocalizations? get loc => AppLocalizations.of(this);

  Widget largeText(String text,
          {double? fontSize, int? maxLines, TextOverflow? overflow}) =>
      Text(
        text,
        maxLines: maxLines,
        style: Theme.of(this).textTheme.bodyLarge!.copyWith(
              fontSize: fontSize?.sp,
              height: 1.1,
              overflow: overflow,
            ),
      );
}
