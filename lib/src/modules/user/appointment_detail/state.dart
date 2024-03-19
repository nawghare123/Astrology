import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

class AppointmentDetailState {
  TextStyle? headingTextStyle;
  TextStyle? profileNameTextStyle;
  TextStyle? profileCategoryTextStyle;
  TextStyle? feeTextStyle;
  TextStyle? dateTimeTextStyle;
  TextStyle? statusTextStyle;
  TextStyle? sectionHeadingTextStyle;
  TextStyle? sectionLabelTextStyle;
  TextStyle? sectionDataTextStyle;
  TextStyle? hintTextStyle;

  AppointmentDetailState() {
    ///Initialize variables
    headingTextStyle = TextStyle(
      fontSize: 28.sp,
      fontFamily: SarabunFontFamily.bold,
      color: customLightThemeColor,
    );
    profileNameTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.extraBold,
        fontSize: 16.sp,
        color: customTextBlackColor);
    profileCategoryTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.light,
        fontSize: 12.sp,
        color: customTextBlackColor);
    feeTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 14.sp,
        color: customTextBlackColor);
    dateTimeTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.semiBold,
        fontSize: 14.sp,
        color: Colors.white);
    statusTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.semiBold,
        fontSize: 10.sp,
        color: Colors.white);
    sectionHeadingTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.extraBold,
        fontSize: 14.sp,
        color: customThemeColor);
    sectionLabelTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 10.sp,
        color: const Color(0xff757575));
    sectionDataTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.semiBold,
        fontSize: 12.sp,
        color: customTextBlackColor);
    hintTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.regular,
        fontSize: 16.sp,
        color: customTextGreyColor);
  }
}
