// import 'package:consultant_product/src/modules/consultant/bottomNav/bottom_nav_controller.dart';
import 'package:consultant_product/src/modules/user/bottomNav/bottom_nav_controller.dart';
import 'package:get/get.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavController>(
      () => BottomNavController(),
    );
  }
}
