import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:resize/resize.dart';

class NewPasswordState {
  TextStyle? headingTextStyle;
  TextStyle? descTextStyle;
  TextStyle? subHeadingTextStyle;
  TextStyle? hintTextStyle;
  NewPasswordState() {
    ///Initialize variables

    headingTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.bold,
        fontSize: 28.sp,
        color: customTextBlackColor);
    descTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.medium,
        fontSize: 12.sp,
        color: customLightThemeColor);
    subHeadingTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.extraBold,
        fontSize: 18.sp,
        color: customTextBlackColor);
    hintTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 16.sp,
        color: customTextGreyColor);
  }
}
