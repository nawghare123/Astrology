import 'package:consultant_product/src/modules/user/chathistory/getMentorModel.dart';
import 'package:consultant_product/src/modules/user/home/model_featured.dart' as feat;
import 'package:consultant_product/src/modules/user/chathistory/getMentorModel.dart' as getMent;
import 'package:consultant_product/src/modules/user/home/model_featured.dart';
import 'package:consultant_product/src/modules/user/home/model_top_rated.dart' as toprated;
import 'package:consultant_product/src/modules/user/home/model_get_categories.dart';
import 'package:consultant_product/src/modules/user/home/model_top_rated.dart';
import 'package:consultant_product/src/modules/user/home/model_user_profile.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../consultant/chathistory/getMenteeModel.dart';
import 'state.dart';

class UserHomeLogic extends GetxController {
  final UserHomeState state = UserHomeState();

  GetUserProfileModel getUserProfileModel = GetUserProfileModel();

  int? selectedConsultantID;
  String? selectedConsultantName;

  ///----app-bar-settings-----start
  ScrollController? scrollController;
  bool lastStatus = true;
  double height = 200.h;

  bool get isShrink {
    return scrollController!.hasClients && scrollController!.positions.last.pixels > (height - kToolbarHeight);
  }

  void scrollListener() {
    if (isShrink != lastStatus) {
      lastStatus = isShrink;
      update();
    }
  }

  ///----app-bar-settings-----end

  FeaturedConsultantModel featuredConsultantModel = FeaturedConsultantModel();
  bool? featuredConsultantLoader = true;
  updateFeaturedConsultantLoader(bool? newValue) {
    featuredConsultantLoader = newValue;
    update();
  }

  List<HomeStyling> topConsultants = [];

  ///-------

  GetCategoriesModel getCategoriesModel = GetCategoriesModel();
  bool? categoriesLoader = true;
  updateCategoriesLoader(bool? newValue) {
    categoriesLoader = newValue;
    update();
  }

  int? selectedCategoryId;
  List<HomeStyling> categoriesList = [];
  List categoriesColor = [
    customLightThemeColor,
    customOrangeColor,
    customThemeColor,
    customThemeColor,
    customLightThemeColor,
    customOrangeColor
  ];

  ///-------
  TopRatedModel topRatedModel = TopRatedModel();
  GetMentorModel getmentormodel = GetMentorModel();
  GetMenteeModel getmenteemodel = GetMenteeModel();
  bool? topRatedLoader = true;
  updateTopRatedLoader(bool? newValue) {
    topRatedLoader = newValue;
    update();
  }

  bool? topRatedLoaderMore = false;
  updateTopRatedLoaderMore(bool? newValue) {
    topRatedLoaderMore = newValue;
    update();
  }

 bool? mentorLoader = true;
  updatementorLoader(bool? newValue) {
    mentorLoader = newValue;
    update();
  }

  
 bool? menteeLoader = true;
  updatementeeLoader(bool? newValue) {
    menteeLoader = newValue;
    update();
  }

  bool? mentorLoaderMore = false;
  updatementorLoaderMore(bool? newValue) {
    mentorLoaderMore = newValue;
    update();
  }
  List<TopRatedStyling> topRatedConsultantList = [];
  List<MentorStyling> getmentorList = [];
  List<MenteeStyling> getmenteeList = [];
}

class HomeStyling {
  HomeStyling({required this.id, this.title, this.subTitle,  this.occupation,this.image, this.color, this.gender});

  int? id;
  String? title;
  String? subTitle;
  String? image;
 List<List<feat.Occupation>>? occupation;
  Color? color;
  String? gender;
}

class TopRatedStyling {
  TopRatedStyling({
    required this.userId,
    this.firstName,
    this.lastName,
    this.occupation,
    this.religion,
    this.from,
    this.to,
    this.imagePath,
    this.topRating,
  });

int? userId;
    String? firstName;
    String? lastName;
    String? imagePath;
    List<List<toprated.Occupation>>? occupation;
     List<String>? religion;
	 DateTime? from;
    DateTime? to;
    String? onlineStatus;
    int? topRating;
    // Category? category;
    int? ratingCount;
    int? ratingAvg;
  // int? id;
  // String? title;
  // String? subTitle;
  // List<List<toprated.Occupation>>? occupation;
  // String? image;
  // int? rating;
}

class MenteeStyling {
  MenteeStyling({

    this.id,
     this.firstName,
    this.lastName,
    this.imagePath,
  
    this.onlineStatus
  });
    int?id;
  String? firstName;
    String? lastName;
  
    String? onlineStatus;
    String? imagePath;
}


class MentorStyling {
  MentorStyling({

    this.id,
     this.firstName,
    this.lastName,
    this.description,
    this.religion,
    this.from,
    this.to,
    this.imagePath,
    this.occupation,
    this.onlineStatus
  });
int?id;
  String? firstName;
    String? lastName;
    List<List<getMent.AppointmentTypeId>>? occupation;
    List<String>? religion;
	 DateTime? from;
    DateTime?to;
    dynamic? description;
    String? onlineStatus;
    String? imagePath;
}
