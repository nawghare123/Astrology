import 'package:consultant_product/src/modules/main_repo/main_logic.dart';
import 'package:get/get.dart';

/// Get your own App  ID at https://dashboard.agora.io/
final String agoraAppId = '${Get.find<MainLogic>().getConfigCredentialModel.data!.agora![0].value}';
