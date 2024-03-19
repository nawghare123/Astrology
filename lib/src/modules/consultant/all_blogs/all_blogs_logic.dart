import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../../api_services/get_service.dart';
import '../../../api_services/urls.dart';
import '../../../controller/general_controller.dart';
import 'all_blogs_state.dart';
import 'models/consultant_blogs_model.dart';
import 'repos/get_repo/get_blog_repo.dart';

class AllBlogsLogic extends GetxController {
  final AllBlogsState state = AllBlogsState();

  @override
  void onInit() {
    super.onInit();

    scrollController = ScrollController()..addListener(scrollListener);
    // Get.find<BookAppointmentLogic>().selectedPaymentType = null;
    // Get.find<BookAppointmentLogic>().questionController.clear();

    getMethod(Get.context!, consultantBlogUrl, {'token': 123, 'platform': 'app', "user_id": Get.find<GeneralController>().storageBox.read('userID')}, true, getAllBlogsRepo);
  }

  @override
  void onClose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.onClose();
  }

  ScrollController scrollController = ScrollController();
  bool lastStatus = true;

  double height = 100.h;
  bool get isShrink {
    return scrollController.hasClients && scrollController.offset > (height - kToolbarHeight);
  }

  void scrollListener() {
    if (isShrink != lastStatus) {
      lastStatus = isShrink;
      update();
    }
  }

  bool getAllBlogsLoader = false;

  ConsultantBlogsModel consultantBlogsModel = ConsultantBlogsModel();

  /// --- update-post-loader
  updateAllConsultantBlogsLoader(bool value) {
    getAllBlogsLoader = value;
    update();
  }

  bool formLoaderController = false;

  updateFormLoaderController(bool newValue) {
    formLoaderController = newValue;
    update();
  }
}
