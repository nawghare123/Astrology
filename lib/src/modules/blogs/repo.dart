import 'package:consultant_product/src/modules/blogs/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

blogRepo(
    BuildContext context, bool responseCheck, Map<String, dynamic> response) {
  if (responseCheck) {
    Get.find<BlogsLogic>().getAllBlogModel = GetAllBlogModel.fromJson(response);

    Get.find<BlogsLogic>().updateBlogLoader(true);

    if (Get.find<BlogsLogic>().getAllBlogModel.status == true) {
    } else {}
  } else if (!responseCheck) {
    Get.find<BlogsLogic>().updateBlogLoader(true);
  }
}
