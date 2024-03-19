import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:resize/resize.dart';

class CreatedPasswordState {
  TextStyle? headingTextStyle;
  TextStyle? subheadingTextStyle;
  CreatedPasswordState() {
    ///Initialize variables

    headingTextStyle = TextStyle(
        fontSize: 28.sp,
        fontFamily: SarabunFontFamily.bold,
        color: customTextBlackColor);
    subheadingTextStyle = TextStyle(
        fontSize: 16.sp,
        fontFamily: SarabunFontFamily.medium,
        color: customOrangeColor);
  }
}
