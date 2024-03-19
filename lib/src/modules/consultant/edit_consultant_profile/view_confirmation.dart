import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/edit_consultant_profile/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';

class ConfirmationView extends StatefulWidget {
  const ConfirmationView({Key? key}) : super(key: key);

  @override
  _ConfirmationViewState createState() => _ConfirmationViewState();
}

class _ConfirmationViewState extends State<ConfirmationView> {
  final state = Get.find<EditConsultantProfileLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(
      builder: (_generalController) => GetBuilder<EditConsultantProfileLogic>(
        builder: (_editConsultantProfileLogic) => ModalProgressHUD(
          progressIndicator: const CircularProgressIndicator(
            color: customThemeColor,
          ),
          inAsyncCall: _generalController.formLoaderController!,
          child: Scaffold(
              backgroundColor: Colors.white,
              body: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                    ),
                    SvgPicture.asset('assets/images/successfullImage.svg'),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      LanguageConstant.profileUpdated.tr,
                      style: TextStyle(
                          fontFamily: SarabunFontFamily.bold,
                          fontSize: 28.sp,
                          color: Colors.black),
                    ),
                    Text(
                      LanguageConstant.successfully.tr,
                      style: TextStyle(
                          fontFamily: SarabunFontFamily.medium,
                          fontSize: 16.sp,
                          color: customOrangeColor),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.w, 0, 15.w, 0),
                child: InkWell(
                    onTap: () {
                      Get.offAllNamed(PageRoutes.consultantDashboard);
                    },
                    child: MyCustomBottomBar(
                        title: LanguageConstant.goToDashboard.tr,
                        disable: false)),
              )),
        ),
      ),
    );
  }
}
