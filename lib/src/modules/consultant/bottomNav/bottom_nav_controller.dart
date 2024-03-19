import 'package:get/get.dart';

enum BnbItem { consthome, constchat,constlive, constcall, constprofile }

class ConsultantBottomNavController extends GetxController {
  var currentPage = BnbItem.consthome.obs;

  @override
  void onInit() {
    super.onInit();
  }

  static ConsultantBottomNavController get to => Get.find();

  void changePage(BnbItem bnbItem) {
    print("name:${bnbItem.name}");
    currentPage.value = bnbItem;
    update();
  }
}
