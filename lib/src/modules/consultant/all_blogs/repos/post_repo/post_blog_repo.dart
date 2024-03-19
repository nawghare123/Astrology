// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../../../multi_language/language_constants.dart';
// import '../../../../../controller/general_controller.dart';
//
// postBlogRepo(BuildContext context, bool responseCheck, Map<String, dynamic> response) {
//   Get.find<GeneralController>().updateFormLoaderController(false);
//   if (responseCheck) {
//     // {"Status":true,"success":1,"msg":"Successfully added Blog"}
//     print(response);
//     if (response["Status"]) {
//       Get.snackbar('${LanguageConstant.success.tr}!', response['msg'].toString(), colorText: Colors.black, backgroundColor: Colors.white);
//       return;
//     }
//
//     Get.snackbar(LanguageConstant.failed.tr, response['msg'].toString(), colorText: Colors.black, backgroundColor: Colors.white);
//   }
// }
