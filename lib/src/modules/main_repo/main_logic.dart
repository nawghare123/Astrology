import 'package:consultant_product/src/modules/main_repo/get_config_credential_model.dart';
import 'package:consultant_product/src/modules/main_repo/get_general_setting_model.dart';
import 'package:consultant_product/src/modules/main_repo/terms_condition_model.dart';
import 'package:get/get.dart';

class MainLogic extends GetxController {
  GetConfigCredentialModel getConfigCredentialModel = GetConfigCredentialModel();
  GetGeneralSettingModel getGeneralSettingModel = GetGeneralSettingModel();
  TermsConditionModel termsConditionModel = TermsConditionModel();
}
