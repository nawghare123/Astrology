import 'package:consultant_product/src/modules/consultant/chathistory/getMenteeModel.dart';
import 'package:consultant_product/src/modules/consultant/dashboard/logic.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/general_controller.dart';

getmenteeRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<DashboardLogic>().getmenteemodel = GetMenteeModel.fromJson(response);

    Get.find<DashboardLogic>().update();
    if (Get.find<DashboardLogic>().getmenteemodel.status.toString() == 'true') {
      Get.find<DashboardLogic>().getmenteeList.clear();
      for (var element in Get.find<DashboardLogic>()
          .getmenteemodel.data!.topRatedMentors!.data!) {
        Get.find<DashboardLogic>().getmenteeList.add(MenteeStyling(
             id: element.userId,
            firstName: element.firstName??'',
            lastName: element.lastName??'',
            //title: '${element.firstName ?? ''} ${element.lastName ?? ''}',
          //  occupation: element.occupation??[],
            onlineStatus:element.onlineStatus,
            imagePath: element.imagePath,
           // description: element.description
            ));
      }
      Get.find<DashboardLogic>().updatementeeLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<DashboardLogic>().updatementeeLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<DashboardLogic>().updatementeeLoader(false);
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

