import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:resize/resize.dart';

class ResetPasswordState {
  TextStyle? headingTextStyle;
  TextStyle? descTextStyle;
  TextStyle? subHeadingTextStyle;
  TextStyle? hintTextStyle;

  ResetPasswordState() {
    ///Initialize variables

    headingTextStyle = TextStyle(
        fontSize: 28.sp,
        fontFamily: SarabunFontFamily.bold,
        color: customTextBlackColor);
    descTextStyle = TextStyle(
        fontSize: 12.sp,
        fontFamily: SarabunFontFamily.medium,
        color: customLightThemeColor);
    subHeadingTextStyle = TextStyle(
        fontSize: 18.sp,
        fontFamily: SarabunFontFamily.extraBold,
        color: customTextBlackColor);
    hintTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 16.sp,
        color: customTextGreyColor);
  }
}
