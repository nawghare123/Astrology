import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ApiLogic extends GetxController {

  GetStorage storageBox = GetStorage();

  ///-------------------------------internet-check
  bool internetChecker = true;
  changeInternetCheckerState(bool value){
    internetChecker = value;
    update();
  }

}