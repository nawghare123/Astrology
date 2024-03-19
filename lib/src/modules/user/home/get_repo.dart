import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/appointment/AppointmenttypeModel.dart';
import 'package:consultant_product/src/modules/user/home/logic.dart';
import 'package:consultant_product/src/modules/user/home/model_featured.dart';
import 'package:consultant_product/src/modules/user/home/model_get_categories.dart';
import 'package:consultant_product/src/modules/user/home/model_top_rated.dart';
import 'package:consultant_product/src/modules/user/home/model_user_profile.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

getUserProfileRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<UserHomeLogic>().getUserProfileModel =
        GetUserProfileModel.fromJson(response);
    Get.find<UserHomeLogic>().update();
    if (Get.find<UserHomeLogic>().getUserProfileModel.status.toString() ==
        'true') {
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

getFeaturedConsultantRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<UserHomeLogic>().featuredConsultantModel =
        FeaturedConsultantModel.fromJson(response);
    Get.find<UserHomeLogic>().update();
    if (Get.find<UserHomeLogic>().featuredConsultantModel.status.toString() ==
        'true') {
      Get.find<UserHomeLogic>().topConsultants.clear();
      for (var element
          in Get.find<UserHomeLogic>().featuredConsultantModel.data!.mentors!) {
        Get.find<UserHomeLogic>().topConsultants.add(HomeStyling(
            id: element.userId,
            title: '${element.firstName ?? ''} ${element.lastName ?? ''}',
            subTitle: element.category?.name ?? 'category',
            image: element.imagePath,
            occupation: element.occupation??[],
            //gender: element.gender
            ));
      }
      Get.find<UserHomeLogic>().updateFeaturedConsultantLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<UserHomeLogic>().updateFeaturedConsultantLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<UserHomeLogic>().updateFeaturedConsultantLoader(false);
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}


// getappointmenttype(
//     BuildContext context, bool responseCheck, Map<String, dynamic> response) {
//   if (responseCheck) {
//     Get.find<UserHomeLogic>().appointmenttype =
//         AppointmenttypeModel.fromJson(response);
//     Get.find<UserHomeLogic>().update();
//     if (Get.find<UserHomeLogic>().appointmenttype.status.toString() ==
//         'true') {
//       Get.find<UserHomeLogic>().topConsultants.clear();
//       for (var element
//       in Get.find<UserHomeLogic>().featuredConsultantModel.data!.mentors!) {
//         Get.find<UserHomeLogic>().topConsultants.add(HomeStyling(
//             id: element.userId,
//             title: '${element.firstName ?? ''} ${element.lastName ?? ''}',
//             subTitle: element.category?.name ?? 'category',
//             image: element.imagePath,
//             gender: element.gender));
//       }
//       Get.find<UserHomeLogic>().updateFeaturedConsultantLoader(false);
//       Get.find<GeneralController>().updateFormLoaderController(false);
//     } else {
//       Get.find<UserHomeLogic>().updateFeaturedConsultantLoader(false);
//       Get.find<GeneralController>().updateFormLoaderController(false);
//     }
//   } else if (!responseCheck) {
//     Get.find<UserHomeLogic>().updateFeaturedConsultantLoader(false);
//     Get.find<GeneralController>().updateFormLoaderController(false);
//   }
// }
//

getCategoriesRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<UserHomeLogic>().getCategoriesModel =
        GetCategoriesModel.fromJson(response);
    Get.find<UserHomeLogic>().update();
    if (Get.find<UserHomeLogic>().getCategoriesModel.status.toString() ==
        'true') {
      Get.find<UserHomeLogic>().categoriesList.clear();
      for (var element in Get.find<UserHomeLogic>()
          .getCategoriesModel
          .data!
          .mentorCategories!) {
        Get.find<UserHomeLogic>().categoriesList.add(HomeStyling(
            id: element.id,
            title: element.name,
            subTitle: element.mentorPCount.toString(),
            image: element.imagePath,
            color: customThemeColor));
      }
      Get.find<UserHomeLogic>().updateCategoriesLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<UserHomeLogic>().updateCategoriesLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<UserHomeLogic>().updateCategoriesLoader(false);
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}

getTopRatedConsultantRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<UserHomeLogic>().topRatedModel = TopRatedModel.fromJson(response);

    Get.find<UserHomeLogic>().update();
    if (Get.find<UserHomeLogic>().topRatedModel.status.toString() == 'true') {
      Get.find<UserHomeLogic>().topRatedConsultantList.clear();
      for (var element in Get.find<UserHomeLogic>()
          .topRatedModel
          .data!
          .topRatedMentors!
          .data!) {
        Get.find<UserHomeLogic>().topRatedConsultantList.add(TopRatedStyling(
           userId: element.userId,
            firstName: '${element.firstName ?? ''} ${element.lastName ?? ''}',
          occupation: element.occupation??[],
            imagePath: element.imagePath,
            religion:element.religion,
from:element.from,
to:element.to,
            topRating: element.ratingAvg));
      }
      Get.find<UserHomeLogic>().updateTopRatedLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<UserHomeLogic>().updateTopRatedLoader(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<UserHomeLogic>().updateTopRatedLoader(false);
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}










getTopRatedConsultantMoreRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<UserHomeLogic>().topRatedModel = TopRatedModel.fromJson(response);
    Get.find<UserHomeLogic>().update();
    if (Get.find<UserHomeLogic>().topRatedModel.status.toString() == 'true') {
      for (var element in Get.find<UserHomeLogic>()
          .topRatedModel
          .data!
          .topRatedMentors!
          .data!) {
        Get.find<UserHomeLogic>().topRatedConsultantList.add(TopRatedStyling(
            userId: element.userId,
            firstName: '${element.firstName ?? ''} ${element.lastName ?? ''}',
            occupation: element.occupation??[],
            imagePath: element.imagePath,
            topRating: element.ratingAvg));
      }
      Get.find<UserHomeLogic>().updateTopRatedLoaderMore(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    } else {
      Get.find<UserHomeLogic>().updateTopRatedLoaderMore(false);
      Get.find<GeneralController>().updateFormLoaderController(false);
    }
  } else if (!responseCheck) {
    Get.find<UserHomeLogic>().updateTopRatedLoaderMore(false);
    Get.find<GeneralController>().updateFormLoaderController(false);
  }
}
