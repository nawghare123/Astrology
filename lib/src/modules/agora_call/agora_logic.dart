import 'package:consultant_product/src/modules/agora_call/agora_model.dart';
import 'package:get/get.dart';

class AgoraLogic extends GetxController {
  AgoraModel agoraModel = AgoraModel();
  AgoraModel agoraModelDefault = AgoraModel();

  String? userName;
  String? userImage;
  final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
}
