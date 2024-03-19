import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resize/resize.dart';

class BookAppointmentDetailBox extends StatelessWidget {
  const BookAppointmentDetailBox(
      {Key? key, required this.title, required this.image})
      : super(key: key);

  final String? title;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: customTextFieldColor,
          borderRadius: BorderRadius.circular(8.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              '$image',
              color: customLightThemeColor,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              '$title',
              style: const TextStyle(
                  fontFamily: SarabunFontFamily.regular,
                  fontSize: 14,
                  color: customTextBlackColor),
            )
          ],
        ),
      ),
    );
  }
}
