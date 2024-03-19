import 'package:consultant_product/src/modules/consultant/my_profile/model_get_generic_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'state.dart';

class MyProfileLogic extends GetxController {
  final MyProfileState state = MyProfileState();

  ScrollController? scrollController;
  bool lastStatus = true;
  double height = 100.h;

  bool get isShrink {
    return scrollController!.hasClients &&
        scrollController!.offset > (height - kToolbarHeight);
  }

  void scrollListener() {
    if (isShrink != lastStatus) {
      lastStatus = isShrink;
      update();
    }
  }



  MentorProfileGenericDataModel mentorProfileGenericDataModel = MentorProfileGenericDataModel();


  bool? loader = true;
  updateLoaderForViewProfile(bool? newValue){
    loader = newValue;
    update();
  }
  String? occupation;
  updateOccupation(String? newValue){
    occupation = newValue;
    update();
  }
}
