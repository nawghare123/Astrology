import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/modules/sign_up/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.dart';

class SignUpLogic extends GetxController {
  final SignUpState state = SignUpState();

  SignupModel signupModel = SignupModel();
  late TabController tabController;

  List<Tab> signupRoleTabList = [
    Tab(text: LanguageConstant.user.tr),
    Tab(text: LanguageConstant.mentor.tr)
  ];

  String? selectedRole = 'Mentee';
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? emailValidator;
}
