import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/my_profile/logic.dart';
import 'package:consultant_product/src/modules/consultant/my_profile/model_get_generic_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

getGenericDataForProfileViewRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<MyProfileLogic>().mentorProfileGenericDataModel =
        MentorProfileGenericDataModel.fromJson(response);
    if (Get.find<MyProfileLogic>().mentorProfileGenericDataModel.status ==
        true) {
      ///---occupation
      for (var element in Get.find<MyProfileLogic>()
          .mentorProfileGenericDataModel
          .data!
          .occupations!) {
        if (element.id ==
            Get.find<GeneralController>()
                .getConsultantProfileModel
                .data!
                .userDetail!
                .occupation!) {
          Get.find<MyProfileLogic>().updateOccupation(element.name);
        }
      }

      Get.find<MyProfileLogic>().updateLoaderForViewProfile(false);
    } else {
      Get.find<MyProfileLogic>().updateLoaderForViewProfile(false);
    }
  } else if (!responseCheck) {
    Get.find<MyProfileLogic>().updateLoaderForViewProfile(false);
  }
}
