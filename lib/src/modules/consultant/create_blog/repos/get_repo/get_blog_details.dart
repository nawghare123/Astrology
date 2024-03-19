import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../create_blog_logic.dart';
import '../../models/blog_details_model.dart';

blogDetailsRepo(BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  Get.find<CreateBlogLogic>().updateFormLoaderController(false);
  if (responseCheck) {
    print(response);
    Get.find<CreateBlogLogic>().blogDetailsModel = BlogDetailsModel.fromJson(response);
    Get.find<CreateBlogLogic>().initializeValue();
  }
}
