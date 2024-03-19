import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/api_services/header.dart';
import 'package:consultant_product/src/api_services/logic.dart';
import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/edit_consultant_profile/logic.dart';
import 'package:consultant_product/src/modules/consultant/edit_consultant_profile/repo_get.dart';
import 'package:consultant_product/src/modules/consultant/edit_consultant_profile/repo_post.dart';
import 'package:consultant_product/src/modules/consultant/edit_consultant_profile/view_location_picker.dart';
import 'package:consultant_product/src/modules/image_full_view/view.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:consultant_product/src/widgets/custom_dialog.dart';
import 'package:consultant_product/src/widgets/upload_image_button.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dio/dio.dart' as dio_instance;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:multiselect/multiselect.dart';
import 'package:resize/resize.dart';
import 'package:search_choices/search_choices.dart';
import 'package:uuid/uuid.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../../multi_language/language_constants.dart';
import '../create_profile/models/model_post_general_info.dart';
import '../create_profile/models/place_service.dart';

class GeneralInfoView extends StatefulWidget {
  const GeneralInfoView({Key? key}) : super(key: key);

  @override
  _GeneralInfoViewState createState() => _GeneralInfoViewState();
}

class _GeneralInfoViewState extends State<GeneralInfoView> {
  final state = Get.find<EditConsultantProfileLogic>().state;

  final GlobalKey<FormState> _generalInfoFormKey = GlobalKey();
final _dropdownFormKey1 = GlobalKey<FormState>();
  File? profileImage;
  List profileImagesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(
        builder: (_generalController) => GetBuilder<EditConsultantProfileLogic>(
              builder: (_editConsultantProfileLogic) => ModalProgressHUD(
                progressIndicator: CircularProgressIndicator(
                  color: customThemeColor,
                ),
                inAsyncCall: _generalController.formLoaderController!,
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: customTextFieldColor,
                  body: Stack(
                    children: [
                      SingleChildScrollView(
                          child: Form(
                        key: _generalInfoFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///---picture
                            _editConsultantProfileLogic
                                            .generalInfoPostModel.data ==
                                        null &&
                                    _generalController
                                            .getConsultantProfileModel.data !=
                                        null &&
                                    profileImage == null
                                ? InkWell(
                                    onTap: () {
                                      changeImagePickerDialog(
                                          context,
                                          _generalController
                                                  .getConsultantProfileModel
                                                  .data!
                                                  .userDetail!
                                                  .imagePath!
                                                  .contains('assets')
                                              ? '$mediaUrl${_generalController.getConsultantProfileModel.data!.userDetail!.imagePath}'
                                              : '${_generalController.getConsultantProfileModel.data!.userDetail!.imagePath}',
                                          true,
                                          null);
                                    },
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 25.h),
                                        child: SizedBox(
                                          height: 103.h,
                                          width: 190.w,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image.network(
                                                _generalController
                                                        .getConsultantProfileModel
                                                        .data!
                                                        .userDetail!
                                                        .imagePath!
                                                        .contains('assets')
                                                    ? '$mediaUrl${_generalController.getConsultantProfileModel.data!.userDetail!.imagePath}'
                                                    : '${_generalController.getConsultantProfileModel.data!.userDetail!.imagePath}',
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                      ),
                                    ),
                                  )
                                : profileImage == null
                                    ? _editConsultantProfileLogic
                                                .generalInfoPostModel.data ==
                                            null
                                        ? InkWell(
                                            onTap: () {
                                              imagePickerDialog(context);
                                            },
                                            child: UploadImageButton(
                                              fieldName: LanguageConstant
                                                  .uploadProfilePhoto,
                                            ))
                                        : Center(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 25.h),
                                              child: SizedBox(
                                                height: 103.h,
                                                width: 190.w,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    child: Image.network(
                                                      _editConsultantProfileLogic
                                                              .generalInfoPostModel
                                                              .data!
                                                              .userDetail!
                                                              .imagePath!
                                                              .contains(
                                                                  'assets')
                                                          ? '$mediaUrl${_editConsultantProfileLogic.generalInfoPostModel.data!.userDetail!.imagePath}'
                                                          : '${_editConsultantProfileLogic.generalInfoPostModel.data!.userDetail!.imagePath}',
                                                      fit: BoxFit.cover,
                                                    )),
                                              ),
                                            ),
                                          )
                                    : InkWell(
                                        onTap: () {
                                          changeImagePickerDialog(context, null,
                                              false, profileImage);
                                        },
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 25.h),
                                            child: SizedBox(
                                              height: 103.h,
                                              width: 190.w,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Image.file(
                                                    profileImage!,
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ),

                            ///---first-name-field
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.w, 0, 15.w, 16.h),
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-z A-Z ]"))
                                ],
                                style: state.textFieldTextStyle,
                                controller: _editConsultantProfileLogic
                                    .firstNameController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          25.w, 15.h, 25.w, 15.h),
                                  hintText: LanguageConstant.firstName.tr,
                                  hintStyle: state.hintTextStyle,
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: customLightThemeColor)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide:
                                          const BorderSide(color: Colors.red)),
                                ),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return LanguageConstant.fieldRequired.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),

                            ///---last-name-field
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.w, 0, 15.w, 16.h),
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-z A-Z ]"))
                                ],
                                style: state.textFieldTextStyle,
                                controller: _editConsultantProfileLogic
                                    .lastNameController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          25.w, 15.h, 25.w, 15.h),
                                  hintText: LanguageConstant.lastName.tr,
                                  hintStyle: state.hintTextStyle,
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: customLightThemeColor)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide:
                                          const BorderSide(color: Colors.red)),
                                ),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return LanguageConstant.fieldRequired.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),

                            ///---father-name-field
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.w, 0, 15.w, 16.h),
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-z A-Z ]"))
                                ],
                                style: state.textFieldTextStyle,
                                controller: _editConsultantProfileLogic
                                    .fatherNameController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          25.w, 15.h, 25.w, 15.h),
                                  hintText: LanguageConstant.fatherName.tr,
                                  hintStyle: state.hintTextStyle,
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: customLightThemeColor)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide:
                                          const BorderSide(color: Colors.red)),
                                ),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return LanguageConstant.fieldRequired.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),

                            // ///---email-field
                            // Padding(
                            //   padding: EdgeInsetsDirectional.fromSTEB(
                            //       15.w, 0, 15.w, 16.h),
                            //   child: TextFormField(
                            //     style: state.textFieldTextStyle,
                            //     controller: _editConsultantProfileLogic.emailController,
                            //     keyboardType: TextInputType.emailAddress,
                            //     decoration: InputDecoration(
                            //       contentPadding:
                            //           EdgeInsetsDirectional.fromSTEB(
                            //               25.w, 15.h, 25.w, 15.h),
                            //       hintText: 'Email Address',
                            //       hintStyle: state.hintTextStyle,
                            //       fillColor: Colors.white,
                            //       filled: true,
                            //       enabledBorder: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(8.r),
                            //           borderSide: const BorderSide(
                            //               color: Colors.transparent)),
                            //       border: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(8.r),
                            //           borderSide: const BorderSide(
                            //               color: Colors.transparent)),
                            //       focusedBorder: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(8.r),
                            //           borderSide: const BorderSide(
                            //               color: customLightThemeColor)),
                            //       errorBorder: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(8.r),
                            //           borderSide:
                            //               const BorderSide(color: Colors.red)),
                            //     ),
                            //     validator: (String? value) {
                            //       if (value!.isEmpty) {
                            //         return 'Field Required'.tr;
                            //       } else if (!GetUtils.isEmail(
                            //           _editConsultantProfileLogic
                            //               .emailController.text)) {
                            //         return 'Enter Valid Email';
                            //       } else {
                            //         return null;
                            //       }
                            //     },
                            //   ),
                            // ),

                            ///---cnic-field
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.w, 0, 15.w, 16.h),
                              child: TextFormField(
                                inputFormatters: const [],
                                style: state.textFieldTextStyle,
                                controller:
                                    _editConsultantProfileLogic.cnicController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          25.w, 15.h, 25.w, 15.h),
                                  hintText: LanguageConstant.enterCNIC.tr,
                                  hintStyle: state.hintTextStyle,
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: customLightThemeColor)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide:
                                          const BorderSide(color: Colors.red)),
                                ),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return LanguageConstant.fieldRequired.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),

                            ///---address-field
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.w, 0, 15.w, 16.h),
                              child: TextFormField(
                                readOnly: true,
                                onTap: () async {
                                  final sessionToken = const Uuid().v4();
                                  final Suggestion? result = await showSearch(
                                    context: context,
                                    delegate: AddressSearch(sessionToken),
                                  );

                                  if (result != null) {
                                    // log('RESULT---->>>${result.description.toString().split(', ')[2]}');
                                    final placeDetails = await PlaceApiProvider(
                                            sessionToken)
                                        .getPlaceDetailFromId(result.placeId);

                                    await _editConsultantProfileLogic.saveData(
                                        latLong: json.encode({
                                          'lat': placeDetails['lat'],
                                          'lng': placeDetails['lng']
                                        }),
                                        place: result.description);
                                  }
                                },
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(200)
                                ],
                                style: state.textFieldTextStyle,
                                controller: _editConsultantProfileLogic
                                    .addressController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          25.w, 15.h, 25.w, 15.h),
                                  hintText: LanguageConstant.enterAddress.tr,
                                  hintStyle: state.hintTextStyle,
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: customLightThemeColor)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide:
                                          const BorderSide(color: Colors.red)),
                                ),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return LanguageConstant.fieldRequired.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),

                            ///---about-field
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.w, 0, 15.w, 16.h),
                              child: TextFormField(
                                inputFormatters: const [],
                                style: state.textFieldTextStyle,
                                controller:
                                    _editConsultantProfileLogic.aboutController,
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          25.w, 15.h, 25.w, 15.h),
                                  hintText: LanguageConstant.aboutYourSelf.tr,
                                  hintStyle: state.hintTextStyle,
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: customLightThemeColor)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide:
                                          const BorderSide(color: Colors.red)),
                                ),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Field Required'.tr;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),

                            ///---gender-religion
                            Row(
                              children: [
                                ///---gender
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.w, 0, 8.w, 16.h),
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField<String>(
                                          onTap: () {
                                            FocusScopeNode currentFocus =
                                                FocusScope.of(context);
                                            if (!currentFocus.hasPrimaryFocus) {
                                              currentFocus.unfocus();
                                            }
                                          },
                                          hint: Text(
                                            LanguageConstant.gender.tr,
                                            style: state.hintTextStyle,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    15.w, 14.h, 15.w, 14.h),
                                            fillColor: Colors.white,
                                            filled: true,
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent)),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: const BorderSide(
                                                    color:
                                                        customLightThemeColor)),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: const BorderSide(
                                                    color: Colors.red)),
                                          ),
                                          isExpanded: true,
                                          focusColor: Colors.white,
                                          style: state.textFieldTextStyle,
                                          iconEnabledColor: customThemeColor,
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          iconSize: 25,
                                          value: _editConsultantProfileLogic
                                              .selectedGender,
                                          items: _editConsultantProfileLogic
                                              .genderDropDownList
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: state.textFieldTextStyle,
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              _editConsultantProfileLogic
                                                  .selectedGender = value!;
                                            });
                                          },
                                          validator: (String? value) {
                                            if (value == null) {
                                              return LanguageConstant
                                                  .fieldRequired.tr;
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                ///---religion
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8.w, 0, 15.w, 16.h),
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child:


                                       Form(
                                          key: _dropdownFormKey1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
   DropDownMultiSelect(
              options:  _editConsultantProfileLogic.languageDropDownList,
              selectedValues:  _editConsultantProfileLogic.selectedlanguage,
              onChanged: (value) {
               // print('selected fruit $value');
                setState(() {
                   _editConsultantProfileLogic.selectedlanguage == value;
                });
               // print('you have selected $_createProfileLogic.selectedlanguage, fruits.');
              },
              whenEmpty: 'Select your language',
            ),


                                            ])),
                                      //  DropdownButtonHideUnderline(
                                      //   child: DropdownButtonFormField<String>(
                                      //     onTap: () {
                                      //       FocusScopeNode currentFocus =
                                      //           FocusScope.of(context);
                                      //       if (!currentFocus.hasPrimaryFocus) {
                                      //         currentFocus.unfocus();
                                      //       }
                                      //     },
                                      //     hint: Text(
                                      //       LanguageConstant.religion.tr,
                                      //       style: state.hintTextStyle,
                                      //     ),
                                      //     decoration: InputDecoration(
                                      //       contentPadding:
                                      //           EdgeInsetsDirectional.fromSTEB(
                                      //               15.w, 14.h, 15.w, 14.h),
                                      //       fillColor: Colors.white,
                                      //       filled: true,
                                      //       enabledBorder: OutlineInputBorder(
                                      //           borderRadius:
                                      //               BorderRadius.circular(8.r),
                                      //           borderSide: const BorderSide(
                                      //               color: Colors.transparent)),
                                      //       border: OutlineInputBorder(
                                      //           borderRadius:
                                      //               BorderRadius.circular(8.r),
                                      //           borderSide: const BorderSide(
                                      //               color: Colors.transparent)),
                                      //       focusedBorder: OutlineInputBorder(
                                      //           borderRadius:
                                      //               BorderRadius.circular(8.r),
                                      //           borderSide: const BorderSide(
                                      //               color:
                                      //                   customLightThemeColor)),
                                      //       errorBorder: OutlineInputBorder(
                                      //           borderRadius:
                                      //               BorderRadius.circular(8.r),
                                      //           borderSide: const BorderSide(
                                      //               color: Colors.red)),
                                      //     ),
                                      //     isExpanded: true,
                                      //     focusColor: Colors.white,
                                      //     style: state.textFieldTextStyle,
                                      //     iconEnabledColor: customThemeColor,
                                      //     icon: const Icon(
                                      //         Icons.keyboard_arrow_down),
                                      //     iconSize: 25,
                                      //     value: _editConsultantProfileLogic
                                      //         .selectedReligion,
                                      //     items: _editConsultantProfileLogic
                                      //         .religionDropDownList
                                      //         .map<DropdownMenuItem<String>>(
                                      //             (String value) {
                                      //       return DropdownMenuItem<String>(
                                      //         value: value,
                                      //         child: Text(
                                      //           value,
                                      //           style: state.textFieldTextStyle,
                                      //         ),
                                      //       );
                                      //     }).toList(),
                                      //     onChanged: (String? value) {
                                      //       setState(() {
                                      //         _editConsultantProfileLogic
                                      //             .selectedReligion = value;
                                      //       });
                                      //     },
                                      //     validator: (String? value) {
                                      //       if (value == null) {
                                      //         return LanguageConstant
                                      //             .fieldRequired.tr;
                                      //       } else {
                                      //         return null;
                                      //       }
                                      //     },
                                      //   ),
                                      // ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            ///---dob-occupation
                            Row(
                              children: [
                                ///---dob
                                
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.w, 0, 8.w, 16.h),
                                    child: Theme(
                                      data: ThemeData(
                                          colorScheme: ColorScheme.fromSwatch()
                                              .copyWith(
                                                  primary: customThemeColor)),
                                      child: DateTimeField(
                                        controller: _editConsultantProfileLogic
                                            .dobController,
                                        style: state.textFieldTextStyle,
                                        decoration: InputDecoration(
                                            hintText: LanguageConstant.dob.tr,
                                            hintStyle: state.hintTextStyle,
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    25.w, 15.h, 15.w, 15.h),
                                            fillColor: Colors.white,
                                            filled: true,
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent)),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: const BorderSide(
                                                    color:
                                                        customLightThemeColor)),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: const BorderSide(color: Colors.red)),
                                            suffixIcon: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .all(15.0),
                                              child: SvgPicture.asset(
                                                'assets/Icons/calendarIcon.svg',
                                              ),
                                            )),
                                        initialValue:
                                            _editConsultantProfileLogic
                                                .selectedDob,
                                        format: DateFormat('dd-MM-yyyy'),
                                        onShowPicker:
                                            (context, currentValue) async {
                                          final date = await showDatePicker(
                                              context: context,
                                              firstDate: DateTime(1900),
                                              initialDate: currentValue ??
                                                  DateTime.now(),
                                              lastDate: DateTime.now());
                                          if (date != null) {
                                            return date;
                                          } else {
                                            return currentValue;
                                          }
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return LanguageConstant
                                                .fieldRequired.tr;
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            _editConsultantProfileLogic
                                                .selectedDob = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),



                                ///---occupation
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8.w, 0, 15.w, 16.h),
                                    child: ButtonTheme(
                                        alignedDropdown: true,
                                        // child: DropdownButtonHideUnderline(
                                        //   child: DropdownButtonFormField<String>(
                                        //     onTap: () {
                                        //       FocusScopeNode currentFocus =
                                        //           FocusScope.of(context);
                                        //       if (!currentFocus.hasPrimaryFocus) {
                                        //         currentFocus.unfocus();
                                        //       }
                                        //     },
                                        //     hint: Text(
                                        //       LanguageConstant.occupation.tr,
                                        //       style: state.hintTextStyle,
                                        //     ),
                                        //     decoration: InputDecoration(
                                        //       contentPadding:
                                        //           EdgeInsetsDirectional.fromSTEB(
                                        //               15.w, 14.h, 15.w, 14.h),
                                        //       fillColor: Colors.white,
                                        //       filled: true,
                                        //       enabledBorder: OutlineInputBorder(
                                        //           borderRadius:
                                        //               BorderRadius.circular(8.r),
                                        //           borderSide: const BorderSide(
                                        //               color: Colors.transparent)),
                                        //       border: OutlineInputBorder(
                                        //           borderRadius:
                                        //               BorderRadius.circular(8.r),
                                        //           borderSide: const BorderSide(
                                        //               color: Colors.transparent)),
                                        //       focusedBorder: OutlineInputBorder(
                                        //           borderRadius:
                                        //               BorderRadius.circular(8.r),
                                        //           borderSide: const BorderSide(
                                        //               color:
                                        //                   customLightThemeColor)),
                                        //       errorBorder: OutlineInputBorder(
                                        //           borderRadius:
                                        //               BorderRadius.circular(8.r),
                                        //           borderSide: const BorderSide(
                                        //               color: Colors.red)),
                                        //     ),
                                        //     isExpanded: true,
                                        //     focusColor: Colors.white,
                                        //     style: state.textFieldTextStyle,
                                        //     iconEnabledColor: customThemeColor,
                                        //     icon: const Icon(
                                        //         Icons.keyboard_arrow_down),
                                        //     iconSize: 25,
                                        //     value: _editConsultantProfileLogic
                                        //         .selectedOccupation,
                                        //     items: _editConsultantProfileLogic
                                        //         .occupationDropDownList
                                        //         .map<DropdownMenuItem<String>>(
                                        //             (String value) {
                                        //       return DropdownMenuItem<String>(
                                        //         value: value,
                                        //         child: Text(
                                        //           value,
                                        //           // softWrap: true,overflow: TextOverflow.ellipsis,maxLines: 1,
                                        //           style: state.textFieldTextStyle,
                                        //         ),
                                        //       );
                                        //     }).toList(),
                                        //     onChanged: (String? value) {
                                        //       setState(() {
                                        //         _editConsultantProfileLogic
                                        //             .selectedOccupation = value;
                                        //       });
                                        //     },
                                        //     validator: (String? value) {
                                        //       if (value == null) {
                                        //         return LanguageConstant
                                        //             .fieldRequired.tr;
                                        //       } else {
                                        //         return null;
                                        //       }
                                        //     },
                                        //   ),
                                        // ),

                                        child: SearchChoices.multiple(
                                          items: _editConsultantProfileLogic
                                              .occupationDropDownList
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                // softWrap: true,overflow: TextOverflow.ellipsis,maxLines: 1,
                                                style: state.textFieldTextStyle,
                                              ),
                                            );
                                          }).toList(),
                                          selectedItems:
                                              _editConsultantProfileLogic
                                                          .selectedOccupationUI !=
                                                      null
                                                  ? _editConsultantProfileLogic
                                                      .selectedOccupationUI!
                                                      .asMap()
                                                      .keys
                                                      .toList()
                                                  : [],
                                          // _editConsultantProfileLogic
                                          //     .occupationDropDownList,
                                          //  _editConsultantProfileLogic
                                          // .selectedOccupation,
                                          hint: "Speciality",
                                          searchHint: "Select 3",
                                          // validator:
                                          //     (selectedItemsForValidator) {
                                          //   if (selectedItemsForValidator!
                                          //           .length !=
                                          //       3) {
                                          //     return ("Must select 3");
                                          //   }
                                          //   return (null);
                                          // },
                                          onChanged: (value) {
                                            // print(
                                            //     "======>>>>> value  ${value.toString()}");
                                            // setState(() {
                                            //   selectedItemsMultiSelect3Dialog = value;
                                            // });

                                            //     onChanged: (String? value) {
                                            setState(() {
                                              // _editConsultantProfileLogic
                                              //         .selectedOccupation =
                                              //     value;
                                              _editConsultantProfileLogic
                                                      .selectedOccupationUI =
                                                  value.map((element) {
                                                _editConsultantProfileLogic
                                                        .occupationDropDownList[
                                                    int.parse(
                                                        element.toString())];
                                              }).toList();

                                              print(
                                                  "======>>>>> Sending values: ");
                                              value.forEach((element) {
                                                print(
                                                    "=====>>>>> index $element");
                                                print("=====>>>>>> element " +
                                                    _editConsultantProfileLogic
                                                            .occupationDropDownList[
                                                        int.parse(element
                                                            .toString())]);
                                              });
                                              // Get.find<
                                              //         EditConsultantProfileLogic>()
                                              //     .updateSelectedOccupationList();
                                            });

                                            value.forEach((element) {
                                              Get.find<
                                                      EditConsultantProfileLogic>()
                                                  .updateSelectedOccupationList(
                                                      (_editConsultantProfileLogic
                                                              .occupationDropDownList[
                                                          int.parse(element
                                                              .toString())]));
                                            });
                                            // print(
                                            //     "======>>>>> updated  ${value.toString()}");
                                            // _editConsultantProfileLogic
                                            //     .occupationDropDownList
                                            //     .forEach((element) => print(
                                            //         "====================>>>>>>>>>" +
                                            //             element
                                            //                 .toString()));

                                            //     },
                                          },
                                          doneButton:
                                              (selectedItemsDone, doneContext) {
                                            return (ElevatedButton(
                                                onPressed: selectedItemsDone
                                                            .length >
                                                        3
                                                    ? null
                                                    : () {
                                                        Navigator.pop(
                                                            doneContext);
                                                        _editConsultantProfileLogic
                                                                .selectedOccupationUI =
                                                            selectedItemsDone
                                                                .map((element) {
                                                          _editConsultantProfileLogic
                                                                  .occupationDropDownList[
                                                              int.parse(element
                                                                  .toString())];
                                                        }).toList();
                                                        setState(() {});
                                                        print(
                                                            "======>>>>> Sending values: ");
                                                        selectedItemsDone
                                                            .forEach((element) {
                                                          print(
                                                              "=====>>>>> index $element");
                                                          print("=====>>>>>> element " +
                                                              _editConsultantProfileLogic
                                                                      .occupationDropDownList[
                                                                  int.parse(element
                                                                      .toString())]);
                                                        });
                                                        // Get.find<
                                                        //         EditConsultantProfileLogic>()
                                                        //     .updateSelectedOccupationList(
                                                        //         selectedItemsDone
                                                        //             .forEach((element) {
                                                        //   _editConsultantProfileLogic
                                                        //           .occupationDropDownList[
                                                        //       int.parse(
                                                        //           element.toString())];
                                                        // }));
                                                        selectedItemsDone
                                                            .forEach((element) {
                                                          Get.find<
                                                                  EditConsultantProfileLogic>()
                                                              .updateSelectedOccupationList(
                                                                  (_editConsultantProfileLogic
                                                                          .occupationDropDownList[
                                                                      int.parse(
                                                                          element
                                                                              .toString())]));
                                                        });
                                                      },
                                                child: Text("Save")));
                                          },
                                          closeButton: (selectedItemsClose) {
                                            return (selectedItemsClose.length ==
                                                    3
                                                ? "Ok"
                                                : null);
                                          },
                                          isExpanded: true,
                                        )),
                                  ),
                                ),
                              ],
                            ),

                            ///---country-city
                            Row(
                              children: [
                                ///---country
                                ///

                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.w, 0, 8.w, 16.h),
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: Form(
                                          //  key: _generalInfoFormKey,
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // DropdownSearch(
                                          //   items: _createProfileLogic
                                          //       .countryDropDownList,
                                          //   // dropdownSearchDecoration: InputDecoration(labelText: "Name"),
                                          //   onChanged: print,
                                          //   selectedItem: "Tunisia",
                                          //   validator: (String? item) {
                                          //     if (item == null)
                                          //       return "Required field";
                                          //     else if (item == "Brazil")
                                          //       return "Invalid item";
                                          //     else
                                          //       return null;
                                          //   },
                                          // ),

                                          SearchChoices.single(
                                            items: _editConsultantProfileLogic
                                                .countryDropDownList
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style:
                                                      state.textFieldTextStyle,
                                                ),
                                              );
                                            }).toList(),
                                            value: _editConsultantProfileLogic
                                                .selectedCountry,
                                            hint: "Select one",
                                            searchHint: "Select one",
                                            onChanged: (value) {
                                              setState(() {
                                                // _editConsultantProfileLogic
                                                //     .selectedCountry = value;
                                                _editConsultantProfileLogic
                                                    .updateCountry(
                                                        value.toString());
                                              });
                                              Get.find<GeneralController>()
                                                  .updateFormLoaderController(
                                                      true);
                                              getMethod(
                                                  context,
                                                  getCitiesByIdUrl,
                                                  {
                                                    'token': '123',
                                                    'country_id': _editConsultantProfileLogic
                                                        .mentorProfileGenericDataModel
                                                        .data!
                                                        .countries![_editConsultantProfileLogic
                                                            .countryDropDownList
                                                            .indexOf(
                                                                _editConsultantProfileLogic
                                                                    .selectedCountry!)]
                                                        .id
                                                  },
                                                  false,
                                                  getCitiesRepo);
                                            },
                                            isExpanded: true,
                                          ),

                                          /// experimenting above
                                          // DropdownButtonFormField<String>(
                                          //   onTap: () {
                                          //     FocusScopeNode currentFocus =
                                          //         FocusScope.of(context);

                                          //     if (!currentFocus
                                          //         .hasPrimaryFocus) {
                                          //       currentFocus.unfocus();
                                          //     }
                                          //   },
                                          //   value: _createProfileLogic
                                          //       .selectedCountry,
                                          //   // onChanged: (value) {
                                          //   //   setState(() {
                                          //   //     _createProfileLogic
                                          //   //         .selectedCountry = value;
                                          //   //   });
                                          //   // },
                                          //   items: _createProfileLogic
                                          //       .countryDropDownList
                                          //       .map<DropdownMenuItem<String>>(
                                          //           (String value) {
                                          //     return DropdownMenuItem<String>(
                                          //       value: value,
                                          //       child: Text(
                                          //         value,
                                          //         style:
                                          //             state.textFieldTextStyle,
                                          //       ),
                                          //     );
                                          //   }).toList(),
                                          //   onChanged: (String? value) {
                                          //     setState(() {
                                          //       _createProfileLogic
                                          //           .selectedCountry = value;
                                          //     });
                                          //     Get.find<GeneralController>()
                                          //         .updateFormLoaderController(
                                          //             true);
                                          //     getMethod(
                                          //         context,
                                          //         getCitiesByIdUrl,
                                          //         {
                                          //           'token': '123',
                                          //           'country_id': _createProfileLogic
                                          //               .mentorProfileGenericDataModel
                                          //               .data!
                                          //               .countries![_createProfileLogic
                                          //                   .countryDropDownList
                                          //                   .indexOf(
                                          //                       _createProfileLogic
                                          //                           .selectedCountry!)]
                                          //               .id
                                          //         },
                                          //         false,
                                          //         getCitiesRepo);
                                          //   },
                                          //   validator: (String? value) {
                                          //     if (value == null) {
                                          //       return LanguageConstant
                                          //           .fieldRequired.tr;
                                          //     } else {
                                          //       return null;
                                          //     }
                                          //   },
                                          // ),

                                          // TextField(
                                          //   onChanged: (value) {
                                          //     if (value.length > 1) {
                                          //       setState(() {
                                          //         _createProfileLogic
                                          //             .selectedCountry = value;
                                          //       });
                                          //     }
                                          //   },
                                          //   decoration: InputDecoration(
                                          //     labelText: 'Search',
                                          //   ),
                                          // ),

                                          ////------------------------------

                                          // DropdownSearch<String>(
                                          //   popupProps: PopupProps.menu(
                                          //     showSelectedItems: true,
                                          //     disabledItemFn: (String s) =>
                                          //         s.startsWith('I'),
                                          //   ),
                                          //   items: [
                                          //     "Brazil",
                                          //     "Italia (Disabled)",
                                          //     "Tunisia",
                                          //     'Canada'
                                          //   ],
                                          //   dropdownDecoratorProps:
                                          //       DropDownDecoratorProps(
                                          //     dropdownSearchDecoration:
                                          //         InputDecoration(
                                          //       labelText: "Menu mode",
                                          //       hintText:
                                          //           "country in menu mode",
                                          //     ),
                                          //   ),
                                          //   onChanged: print,
                                          //   selectedItem: "Brazil",
                                          // ),

                                          // DropdownSearch<String>.multiSelection(
                                          //   items: [
                                          //     "Brazil",
                                          //     "Italia (Disabled)",
                                          //     "Tunisia",
                                          //     'Canada'
                                          //   ],
                                          //   popupProps:
                                          //       PopupPropsMultiSelection.menu(
                                          //     showSelectedItems: true,
                                          //     disabledItemFn: (String s) =>
                                          //         s.startsWith('I'),
                                          //   ),
                                          //   onChanged: print,
                                          //   selectedItems: ["Brazil"],
                                          // )
                                          // DropdownSearch(
                                          //   items: [
                                          //     "Brazil",
                                          //     "France",
                                          //     "Tunisia",
                                          //     "Canada"
                                          //   ],
                                          //   // dropdownSearchDecoration: InputDecoration(labelText: "Name"),
                                          //   onChanged: print,
                                          //   selectedItem: "Tunisia",
                                          //   validator: (String? item) {
                                          //     if (item == null)
                                          //       return "Required field";
                                          //     else if (item == "Brazil")
                                          //       return "Invalid item";
                                          //     else
                                          //       return null;
                                          //   },
                                          // )

                                          // DropdownButtonHideUnderline(
                                          //   child:
                                          //       DropdownButtonFormField<String>(
                                          //     onTap: () {
                                          //       FocusScopeNode currentFocus =
                                          //           FocusScope.of(context);
                                          //       if (!currentFocus
                                          //           .hasPrimaryFocus) {
                                          //         currentFocus.unfocus();
                                          //       }
                                          //     },
                                          //     hint: Text(
                                          //       LanguageConstant.country.tr,
                                          //       style: state.hintTextStyle,
                                          //     ),
                                          //     decoration: InputDecoration(
                                          //       contentPadding:
                                          //           EdgeInsetsDirectional
                                          //               .fromSTEB(15.w, 14.h,
                                          //                   15.w, 14.h),
                                          //       fillColor: Colors.white,
                                          //       filled: true,
                                          //       enabledBorder: OutlineInputBorder(
                                          //           borderRadius:
                                          //               BorderRadius.circular(
                                          //                   8.r),
                                          //           borderSide:
                                          //               const BorderSide(
                                          //                   color: Colors
                                          //                       .transparent)),
                                          //       border: OutlineInputBorder(
                                          //           borderRadius:
                                          //               BorderRadius.circular(
                                          //                   8.r),
                                          //           borderSide:
                                          //               const BorderSide(
                                          //                   color: Colors
                                          //                       .transparent)),
                                          //       focusedBorder: OutlineInputBorder(
                                          //           borderRadius:
                                          //               BorderRadius.circular(
                                          //                   8.r),
                                          //           borderSide: const BorderSide(
                                          //               color:
                                          //                   customLightThemeColor)),
                                          //       errorBorder: OutlineInputBorder(
                                          //           borderRadius:
                                          //               BorderRadius.circular(
                                          //                   8.r),
                                          //           borderSide:
                                          //               const BorderSide(
                                          //                   color: Colors.red)),
                                          //     ),
                                          //     isExpanded: true,
                                          //     focusColor: Colors.white,
                                          //     style: state.textFieldTextStyle,
                                          //     iconEnabledColor:
                                          //         customThemeColor,
                                          //     icon: const Icon(
                                          //         Icons.keyboard_arrow_down),
                                          //     iconSize: 25,
                                          //     value: _createProfileLogic
                                          //         .selectedCountry,
                                          //     items: _createProfileLogic
                                          //         .countryDropDownList
                                          //         .map<
                                          //                 DropdownMenuItem<
                                          //                     String>>(
                                          //             (String value) {
                                          //       return DropdownMenuItem<String>(
                                          //         value: value,
                                          //         child: Text(
                                          //           value,
                                          //           style: state
                                          //               .textFieldTextStyle,
                                          //         ),
                                          //       );
                                          //     }).toList(),
                                          //     onChanged: (String? value) {
                                          //       setState(() {
                                          //         _createProfileLogic
                                          //             .selectedCountry = value;
                                          //       });
                                          //       Get.find<GeneralController>()
                                          //           .updateFormLoaderController(
                                          //               true);
                                          //       getMethod(
                                          //           context,
                                          //           getCitiesByIdUrl,
                                          //           {
                                          //             'token': '123',
                                          //             'country_id': _createProfileLogic
                                          //                 .mentorProfileGenericDataModel
                                          //                 .data!
                                          //                 .countries![_createProfileLogic
                                          //                     .countryDropDownList
                                          //                     .indexOf(
                                          //                         _createProfileLogic
                                          //                             .selectedCountry!)]
                                          //                 .id
                                          //           },
                                          //           false,
                                          //           getCitiesRepo);
                                          //     },
                                          //     validator: (String? value) {
                                          //       if (value == null) {
                                          //         return LanguageConstant
                                          //             .fieldRequired.tr;
                                          //       } else {
                                          //         return null;
                                          //       }
                                          //     },
                                          //   ),
                                          // ),
                                        ],
                                      )),
                                    ),
                                  ),
                                ),

                                ///---city
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8.w, 0, 15.w, 16.h),
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child:
                                          // DropdownButtonHideUnderline(
                                          //   child: DropdownButtonFormField<String>(
                                          //     onTap: () {
                                          //       FocusScopeNode currentFocus =
                                          //           FocusScope.of(context);
                                          //       if (!currentFocus.hasPrimaryFocus) {
                                          //         currentFocus.unfocus();
                                          //       }
                                          //     },
                                          //     hint: Text(
                                          //       LanguageConstant.city.tr,
                                          //       style: state.hintTextStyle,
                                          //     ),
                                          //     decoration: InputDecoration(
                                          //       contentPadding:
                                          //           EdgeInsetsDirectional.fromSTEB(
                                          //               15.w, 14.h, 15.w, 14.h),
                                          //       fillColor: Colors.white,
                                          //       filled: true,
                                          //       enabledBorder: OutlineInputBorder(
                                          //           borderRadius:
                                          //               BorderRadius.circular(8.r),
                                          //           borderSide: const BorderSide(
                                          //               color: Colors.transparent)),
                                          //       border: OutlineInputBorder(
                                          //           borderRadius:
                                          //               BorderRadius.circular(8.r),
                                          //           borderSide: const BorderSide(
                                          //               color: Colors.transparent)),
                                          //       focusedBorder: OutlineInputBorder(
                                          //           borderRadius:
                                          //               BorderRadius.circular(8.r),
                                          //           borderSide: const BorderSide(
                                          //               color:
                                          //                   customLightThemeColor)),
                                          //       errorBorder: OutlineInputBorder(
                                          //           borderRadius:
                                          //               BorderRadius.circular(8.r),
                                          //           borderSide: const BorderSide(
                                          //               color: Colors.red)),
                                          //     ),
                                          //     isExpanded: true,
                                          //     focusColor: Colors.white,
                                          //     style: state.textFieldTextStyle,
                                          //     iconEnabledColor: customThemeColor,
                                          //     icon: const Icon(
                                          //         Icons.keyboard_arrow_down),
                                          //     iconSize: 25,
                                          //     value:
                                          //         _createProfileLogic.selectedCity,
                                          //     items: _createProfileLogic
                                          //         .cityDropDownList
                                          //         .map<DropdownMenuItem<String>>(
                                          //             (String value) {
                                          //       return DropdownMenuItem<String>(
                                          //         value: value,
                                          //         child: Text(
                                          //           value,
                                          //           style: state.textFieldTextStyle,
                                          //         ),
                                          //       );
                                          //     }).toList(),
                                          //     onChanged: (String? value) {
                                          //       setState(() {
                                          //         _createProfileLogic.selectedCity =
                                          //             value;
                                          //       });
                                          //     },
                                          //     validator: (String? value) {
                                          //       if (value == null) {
                                          //         return LanguageConstant
                                          //             .fieldRequired.tr;
                                          //       } else {
                                          //         return null;
                                          //       }
                                          //     },
                                          //   ),
                                          // ),

                                          SearchChoices.single(
                                        items: _editConsultantProfileLogic
                                            .cityDropDownList
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: state.textFieldTextStyle,
                                            ),
                                          );
                                        }).toList(),
                                        value: _editConsultantProfileLogic
                                            .selectedCity,
                                        hint: "Select one",
                                        searchHint: "Select one",
                                        onChanged: (String? value) {
                                          setState(() {
                                            _editConsultantProfileLogic
                                                .selectedCity = value;
                                          });
                                        },
                                        isExpanded: true,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                  bottomNavigationBar: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15.w, 0, 15.w, 0),
                    child: InkWell(
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          if (_generalInfoFormKey.currentState!.validate()) {
                            if (profileImage != null) {
                              Get.find<GeneralController>()
                                  .updateFormLoaderController(true);
                              mentorGeneralInfoRepo(profileImage);
                            } else if (_editConsultantProfileLogic
                                        .generalInfoPostModel.data !=
                                    null &&
                                profileImage == null) {
                              Get.find<GeneralController>()
                                  .updateFormLoaderController(true);
                              postMethod(
                                  context,
                                  mentorGeneralInfoPostUrl,
                                  {
                                    'token': '123',
                                    'mentor_id': Get.find<GeneralController>()
                                        .storageBox
                                        .read('userID'),
                                    'first_name': _editConsultantProfileLogic
                                        .firstNameController.text,
                                    'last_name': _editConsultantProfileLogic
                                        .lastNameController.text,
                                    'father_name': _editConsultantProfileLogic
                                        .fatherNameController.text,
                                    'cnic': _editConsultantProfileLogic
                                        .cnicController.text,
                                    // 'email': _editConsultantProfileLogic
                                    //     .emailController.text,
                                    'address': _editConsultantProfileLogic
                                        .addressController.text,
                                    'about': _editConsultantProfileLogic
                                        .aboutController.text,
                                    'gender': _editConsultantProfileLogic
                                        .selectedGender,
                                    'religion': _editConsultantProfileLogic
                                        .selectedReligion,
                                    'dob': DateFormat('yyyy-MM-dd')
                                        .format(_editConsultantProfileLogic
                                            .selectedDob!)
                                        .toString(),
                                    // 'occupation': _editConsultantProfileLogic
                                    //     .mentorProfileGenericDataModel
                                    //     .data!
                                    //     .occupations![
                                    //         _editConsultantProfileLogic
                                    //             .occupationDropDownList
                                    //             .indexOf(
                                    //                 _editConsultantProfileLogic
                                    //                     .selectedOccupation!)]
                                    //     .id,
  'occupation': _editConsultantProfileLogic
                                        .selectedOccupation!
                                        .toSet()
                                        .map((occupation) {
                                      int index = _editConsultantProfileLogic
                                          .occupationDropDownList
                                          .indexOf(occupation);
                                      if (index >= 0) {
                                        return _editConsultantProfileLogic
                                                .mentorProfileGenericDataModel
                                                .data!
                                                .occupations![index]
                                                .id
                                            // .toString()
                                            ;
                                      }
                                      return ''; //
                                    }).toList(),
                                    'country': _editConsultantProfileLogic
                                        .mentorProfileGenericDataModel
                                        .data!
                                        .countries![_editConsultantProfileLogic
                                            .countryDropDownList
                                            .indexOf(_editConsultantProfileLogic
                                                .selectedCountry!)]
                                        .id,
                                    'city': _editConsultantProfileLogic
                                        .selectedCity,
                                  },
                                  true,
                                  mentorGeneralInfo2Repo);
                            } else if (_generalController
                                        .getConsultantProfileModel.data !=
                                    null &&
                                profileImage == null) {
                              Get.find<GeneralController>()
                                  .updateFormLoaderController(true);
                              postMethod(
                                  context,
                                  mentorGeneralInfoPostUrl,
                                  {
                                    'token': '123',
                                    'mentor_id': Get.find<GeneralController>()
                                        .storageBox
                                        .read('userID'),
                                    'first_name': _editConsultantProfileLogic
                                        .firstNameController.text,
                                    'last_name': _editConsultantProfileLogic
                                        .lastNameController.text,
                                    'father_name': _editConsultantProfileLogic
                                        .fatherNameController.text,
                                    'cnic': _editConsultantProfileLogic
                                        .cnicController.text,
                                    'about': _editConsultantProfileLogic
                                        .aboutController.text,
                                    'email': _editConsultantProfileLogic
                                        .emailController.text,
                                    'address': _editConsultantProfileLogic
                                        .addressController.text,
                                    'gender': _editConsultantProfileLogic
                                        .selectedGender,
                                    'religion': _editConsultantProfileLogic.selectedlanguage,
                                    'dob': DateFormat('yyyy-MM-dd')
                                        .format(_editConsultantProfileLogic
                                            .selectedDob!)
                                        .toString(),
                                    'occupation': _editConsultantProfileLogic
                                        .selectedOccupation!
                                        .toSet()
                                        .map((occupation) {
                                      int index = _editConsultantProfileLogic
                                          .occupationDropDownList
                                          .indexOf(occupation);
                                      if (index >= 0) {
                                        return _editConsultantProfileLogic
                                                .mentorProfileGenericDataModel
                                                .data!
                                                .occupations![index]
                                                .id
                                            // .toString()
                                            ;
                                      }
                                      return ''; //
                                    }).toList(),
                                    'country': _editConsultantProfileLogic
                                        .mentorProfileGenericDataModel
                                        .data!
                                        .countries![_editConsultantProfileLogic
                                            .countryDropDownList
                                            .indexOf(_editConsultantProfileLogic
                                                .selectedCountry!)]
                                        .id,
                                    'city': _editConsultantProfileLogic
                                        .selectedCity,
                                  },
                                  true,
                                  mentorGeneralInfo2Repo);
                            } else {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return CustomDialogBox(
                                      title: LanguageConstant.sorry.tr,
                                      titleColor: customDialogErrorColor,
                                      descriptions: LanguageConstant
                                          .uploadYourProfilePicture.tr,
                                      text: LanguageConstant.ok.tr,
                                      functionCall: () {
                                        Navigator.pop(context);
                                      },
                                      img: 'assets/Icons/dialog_error.svg',
                                    );
                                  });
                            }
                          }
                        },
                        child: MyCustomBottomBar(
                            title: LanguageConstant.nextStep.tr,
                            disable: false)),
                  ),
                ),
              ),
            ));
  }

  void changeImagePickerDialog(
      BuildContext context, String? image, bool? isNetwork, File? fileImage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                    if (isNetwork!) {
                      Get.to(ImageViewScreen(
                        networkImage: image,
                      ));
                    } else {
                      Get.to(ImageViewScreen(
                        fileImage: fileImage,
                      ));
                    }
                  },
                  child: Text(
                    LanguageConstant.view.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: 18),
                  )),
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () async {
                    Navigator.pop(context);
                    imagePickerDialog(context);
                  },
                  child: Text(
                    LanguageConstant.change.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: 18),
                  )),
            ],
          );
        });
  }

  void imagePickerDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () async {
                    Navigator.pop(context);
                    setState(() {
                      profileImagesList = [];
                    });
                    profileImagesList.add(await ImagePickerGC.pickImage(
                        enableCloseButton: true,
                        context: context,
                        source: ImgSource.Camera,
                        barrierDismissible: true,
                        imageQuality: 10,
                        maxWidth: 400,
                        maxHeight: 600));
                    if (profileImagesList.isNotEmpty) {
                      setState(() {
                        profileImage = File(profileImagesList[0].path);
                      });
                    }
                  },
                  child: Text(
                    LanguageConstant.camera.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: 18),
                  )),
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () async {
                    Navigator.pop(context);
                    setState(() {
                      profileImagesList = [];
                    });
                    profileImagesList.add(await ImagePickerGC.pickImage(
                        enableCloseButton: true,
                        context: context,
                        source: ImgSource.Gallery,
                        barrierDismissible: true,
                        imageQuality: 10,
                        maxWidth: 400,
                        maxHeight: 600));
                    if (profileImagesList.isNotEmpty) {
                      setState(() {
                        profileImage = File(profileImagesList[0].path);
                      });
                    }
                  },
                  child: Text(
                    LanguageConstant.gallery.tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: 18),
                  )),
            ],
          );
        });
  }

  mentorGeneralInfoRepo(File? file1) async {
    dio_instance.FormData formData =
        dio_instance.FormData.fromMap(<String, dynamic>{
      'token': '123',
      'mentor_id': Get.find<GeneralController>().storageBox.read('userID'),
      'first_name':
          Get.find<EditConsultantProfileLogic>().firstNameController.text,
      'last_name':
          Get.find<EditConsultantProfileLogic>().lastNameController.text,
      'father_name':
          Get.find<EditConsultantProfileLogic>().fatherNameController.text,
      'cnic': Get.find<EditConsultantProfileLogic>().cnicController.text,
      'address': Get.find<EditConsultantProfileLogic>().addressController.text,
      'about': Get.find<EditConsultantProfileLogic>().aboutController.text,
      'gender': Get.find<EditConsultantProfileLogic>().selectedGender,
      'religion': Get.find<EditConsultantProfileLogic>().selectedlanguage,
      'dob': DateFormat('yyyy-MM-dd')
          .format(Get.find<EditConsultantProfileLogic>().selectedDob!)
          .toString(),
      // 'occupation': Get.find<EditConsultantProfileLogic>()
      //     .mentorProfileGenericDataModel
      //     .data!
      //     .occupations![Get.find<EditConsultantProfileLogic>()
      //         .occupationDropDownList
      //         .indexOf(
      //             Get.find<EditConsultantProfileLogic>().selectedOccupation!)]
      //     .id,

      'occupation': Get.find<EditConsultantProfileLogic>()
          .selectedOccupation!
          .map((occupation) {
        int index = Get.find<EditConsultantProfileLogic>()
            .occupationDropDownList
            .indexOf(occupation);
        if (index >= 0) {
          return Get.find<EditConsultantProfileLogic>()
              .mentorProfileGenericDataModel
              .data!
              .occupations![index]
              .id;
        }
        return ''; //
      }),
      'country': Get.find<EditConsultantProfileLogic>()
          .mentorProfileGenericDataModel
          .data!
          .countries![Get.find<EditConsultantProfileLogic>()
              .countryDropDownList
              .indexOf(Get.find<EditConsultantProfileLogic>().selectedCountry!)]
          .id,
      'city': Get.find<EditConsultantProfileLogic>().selectedCity,
      'picture': await dio_instance.MultipartFile.fromFile(
        file1!.path,
      )
    });
    dio_instance.Dio dio = dio_instance.Dio();
    setCustomHeader(dio, 'Authorization',
        'Bearer ${Get.find<ApiLogic>().storageBox.read('authToken')}');
    dio_instance.Response response;
    try {
      response = await dio.post(mentorGeneralInfoPostUrl, data: formData);

      if (response.statusCode == 200) {
        Get.find<EditConsultantProfileLogic>().generalInfoPostModel =
            GeneralInfoPostModel.fromJson(response.data);
        if (Get.find<EditConsultantProfileLogic>()
                .generalInfoPostModel
                .status ==
            true) {
          Get.find<EditConsultantProfileLogic>()
              .stepperList[Get.find<EditConsultantProfileLogic>().stepperIndex!]
              .isSelected = false;
          Get.find<EditConsultantProfileLogic>()
              .stepperList[Get.find<EditConsultantProfileLogic>().stepperIndex!]
              .isCompleted = true;
          Get.find<EditConsultantProfileLogic>()
              .stepperList[
                  Get.find<EditConsultantProfileLogic>().stepperIndex! + 1]
              .isSelected = true;
          Get.find<EditConsultantProfileLogic>().updateStepperIndex(1);
          Get.snackbar('${LanguageConstant.profileUpdatedSuccessfully.tr}!', '',
              colorText: Colors.black, backgroundColor: Colors.white);
          Get.find<GeneralController>().updateFormLoaderController(false);
        } else {
          Get.find<GeneralController>().updateFormLoaderController(false);
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: LanguageConstant.failed.tr,
                  titleColor: customDialogErrorColor,
                  descriptions:
                      '${Get.find<EditConsultantProfileLogic>().generalInfoPostModel.msg}',
                  text: LanguageConstant.ok.tr,
                  functionCall: () {
                    Navigator.pop(context);
                  },
                  img: 'assets/Icons/dialog_error.svg',
                );
              });
        }
      } else {
        Get.find<GeneralController>().updateFormLoaderController(false);
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: LanguageConstant.failed.tr,
                titleColor: customDialogErrorColor,
                descriptions: LanguageConstant.tryAgain.tr,
                text: LanguageConstant.ok.tr,
                functionCall: () {
                  Navigator.pop(context);
                },
                img: 'assets/Icons/dialog_error.svg',
              );
            });
      }
    } on dio_instance.DioError catch (e) {
      Get.find<GeneralController>().updateFormLoaderController(false);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: LanguageConstant.failed.tr,
              titleColor: customDialogErrorColor,
              descriptions: LanguageConstant.tryAgain.tr,
              text: 'ok'.tr,
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/Icons/dialog_error.svg',
            );
          });
      log('ResponseError $mentorGeneralInfoPostUrl-->> ${e.response!.data}');
    }
  }
}
