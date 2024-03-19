import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

class UserDrawerState {
  TextStyle? nameTextStyle;
  TextStyle? emailTextStyle;
  TextStyle? titleTextStyle;

  UserDrawerState() {
    ///Initialize variables
    nameTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.extraBold,
        fontSize: 16.sp,
        color: Colors.black);
    emailTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.light,
        fontSize: 12.sp,
        color: Colors.black);
    titleTextStyle = TextStyle(
        fontFamily: SarabunFontFamily.semiBold,
        fontSize: 14.sp,
        color: Colors.black);
  }
}
