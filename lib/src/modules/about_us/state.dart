import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

class AboutUsState {
  TextStyle? headingTextStyle;
  TextStyle? descTextStyle;
  TextStyle? subHeadingTextStyle;
  AboutUsState() {
    ///Initialize variables

    headingTextStyle = TextStyle(
        fontSize: 20.sp,
        fontFamily: SarabunFontFamily.extraBold,
        color: customTextBlackColor);
    descTextStyle = TextStyle(
        fontSize: 14.sp,
        fontFamily: SarabunFontFamily.regular,
        color: customTextBlackColor);
    subHeadingTextStyle = TextStyle(
        fontSize: 14.sp,
        fontFamily: SarabunFontFamily.bold,
        color: Colors.white);
  }
}
