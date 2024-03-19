import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../multi_language/language_constants.dart';
import '../../../../../utils/colors.dart';
import '../../../../../widgets/custom_dialog.dart';
import '../../create_blog_logic.dart';

postBlogRepo(BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  Get.find<CreateBlogLogic>().updateFormLoaderController(false);
  if (responseCheck) {
    print(response);
    if (response["Status"]) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: LanguageConstant.success.tr,
              titleColor: customDialogSuccessColor,
              descriptions: response['msg'].toString(),
              text: LanguageConstant.ok.tr,
              functionCall: () {
                Get.back();
                Get.back();
                Get.back();
                // Get.offAllNamed(PageRoutes.consultantDashboard);
              },
              img: 'assets/Icons/dialog_success.svg',
            );
          });
    }
    // {"Status":true,"success":1,"msg":"Successfully added Blog"}
  }
}
