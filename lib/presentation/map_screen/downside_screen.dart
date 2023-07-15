import 'package:e_commerce_app/core/constants/assets.dart';
import 'package:e_commerce_app/core/extensions/locale_context.dart';
import 'package:e_commerce_app/core/extensions/numbers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DownSideContainer extends StatelessWidget {
  const DownSideContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40.r),
          topLeft: Radius.circular(40.r),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 30.h),
            child: Row(
              children: [
                SvgPicture.asset(
                  Assets.imagesSvgImagesIllustration,
                  height: 30.h,
                  width: 30.w,
                ),
                20.pw,
                SizedBox(
                  width: 310.w,
                  child: context.largeText(
                    "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus",
                  ),

                  // Text(
                  //   "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus",
                  //   maxLines: 2,
                  //   overflow: TextOverflow.ellipsis,
                  //   textAlign: TextAlign.justify,
                  //   style: MainTextStyle.regularTextStyle(
                  //     fontSize: 13,
                  //     color: MainColors.inActiveTextColor,
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Row(
              children: [
                SvgPicture.asset(
                  Assets.imagesSvgImagesIllustration1,
                  height: 30.h,
                  width: 30.w,
                ),
                20.pw,
                SizedBox(
                  width: 310.w,
                  child: const Text(
                    "translate.disatnceAway",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
