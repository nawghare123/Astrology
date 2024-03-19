

import 'package:consultant_product/src/modules/user/search_consultant/logic.dart';
import 'package:consultant_product/src/modules/user/search_consultant/search_consultant_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

consultantSearchRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<SearchConsultantLogic>().searchConsultantModel =
        SearchConsultantModel.fromJson(response);
    if (Get.find<SearchConsultantLogic>().searchConsultantModel.status ==
        true) {
      Get.find<SearchConsultantLogic>().updateSearchLoader(false);

    } else {
      Get.find<SearchConsultantLogic>().updateSearchLoader(false);
    }
  } else if (!responseCheck) {
    Get.find<SearchConsultantLogic>().updateSearchLoader(false);
  }
}
