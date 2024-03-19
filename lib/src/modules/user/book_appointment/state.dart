import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

class BookAppointmentState {
  TextStyle? appBarTitleTextStyle;
  TextStyle? appBarSubTitleTextStyle;
  TextStyle? headingTextStyle;
  TextStyle? typeTextStyle;
  TextStyle? typePriceTextStyle;
  TextStyle? shiftTitleTextStyle;

  BookAppointmentState() {
    ///Initialize variables
    appBarTitleTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.bold,
        fontSize: 28.sp,
        color: customLightThemeColor);
    appBarSubTitleTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.medium,
        fontSize: 12.sp,
        color: Colors.white);
    headingTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.extraBold,
        fontSize: 18.sp,
        color: customTextBlackColor);
    typeTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.medium,
        fontSize: 14.sp,
        color: customTextBlackColor);
    typePriceTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.extraBold,
        fontSize: 18.sp,
        color: customOrangeColor);
    shiftTitleTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 14.sp,
        color: customTextBlackColor);
  }
}
