import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

class UploadImageButton extends StatelessWidget {
  final fieldName;
  UploadImageButton({Key? key, required this.fieldName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 25.h),
        child: Container(
          height: 103.h,
          width: 190.w,
          decoration: BoxDecoration(
              // color: const Color(0xffE5ECF7),
              borderRadius: BorderRadius.circular(8.r),
              image: const DecorationImage(
                  image: AssetImage('assets/images/uploadPicRect.png'),
                  fit: BoxFit.fill)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/cloud-upload-fill.svg',
                height: 22.h,
                width: 23.w,
              ),
              SizedBox(
                height: 17.h,
              ),
              Text(
                // LanguageConstant.uploadProfilePhoto.tr,
                fieldName,
                style: TextStyle(
                    fontFamily: SarabunFontFamily.regular,
                    fontSize: 16.sp,
                    color: customThemeColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
