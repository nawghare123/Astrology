import 'package:consultant_product/src/modules/user/chathistory/getMentorModel.dart';
import 'package:consultant_product/src/modules/user/home/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/general_controller.dart';

getmentorRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<UserHomeLogic>().getmentormodel = GetMentorModel.fromJson(response);

    Get.find<UserHomeLogic>().update();
    if (Get.find<UserHomeLogic>().getmentormodel.status.toString() == 'true') {
      Get.find<UserHomeLogic>().getmentorList.clear();
      for (var element in Get.find<UserHomeLogic>()
          .getmentormodel
          .data!
     .data!) {
        Get.find<UserHomeLogic>().getmentorList.add(MentorStyling(
             id: element.userId,
            firstName: element.firstName??'',
            lastName: element.lastName??'',
            //title: '${element.firstName ?? ''} ${element.lastName ?? ''}',
            occupation: element.occupation??[],
            onlineStatus:element.onlineStatus,
            from: element.from,
            to: element.to,
            religion: element.religion,
            imagePath: element.imagePath,
            description: element.description));
      }
      Get.find<UserHomeLogic>().updatementorLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<UserHomeLogic>().updatementorLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<UserHomeLogic>().updatementorLoader(false);
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

