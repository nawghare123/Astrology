import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../../../utils/constants.dart';

class MyProfileState {
  TextStyle? profileNameTextStyle;
  TextStyle? categoryTextStyle;
  TextStyle? ratingTextStyle;
  TextStyle? sectionHeadingTextStyle;
  TextStyle? previewLabelTextStyle;
  TextStyle? previewValueTextStyle;
  MyProfileState() {
    ///Initialize variables
    profileNameTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.extraBold,
        fontSize: 22.sp,
        color: customTextBlackColor);
    categoryTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.light,
        fontSize: 16.sp,
        color: customTextBlackColor);
    ratingTextStyle = const TextStyle(
        fontFamily: SarabunFontFamily.medium,
        fontSize: 12,
        color: customTextBlackColor);
    sectionHeadingTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.extraBold,
        fontSize: 14.sp,
        color: customThemeColor);
    previewLabelTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 10.sp,
        color: const Color(0xff757575));
    previewValueTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.semiBold,
        fontSize: 12.sp,
        color: customTextBlackColor);
  }
}
