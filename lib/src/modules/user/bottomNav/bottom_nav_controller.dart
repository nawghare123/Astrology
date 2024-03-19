import 'package:get/get.dart';

enum BnbItem { home, chat,live, call, profile }

class BottomNavController extends GetxController {
  static BottomNavController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  var currentPage = BnbItem.home.obs;
  void changePage(BnbItem bnbItem) {
    print("name:${bnbItem.name}");
    currentPage.value = bnbItem;
  }
}
