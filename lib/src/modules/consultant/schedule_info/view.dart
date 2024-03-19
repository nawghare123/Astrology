//
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:resize/resize.dart';
//
// import '../../../../route_generator.dart';
// import '../../../controller/general_controller.dart';
// import '../../../utils/colors.dart';
// import '../../../utils/constants.dart';
// import '../../../widgets/custom_bottom_bar.dart';
// import 'logic.dart';
//
// class ScheduleInfoPage extends StatefulWidget {
//   const ScheduleInfoPage({Key? key}) : super(key: key);
//
//   @override
//   State<ScheduleInfoPage> createState() => _ScheduleInfoPageState();
// }
//
// class _ScheduleInfoPageState extends State<ScheduleInfoPage> {
//   final logic = Get.put(ScheduleInfoLogic());
//
//   final state = Get.find<ScheduleInfoLogic>().state;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     Get.find<ScheduleInfoLogic>().scrollController = ScrollController()
//       ..addListener(Get.find<ScheduleInfoLogic>().scrollListener);
//   }
//
//   @override
//   void dispose() {
//     Get.find<ScheduleInfoLogic>()
//         .scrollController!
//         .removeListener(Get.find<ScheduleInfoLogic>().scrollListener);
//     Get.find<ScheduleInfoLogic>().scrollController!.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<GeneralController>(builder: (_generalController) {
//       return GetBuilder<EditUserProfileLogic>(builder: (_editUserProfileLogic) {
//         return GestureDetector(
//           onTap: () {
//             _generalController.focusOut(context);
//           },
//           child: ModalProgressHUD(
//             inAsyncCall: _generalController.formLoaderController!,
//             child: Scaffold(
//               resizeToAvoidBottomInset: false,
//               backgroundColor: customThemeColor,
//               body: NestedScrollView(
//                   controller: _editUserProfileLogic.scrollController,
//                   headerSliverBuilder:
//                       (BuildContext context, bool innerBoxIsScrolled) {
//                     return <Widget>[
//                       ///---header
//                       SliverAppBar(
//                         expandedHeight:
//                         MediaQuery.of(context).size.height * .2,
//                         floating: true,
//                         pinned: true,
//                         snap: true,
//                         elevation: 0,
//                         backgroundColor: _editUserProfileLogic.isShrink
//                             ? customThemeColor
//                             : Colors.transparent,
//                         leading: InkWell(
//                           onTap: () {
//                             Get.back();
//                           },
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SvgPicture.asset(
//                                   'assets/Icons/whiteBackArrow.svg'),
//                             ],
//                           ),
//                         ),
//                         flexibleSpace: FlexibleSpaceBar(
//                           centerTitle: true,
//                           background: Container(
//                             decoration: BoxDecoration(
//                                 color: Colors.transparent,
//                                 borderRadius: BorderRadius.vertical(
//                                     bottom: Radius.circular(40.r))),
//                             child: Column(
//                               children: [
//                                 Stack(
//                                   children: [
//                                     SvgPicture.asset(
//                                       'assets/images/bookAppointmentAppBar.svg',
//                                       width: MediaQuery.of(context).size.width,
//                                       height:
//                                       MediaQuery.of(context).size.height *
//                                           .23,
//                                       fit: BoxFit.fill,
//                                     ),
//                                     SafeArea(
//                                       child: Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             16.w, 25.h, 16.w, 16.h),
//                                         child: Stack(
//                                           children: [
//                                             Column(
//                                               crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                               mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                               children: [
//                                                 SizedBox(
//                                                   height: 25.h,
//                                                 ),
//                                                 Text(
//                                                   'Edit Profile',
//                                                   style: TextStyle(
//                                                       fontFamily:
//                                                       SarabunFontFamily
//                                                           .bold,
//                                                       fontSize: 28.sp,
//                                                       color:
//                                                       customLightThemeColor),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 10.h,
//                                                 ),
//                                                 Text(
//                                                   LanguageConstant.editYourProfile.tr,
//                                                   style: TextStyle(
//                                                       fontFamily:
//                                                       SarabunFontFamily
//                                                           .medium,
//                                                       fontSize: 12.sp,
//                                                       color: Colors.white),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       )
//                     ];
//                   },
//                   body: Container(
//                     height: MediaQuery.of(context).size.height,
//                     width: MediaQuery.of(context).size.width,
//                     decoration: const BoxDecoration(
//                         color: customTextFieldColor,
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(25.0),
//                             topRight: Radius.circular(25.0))),
//                     child: Stack(children: [
//                       SingleChildScrollView(
//                           child: Form(
//                             key: _scheduleInfoFormKey,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   height: 25.h,
//                                 ),
//
//                                 ///---type-charges
//                                 Row(
//                                   children: [
//                                     ///---type
//                                     Expanded(
//                                       child: Padding(
//                                         padding:
//                                         EdgeInsetsDirectional.fromSTEB(15.w, 0, 9.w, 0),
//                                         child: ButtonTheme(
//                                           alignedDropdown: true,
//                                           child: DropdownButtonHideUnderline(
//                                             child: DropdownButtonFormField<String>(
//                                               onTap: () {
//                                                 FocusScopeNode currentFocus =
//                                                 FocusScope.of(context);
//                                                 if (!currentFocus.hasPrimaryFocus) {
//                                                   currentFocus.unfocus();
//                                                 }
//                                               },
//                                               hint: Text(
//                                                 'select_type'.tr.capitalizeFirst!,
//                                                 style: state.hintTextStyle,
//                                               ),
//                                               decoration: InputDecoration(
//                                                 contentPadding:
//                                                 EdgeInsetsDirectional.fromSTEB(
//                                                     15.w, 14.h, 15.w, 14.h),
//                                                 fillColor: Colors.white,
//                                                 filled: true,
//                                                 enabledBorder: OutlineInputBorder(
//                                                     borderRadius:
//                                                     BorderRadius.circular(8.r),
//                                                     borderSide: const BorderSide(
//                                                         color: Colors.transparent)),
//                                                 border: OutlineInputBorder(
//                                                     borderRadius:
//                                                     BorderRadius.circular(8.r),
//                                                     borderSide: const BorderSide(
//                                                         color: Colors.transparent)),
//                                                 focusedBorder: OutlineInputBorder(
//                                                     borderRadius:
//                                                     BorderRadius.circular(8.r),
//                                                     borderSide: const BorderSide(
//                                                         color: customLightThemeColor)),
//                                                 errorBorder: OutlineInputBorder(
//                                                     borderRadius:
//                                                     BorderRadius.circular(8.r),
//                                                     borderSide: const BorderSide(
//                                                         color: Colors.red)),
//                                               ),
//                                               isExpanded: true,
//                                               focusColor: Colors.white,
//                                               style: state.textFieldTextStyle,
//                                               iconEnabledColor: customThemeColor,
//                                               icon: const Icon(Icons.keyboard_arrow_down),
//                                               iconSize: 25,
//                                               value:
//                                               _mentorScheduleLogic.selectedScheduleType,
//                                               items: _mentorScheduleLogic
//                                                   .scheduleTypeDropDownList
//                                                   .map<DropdownMenuItem<String>>(
//                                                       (String value) {
//                                                     return DropdownMenuItem<String>(
//                                                       value: value,
//                                                       child: Text(
//                                                         value,
//                                                         style: state.textFieldTextStyle,
//                                                       ),
//                                                     );
//                                                   }).toList(),
//                                               onChanged: (String? value) {
//                                                 log(value.toString());
//                                                 setState(() {
//                                                   _mentorScheduleLogic.chargesController
//                                                       .clear();
//                                                   _mentorScheduleLogic
//                                                       .selectedScheduleType = value;
//                                                   for (var element in _mentorScheduleLogic
//                                                       .getAppointmentTypesModel
//                                                       .data!
//                                                       .appointmenttype!) {
//                                                     if (element.name!.toUpperCase() ==
//                                                         value) {
//                                                       _mentorScheduleLogic
//                                                           .selectedScheduleTypeId =
//                                                           element.id;
//                                                     }
//                                                   }
//                                                 });
//                                                 Get.find<GeneralController>()
//                                                     .updateFormLoaderController(true);
//                                                 getMethod(
//                                                     context,
//                                                     getAvailableDaysUrl,
//                                                     {
//                                                       'token': '123',
//                                                       'mentor_id':
//                                                       Get.find<GeneralController>()
//                                                           .storageBox
//                                                           .read('userID'),
//                                                       'appointment_type_id':
//                                                       _mentorScheduleLogic
//                                                           .selectedScheduleTypeId,
//                                                     },
//                                                     false,
//                                                     getAvailableDaysRepo);
//                                               },
//                                               validator: (String? value) {
//                                                 if (value == null) {
//                                                   return 'field_required'.tr;
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//
//                                     ///---charges
//                                     Expanded(
//                                       child: Padding(
//                                         padding:
//                                         EdgeInsetsDirectional.fromSTEB(9.w, 0, 15.w, 0),
//                                         child: TextFormField(
//                                           inputFormatters: [
//                                             LengthLimitingTextInputFormatter(6),
//                                             FilteringTextInputFormatter.allow(
//                                                 RegExp("[0-9]"))
//                                           ],
//                                           style: state.textFieldTextStyle,
//                                           controller:
//                                           _mentorScheduleLogic.chargesController,
//                                           keyboardType: TextInputType.number,
//                                           decoration: InputDecoration(
//                                             contentPadding: EdgeInsetsDirectional.fromSTEB(
//                                                 25.w, 15.h, 25.w, 15.h),
//                                             hintText: 'enter_charges'.tr.capitalizeFirst,
//                                             hintStyle: state.hintTextStyle,
//                                             fillColor: Colors.white,
//                                             filled: true,
//                                             enabledBorder: OutlineInputBorder(
//                                                 borderRadius: BorderRadius.circular(8.r),
//                                                 borderSide: const BorderSide(
//                                                     color: Colors.transparent)),
//                                             border: OutlineInputBorder(
//                                                 borderRadius: BorderRadius.circular(8.r),
//                                                 borderSide: const BorderSide(
//                                                     color: Colors.transparent)),
//                                             focusedBorder: OutlineInputBorder(
//                                                 borderRadius: BorderRadius.circular(8.r),
//                                                 borderSide: const BorderSide(
//                                                     color: customLightThemeColor)),
//                                             errorBorder: OutlineInputBorder(
//                                                 borderRadius: BorderRadius.circular(8.r),
//                                                 borderSide:
//                                                 const BorderSide(color: Colors.red)),
//                                           ),
//                                           validator: (String? value) {
//                                             if (value!.isEmpty) {
//                                               return 'field_required'.tr;
//                                             } else if (int.parse(value.toString()) < 100) {
//                                               return 'Min Charges is\nRs. 100'.tr;
//                                             } else {
//                                               return null;
//                                             }
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//
//                                 ///---holiday-selector
//                                 _mentorScheduleLogic.selectedScheduleType == null
//                                     ? const SizedBox()
//                                     : _mentorScheduleLogic
//                                     .getAppointmentTypesModel
//                                     .data!
//                                     .appointmenttype![_mentorScheduleLogic
//                                     .scheduleTypeDropDownList
//                                     .indexOf(_mentorScheduleLogic
//                                     .selectedScheduleType!)]
//                                     .isScheduleRequired ==
//                                     0
//                                     ? const SizedBox()
//                                     : Padding(
//                                   padding: EdgeInsetsDirectional.fromSTEB(
//                                       15.w, 20.h, 15.w, 0),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'select_holiday'.tr,
//                                         style: state.headingTextStyle,
//                                       ),
//                                       SizedBox(
//                                         height: 12.h,
//                                       ),
//                                       SizedBox(
//                                           width:
//                                           MediaQuery.of(context).size.width,
//                                           height: 28.h,
//                                           child: ListView(
//                                             scrollDirection: Axis.horizontal,
//                                             children: List.generate(
//                                                 _mentorScheduleLogic
//                                                     .dayListForHoliday
//                                                     .length, (index) {
//                                               return Padding(
//                                                 padding: EdgeInsetsDirectional
//                                                     .fromSTEB(0, 0, 12.w, 0),
//                                                 child: Column(
//                                                   children: [
//                                                     InkWell(
//                                                       onTap: () {
//                                                         _generalController
//                                                             .updateFormLoaderController(
//                                                             true);
//                                                         setState(() {
//                                                           _mentorScheduleLogic
//                                                               .dayListForHoliday[
//                                                           index]
//                                                               .isSelected =
//                                                           !_mentorScheduleLogic
//                                                               .dayListForHoliday[
//                                                           index]
//                                                               .isSelected!;
//                                                         });
//
//                                                         Map<String, dynamic>
//                                                         tempHolidayMap = {};
//
//                                                         for (var element
//                                                         in _mentorScheduleLogic
//                                                             .dayListForHoliday) {
//                                                           setState(() {
//                                                             tempHolidayMap[
//                                                             '${element.slug}'] =
//                                                             element.isSelected!
//                                                                 ? 1
//                                                                 : 0;
//                                                           });
//                                                         }
//                                                         log('TEMPLIST--->>$tempHolidayMap');
//                                                         postMethod(
//                                                             context,
//                                                             markDayHolidayUrl,
//                                                             {
//                                                               'token': '123',
//                                                               'mentor_id': Get.find<
//                                                                   GeneralController>()
//                                                                   .storageBox
//                                                                   .read('userID'),
//                                                               'appointment_type_id':
//                                                               _mentorScheduleLogic
//                                                                   .selectedScheduleTypeId,
//                                                               'availability':
//                                                               tempHolidayMap
//                                                             },
//                                                             true,
//                                                             markHolidayPostRepo);
//                                                       },
//                                                       child: Container(
//                                                         decoration: _mentorScheduleLogic
//                                                             .dayListForHoliday[
//                                                         index]
//                                                             .isSelected!
//                                                             ? BoxDecoration(
//                                                             color:
//                                                             customThemeColor,
//                                                             borderRadius:
//                                                             BorderRadius.circular(
//                                                                 4.r),
//                                                             border: Border.all(
//                                                                 color:
//                                                                 customThemeColor))
//                                                             : BoxDecoration(
//                                                             color:
//                                                             Colors.white,
//                                                             borderRadius:
//                                                             BorderRadius
//                                                                 .circular(
//                                                                 4.r),
//                                                             border: Border.all(
//                                                                 color: Colors
//                                                                     .black)),
//                                                         child: Padding(
//                                                           padding:
//                                                           EdgeInsets.fromLTRB(
//                                                               12.w,
//                                                               1.h,
//                                                               12.w,
//                                                               1.h),
//                                                           child: Text(
//                                                             '${_mentorScheduleLogic.dayListForHoliday[index].title}',
//                                                             style: _mentorScheduleLogic
//                                                                 .dayListForHoliday[
//                                                             index]
//                                                                 .isSelected!
//                                                                 ? state
//                                                                 .scheduleDayTextStyle!
//                                                                 .copyWith(
//                                                                 color: Colors
//                                                                     .white)
//                                                                 : state
//                                                                 .scheduleDayTextStyle,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               );
//                                             }),
//                                           ))
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 20.h,
//                                 ),
//
//                                 ///---generate-slots
//                                 _mentorScheduleLogic.selectedScheduleType == null
//                                     ? const SizedBox()
//                                     : _mentorScheduleLogic
//                                     .getAppointmentTypesModel
//                                     .data!
//                                     .appointmenttype![_mentorScheduleLogic
//                                     .scheduleTypeDropDownList
//                                     .indexOf(_mentorScheduleLogic
//                                     .selectedScheduleType!)]
//                                     .isScheduleRequired ==
//                                     0
//
//                                 ///---save-button-for-without-schedule
//                                     ? Padding(
//                                   padding: EdgeInsetsDirectional.fromSTEB(
//                                       0, 30.h, 0, 30.h),
//                                   child: Center(
//                                     child: InkWell(
//                                       onTap: () {
//                                         FocusScopeNode currentFocus =
//                                         FocusScope.of(context);
//                                         if (!currentFocus.hasPrimaryFocus) {
//                                           currentFocus.unfocus();
//                                         }
//
//                                         if (_scheduleInfoFormKey.currentState!
//                                             .validate()) {
//                                           _generalController
//                                               .updateFormLoaderController(true);
//                                           postMethod(
//                                               context,
//                                               saveMentorChatFeeUrl,
//                                               {
//                                                 'token': '123',
//                                                 'mentor_id':
//                                                 Get.find<GeneralController>()
//                                                     .storageBox
//                                                     .read('userID'),
//                                                 'appointment_type_id':
//                                                 _mentorScheduleLogic
//                                                     .selectedScheduleTypeId,
//                                                 'fee': _mentorScheduleLogic
//                                                     .chargesController.text
//                                               },
//                                               true,
//                                               saveSchedulePostRepo);
//                                         }
//                                       },
//                                       child: Container(
//                                         height: 40.h,
//                                         width: MediaQuery.of(context).size.width *
//                                             .4,
//                                         decoration: BoxDecoration(
//                                             color: customLightThemeColor,
//                                             borderRadius:
//                                             BorderRadius.circular(8.r)),
//                                         child: Center(
//                                           child: Text(
//                                             'save'.tr,
//                                             style: state.addButtonTextStyle,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                                     : Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.vertical(
//                                           top: Radius.circular(30.r))),
//                                   child: Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         15.w, 30.h, 15.w, 0),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'generate_slots_automatically'.tr,
//                                           style: state.headingTextStyle,
//                                         ),
//                                         SizedBox(
//                                           height: 12.h,
//                                         ),
//
//                                         ///---day-duration
//                                         Row(
//                                           children: [
//                                             ///---day
//                                             Expanded(
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                                   mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                                   children: [
//                                                     ButtonTheme(
//                                                       alignedDropdown: true,
//                                                       child:
//                                                       DropdownButtonHideUnderline(
//                                                         child:
//                                                         DropdownButtonFormField<
//                                                             String>(
//                                                           onTap: () {
//                                                             FocusScopeNode
//                                                             currentFocus =
//                                                             FocusScope.of(
//                                                                 context);
//                                                             if (!currentFocus
//                                                                 .hasPrimaryFocus) {
//                                                               currentFocus.unfocus();
//                                                             }
//                                                           },
//                                                           alignment: Alignment.center,
//                                                           decoration: InputDecoration(
//                                                             isDense: true,
//                                                             filled: true,
//                                                             fillColor: Colors.white,
//                                                             contentPadding:
//                                                             EdgeInsets.symmetric(
//                                                                 vertical: 12.h,
//                                                                 horizontal:
//                                                                 10.0.w),
//                                                             focusedBorder:
//                                                             OutlineInputBorder(
//                                                                 borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                     10.r),
//                                                                 borderSide:
//                                                                 const BorderSide(
//                                                                     color:
//                                                                     customThemeColor)),
//                                                             errorBorder: OutlineInputBorder(
//                                                                 borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                     10.r),
//                                                                 borderSide:
//                                                                 const BorderSide(
//                                                                     color: Colors
//                                                                         .red)),
//                                                             enabledBorder:
//                                                             OutlineInputBorder(
//                                                                 borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                     10.r),
//                                                                 borderSide:
//                                                                 const BorderSide(
//                                                                     color:
//                                                                     customLightThemeColor)),
//                                                             border: OutlineInputBorder(
//                                                                 borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                     10.r),
//                                                                 borderSide:
//                                                                 const BorderSide(
//                                                                     color:
//                                                                     customLightThemeColor)),
//                                                           ),
//                                                           focusColor: Colors.white,
//                                                           isExpanded: true,
//                                                           style: state
//                                                               .scheduleDayTextStyle,
//                                                           iconEnabledColor:
//                                                           customThemeColor,
//                                                           icon: const Icon(Icons
//                                                               .keyboard_arrow_down),
//                                                           value: _mentorScheduleLogic
//                                                               .selectedAvailableDay,
//                                                           items: _mentorScheduleLogic
//                                                               .availableDaysList
//                                                               .map<
//                                                               DropdownMenuItem<
//                                                                   String>>((String
//                                                           value) {
//                                                             return DropdownMenuItem<
//                                                                 String>(
//                                                               value: value,
//                                                               child: Text(
//                                                                 value,
//                                                                 style: state
//                                                                     .scheduleDayTextStyle,
//                                                               ),
//                                                             );
//                                                           }).toList(),
//                                                           onChanged: (String? value) {
//                                                             _mentorScheduleLogic
//                                                                 .slotsList
//                                                                 .clear();
//                                                             log(value.toString());
//                                                             setState(() {
//                                                               _mentorScheduleLogic
//                                                                   .selectedAvailableDay =
//                                                                   value;
//                                                             });
//                                                           },
//                                                           validator: (String? value) {
//                                                             if (value == null) {
//                                                               return 'field_required'
//                                                                   .tr;
//                                                             } else {
//                                                               return null;
//                                                             }
//                                                           },
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     const SizedBox(
//                                                       height: 4,
//                                                     ),
//                                                     Padding(
//                                                       padding:
//                                                       EdgeInsetsDirectional.only(
//                                                           start: 5.w),
//                                                       child: Text(
//                                                         'select_day'.tr,
//                                                         softWrap: true,
//                                                         overflow:
//                                                         TextOverflow.ellipsis,
//                                                         maxLines: 1,
//                                                         style:
//                                                         state.subHeadingTextStyle,
//                                                       ),
//                                                     )
//                                                   ],
//                                                 )),
//                                             const SizedBox(
//                                               width: 10,
//                                             ),
//
//                                             ///---duration
//                                             Expanded(
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                                   mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                                   children: [
//                                                     TextFormField(
//                                                       inputFormatters: [
//                                                         LengthLimitingTextInputFormatter(
//                                                             3),
//                                                         FilteringTextInputFormatter
//                                                             .allow(RegExp("[0-9]"))
//                                                       ],
//                                                       style:
//                                                       state.scheduleDayTextStyle,
//                                                       controller: _mentorScheduleLogic
//                                                           .durationController,
//                                                       keyboardType:
//                                                       TextInputType.number,
//                                                       cursorColor: Colors.black,
//                                                       cursorWidth: 1,
//                                                       textAlignVertical:
//                                                       TextAlignVertical.center,
//                                                       decoration: InputDecoration(
//                                                         isDense: true,
//                                                         filled: true,
//                                                         fillColor: Colors.white,
//                                                         suffixIcon: Row(
//                                                           mainAxisSize:
//                                                           MainAxisSize.min,
//                                                           children: [
//                                                             Text('min',
//                                                                 style: state
//                                                                     .scheduleDayTextStyle),
//                                                           ],
//                                                         ),
//                                                         contentPadding:
//                                                         EdgeInsets.symmetric(
//                                                             vertical: 12.h,
//                                                             horizontal: 30.w),
//                                                         focusedBorder: OutlineInputBorder(
//                                                             borderRadius:
//                                                             BorderRadius.circular(
//                                                                 10.r),
//                                                             borderSide: const BorderSide(
//                                                                 color:
//                                                                 customThemeColor)),
//                                                         errorBorder:
//                                                         OutlineInputBorder(
//                                                             borderRadius:
//                                                             BorderRadius
//                                                                 .circular(
//                                                                 10.r),
//                                                             borderSide:
//                                                             const BorderSide(
//                                                                 color: Colors
//                                                                     .red)),
//                                                         enabledBorder: OutlineInputBorder(
//                                                             borderRadius:
//                                                             BorderRadius.circular(
//                                                                 10.r),
//                                                             borderSide: const BorderSide(
//                                                                 color:
//                                                                 customLightThemeColor)),
//                                                         border: OutlineInputBorder(
//                                                             borderRadius:
//                                                             BorderRadius.circular(
//                                                                 10.r),
//                                                             borderSide: const BorderSide(
//                                                                 color:
//                                                                 customLightThemeColor)),
//                                                       ),
//                                                       onChanged: (v) {
//                                                         setState(() {
//                                                           _mentorScheduleLogic
//                                                               .slotsList
//                                                               .clear();
//                                                         });
//                                                       },
//                                                       validator: (String? value) {
//                                                         if (value!.isEmpty) {
//                                                           return 'field_required'.tr;
//                                                         } else if (int.parse(
//                                                             _mentorScheduleLogic
//                                                                 .durationController
//                                                                 .text) <
//                                                             5) {
//                                                           return 'Slot must be greater than 5 min';
//                                                         } else {
//                                                           return null;
//                                                         }
//                                                       },
//                                                     ),
//                                                     const SizedBox(
//                                                       height: 4,
//                                                     ),
//                                                     Padding(
//                                                       padding:
//                                                       EdgeInsetsDirectional.only(
//                                                           start: 5.w),
//                                                       child: Text(
//                                                         'slot_duration'.tr,
//                                                         softWrap: true,
//                                                         overflow:
//                                                         TextOverflow.ellipsis,
//                                                         maxLines: 1,
//                                                         style:
//                                                         state.subHeadingTextStyle,
//                                                       ),
//                                                     )
//                                                   ],
//                                                 )),
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: 12.h,
//                                         ),
//
//                                         ///---times
//                                         Row(
//                                           children: [
//                                             ///---start-time
//                                             Expanded(
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                                   mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                                   children: [
//                                                     InkWell(
//                                                       onTap: () async {
//                                                         final picked =
//                                                         await showTimePicker(
//                                                             context: context,
//                                                             initialTime:
//                                                             TimeOfDay.now(),
//                                                             builder: (BuildContext
//                                                             context,
//                                                                 Widget? child) {
//                                                               return Theme(
//                                                                 data: ThemeData(
//                                                                     primaryColor:
//                                                                     customThemeColor,
//                                                                     primarySwatch:
//                                                                     Colors
//                                                                         .green),
//                                                                 child: MediaQuery(
//                                                                   data: MediaQuery.of(
//                                                                       context)
//                                                                       .copyWith(
//                                                                       alwaysUse24HourFormat:
//                                                                       false),
//                                                                   child: child!,
//                                                                 ),
//                                                               );
//                                                             });
//
//                                                         if (picked != null) {
//                                                           setState(() {
//                                                             _mentorScheduleLogic
//                                                                 .slotsList
//                                                                 .clear();
//                                                             _mentorScheduleLogic
//                                                                 .selectedTimeForStartForCalculate =
//                                                                 DateTimeField.convert(
//                                                                     picked)
//                                                                     .toString()
//                                                                     .substring(11);
//                                                             log('---START-TIME-PICKED->>${_mentorScheduleLogic.selectedTimeForStartForCalculate}');
//
//                                                             _mentorScheduleLogic
//                                                                 .selectedTimeForStart =
//                                                                 picked
//                                                                     .format(context);
//                                                             log('---START-TIME->>${_mentorScheduleLogic.selectedTimeForStart}');
//                                                           });
//                                                         }
//                                                       },
//                                                       child: Container(
//                                                           height: 45.h,
//                                                           decoration: BoxDecoration(
//                                                               borderRadius:
//                                                               BorderRadius
//                                                                   .circular(10.r),
//                                                               border: Border.all(
//                                                                   color: timeValidator &&
//                                                                       _mentorScheduleLogic
//                                                                           .selectedTimeForStart ==
//                                                                           null
//                                                                       ? Colors.red
//                                                                       : customLightThemeColor)),
//                                                           child: Row(
//                                                             children: [
//                                                               Padding(
//                                                                 padding:
//                                                                 EdgeInsetsDirectional
//                                                                     .fromSTEB(
//                                                                     25.w,
//                                                                     0,
//                                                                     0,
//                                                                     0),
//                                                                 child: Text(
//                                                                   _mentorScheduleLogic
//                                                                       .selectedTimeForStart ==
//                                                                       null
//                                                                       ? ''
//                                                                       : '${_mentorScheduleLogic.selectedTimeForStart}',
//                                                                   textDirection:
//                                                                   TextDirection
//                                                                       .ltr,
//                                                                   style: state
//                                                                       .scheduleDayTextStyle,
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           )),
//                                                     ),
//                                                     timeValidator &&
//                                                         _mentorScheduleLogic
//                                                             .selectedTimeForStart ==
//                                                             null
//                                                         ? Padding(
//                                                       padding:
//                                                       EdgeInsetsDirectional
//                                                           .fromSTEB(7.w,
//                                                           5.h, 0, 0),
//                                                       child: Row(
//                                                         mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .start,
//                                                         children: [
//                                                           Text(
//                                                             'field_required'.tr,
//                                                             style: TextStyle(
//                                                                 fontFamily:
//                                                                 SarabunFontFamily
//                                                                     .regular,
//                                                                 fontSize: 12.sp,
//                                                                 color:
//                                                                 Colors.red),
//                                                           )
//                                                         ],
//                                                       ),
//                                                     )
//                                                         : const SizedBox(),
//                                                     SizedBox(
//                                                       height: 4.h,
//                                                     ),
//                                                     Padding(
//                                                       padding:
//                                                       EdgeInsetsDirectional.only(
//                                                           start: 5.w),
//                                                       child: Text(
//                                                         'start_time'.tr,
//                                                         style:
//                                                         state.subHeadingTextStyle,
//                                                       ),
//                                                     )
//                                                   ],
//                                                 )),
//                                             const SizedBox(
//                                               width: 10,
//                                             ),
//
//                                             ///---end-time
//                                             Expanded(
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                                   mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                                   children: [
//                                                     InkWell(
//                                                       onTap: () async {
//                                                         final picked =
//                                                         await showTimePicker(
//                                                             context: context,
//                                                             initialTime:
//                                                             TimeOfDay.now(),
//                                                             builder: (BuildContext
//                                                             context,
//                                                                 Widget? child) {
//                                                               return Theme(
//                                                                 data: ThemeData(
//                                                                     primaryColor:
//                                                                     customThemeColor,
//                                                                     primarySwatch:
//                                                                     Colors
//                                                                         .green),
//                                                                 child: MediaQuery(
//                                                                   data: MediaQuery.of(
//                                                                       context)
//                                                                       .copyWith(
//                                                                       alwaysUse24HourFormat:
//                                                                       false),
//                                                                   child: child!,
//                                                                 ),
//                                                               );
//                                                             });
//
//                                                         if (picked != null) {
//                                                           setState(() {
//                                                             _mentorScheduleLogic
//                                                                 .slotsList
//                                                                 .clear();
//                                                             _mentorScheduleLogic
//                                                                 .selectedTimeForEndForCalculate =
//                                                                 DateTimeField.convert(
//                                                                     picked)
//                                                                     .toString()
//                                                                     .substring(11);
//                                                             log('---END-TIME-PICKED->>${_mentorScheduleLogic.selectedTimeForEndForCalculate}');
//
//                                                             _mentorScheduleLogic
//                                                                 .selectedTimeForEnd =
//                                                                 picked
//                                                                     .format(context);
//                                                             log('---END-TIME->>${_mentorScheduleLogic.selectedTimeForEnd}');
//                                                           });
//                                                         }
//                                                       },
//                                                       child: Container(
//                                                           height: 45.h,
//                                                           decoration: BoxDecoration(
//                                                               borderRadius:
//                                                               BorderRadius
//                                                                   .circular(10.r),
//                                                               border: Border.all(
//                                                                   color: timeValidator &&
//                                                                       _mentorScheduleLogic
//                                                                           .selectedTimeForEnd ==
//                                                                           null
//                                                                       ? Colors.red
//                                                                       : customLightThemeColor)),
//                                                           child: Row(
//                                                             children: [
//                                                               Padding(
//                                                                 padding:
//                                                                 EdgeInsetsDirectional
//                                                                     .fromSTEB(
//                                                                     25.w,
//                                                                     0,
//                                                                     0,
//                                                                     0),
//                                                                 child: Text(
//                                                                   _mentorScheduleLogic
//                                                                       .selectedTimeForEnd ==
//                                                                       null
//                                                                       ? ''
//                                                                       : '${_mentorScheduleLogic.selectedTimeForEnd}',
//                                                                   textDirection:
//                                                                   TextDirection
//                                                                       .ltr,
//                                                                   style: state
//                                                                       .scheduleDayTextStyle,
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           )),
//                                                     ),
//                                                     timeValidator &&
//                                                         _mentorScheduleLogic
//                                                             .selectedTimeForEnd ==
//                                                             null
//                                                         ? Padding(
//                                                       padding:
//                                                       EdgeInsetsDirectional
//                                                           .fromSTEB(7.w,
//                                                           5.h, 0, 0),
//                                                       child: Row(
//                                                         mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .start,
//                                                         children: [
//                                                           Text(
//                                                             'field_required'.tr,
//                                                             style: TextStyle(
//                                                                 fontFamily:
//                                                                 SarabunFontFamily
//                                                                     .regular,
//                                                                 fontSize: 12.sp,
//                                                                 color:
//                                                                 Colors.red),
//                                                           )
//                                                         ],
//                                                       ),
//                                                     )
//                                                         : const SizedBox(),
//                                                     SizedBox(
//                                                       height: 4.h,
//                                                     ),
//                                                     Padding(
//                                                       padding:
//                                                       EdgeInsetsDirectional.only(
//                                                           start: 5.w),
//                                                       child: Text(
//                                                         'end_time'.tr,
//                                                         style:
//                                                         state.subHeadingTextStyle,
//                                                       ),
//                                                     )
//                                                   ],
//                                                 )),
//                                           ],
//                                         ),
//
//                                         ///---generate-slot-button
//                                         Padding(
//                                           padding: EdgeInsetsDirectional.fromSTEB(
//                                               0, 30.h, 0, 0),
//                                           child: Center(
//                                             child: InkWell(
//                                               onTap: () {
//                                                 FocusScopeNode currentFocus =
//                                                 FocusScope.of(context);
//                                                 if (!currentFocus
//                                                     .hasPrimaryFocus) {
//                                                   currentFocus.unfocus();
//                                                 }
//
//                                                 if (_scheduleInfoFormKey
//                                                     .currentState!
//                                                     .validate() &&
//                                                     _mentorScheduleLogic
//                                                         .selectedTimeForEnd !=
//                                                         null &&
//                                                     _mentorScheduleLogic
//                                                         .selectedTimeForStart !=
//                                                         null) {
//                                                   setState(() {
//                                                     timeValidator = false;
//                                                   });
//                                                   final startTime = TimeOfDay(
//                                                       hour: int.parse(
//                                                           _mentorScheduleLogic
//                                                               .selectedTimeForStartForCalculate!
//                                                               .substring(0, 2)
//                                                               .toString()),
//                                                       minute: int.parse(
//                                                           _mentorScheduleLogic
//                                                               .selectedTimeForStartForCalculate!
//                                                               .substring(3, 5)
//                                                               .toString()));
//                                                   final endTime = TimeOfDay(
//                                                       hour: int.parse(
//                                                           _mentorScheduleLogic
//                                                               .selectedTimeForEndForCalculate!
//                                                               .substring(0, 2)
//                                                               .toString()),
//                                                       minute: int.parse(
//                                                           _mentorScheduleLogic
//                                                               .selectedTimeForEndForCalculate!
//                                                               .substring(3, 5)
//                                                               .toString()));
//                                                   final step = Duration(
//                                                       minutes: int.parse(
//                                                           _mentorScheduleLogic
//                                                               .durationController
//                                                               .text
//                                                               .toString()));
//
//                                                   _mentorScheduleLogic.slotsList =
//                                                       _mentorScheduleLogic
//                                                           .getTimes(startTime,
//                                                           endTime, step)
//                                                           .map((tod) =>
//                                                           tod.format(context))
//                                                           .toList();
//                                                   setState(() {
//                                                     _mentorScheduleLogic
//                                                         .slotsList.length =
//                                                         _mentorScheduleLogic
//                                                             .slotsList
//                                                             .length -
//                                                             1;
//                                                   });
//                                                   log(_mentorScheduleLogic
//                                                       .slotsList
//                                                       .toString());
//                                                 } else {
//                                                   setState(() {
//                                                     timeValidator = true;
//                                                   });
//                                                 }
//                                               },
//                                               child: Container(
//                                                 height: 40.h,
//                                                 width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                     .45,
//                                                 decoration: BoxDecoration(
//                                                     color: _mentorScheduleLogic
//                                                         .slotsList.isEmpty
//                                                         ? customLightThemeColor
//                                                         : Colors.grey
//                                                         .withOpacity(0.5),
//                                                     borderRadius:
//                                                     BorderRadius.circular(
//                                                         8.r)),
//                                                 child: Center(
//                                                   child: Text(
//                                                     'generate_slot'.tr,
//                                                     style:
//                                                     state.addButtonTextStyle,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           height: 30,
//                                         ),
//
//                                         ///---slots
//                                         _mentorScheduleLogic.slotsList.isEmpty
//                                             ? const SizedBox()
//                                             : Column(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'slots_created'.tr,
//                                               style: state.headingTextStyle,
//                                             ),
//                                             const SizedBox(
//                                               height: 12,
//                                             ),
//                                             Wrap(
//                                               children: List.generate(
//                                                   _mentorScheduleLogic
//                                                       .slotsList
//                                                       .length, (index) {
//                                                 return Padding(
//                                                   padding: const EdgeInsets
//                                                       .fromLTRB(
//                                                       0, 7, 14, 7),
//                                                   child: Container(
//                                                     color:
//                                                     customTextFieldColor,
//                                                     child: Padding(
//                                                       padding:
//                                                       const EdgeInsets
//                                                           .fromLTRB(
//                                                           10, 8, 10, 8),
//                                                       child: Text(
//                                                           '${_mentorScheduleLogic.slotsList[index]}',
//                                                           textDirection:
//                                                           TextDirection
//                                                               .ltr,
//                                                           style: state
//                                                               .slotTextStyle),
//                                                     ),
//                                                   ),
//                                                 );
//                                               }),
//                                             ),
//                                           ],
//                                         ),
//
//                                         const SizedBox(
//                                           height: 12,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//
//                                 ///---save-button-for-schedule
//                                 _mentorScheduleLogic.slotsList.isEmpty
//                                     ? const SizedBox()
//                                     : Padding(
//                                   padding: const EdgeInsetsDirectional.fromSTEB(
//                                       0, 30, 0, 30),
//                                   child: Center(
//                                     child: InkWell(
//                                       onTap: () {
//                                         FocusScopeNode currentFocus =
//                                         FocusScope.of(context);
//                                         if (!currentFocus.hasPrimaryFocus) {
//                                           currentFocus.unfocus();
//                                         }
//
//                                         _generalController
//                                             .updateFormLoaderController(true);
//                                         postMethod(
//                                             context,
//                                             saveMentorSchedulesUrl,
//                                             {
//                                               'token': '123',
//                                               'mentor_id':
//                                               Get.find<GeneralController>()
//                                                   .storageBox
//                                                   .read('userID'),
//                                               'appointment_type_id':
//                                               _mentorScheduleLogic
//                                                   .selectedScheduleTypeId,
//                                               'fee': _mentorScheduleLogic
//                                                   .chargesController.text,
//                                               'day': _mentorScheduleLogic
//                                                   .selectedAvailableDay,
//                                               'interval': _mentorScheduleLogic
//                                                   .durationController.text,
//                                               'slots': _mentorScheduleLogic.slotsList
//                                             },
//                                             true,
//                                             saveSchedulePostRepo);
//                                       },
//                                       child: Container(
//                                         height: 40.h,
//                                         width: MediaQuery.of(context).size.width * .4,
//                                         decoration: BoxDecoration(
//                                             color: customLightThemeColor,
//                                             borderRadius: BorderRadius.circular(8)),
//                                         child: Center(
//                                           child: Text(
//                                             'save'.tr,
//                                             style: state.addButtonTextStyle,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//
//                                 ///---added-record-preview
//                                 Padding(
//                                     padding:
//                                     const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 20),
//                                     child: Wrap(
//                                       children: List.generate(
//                                           _mentorScheduleLogic
//                                               .forDisplayWithoutScheduleList!
//                                               .length, (index) {
//                                         return Padding(
//                                           padding: const EdgeInsetsDirectional.fromSTEB(
//                                               0, 15, 0, 0),
//                                           child: Container(
//                                               decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(14),
//                                                   color: Colors.white),
//                                               child: Padding(
//                                                 padding:
//                                                 const EdgeInsetsDirectional.fromSTEB(
//                                                     15, 15, 7, 15),
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                                   mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                                   children: [
//                                                     ///---type
//                                                     Row(
//                                                       mainAxisAlignment:
//                                                       MainAxisAlignment.spaceBetween,
//                                                       children: [
//                                                         Expanded(
//                                                           child: Column(
//                                                             mainAxisAlignment:
//                                                             MainAxisAlignment.start,
//                                                             crossAxisAlignment:
//                                                             CrossAxisAlignment.start,
//                                                             children: [
//                                                               Text(
//                                                                 'type'.tr,
//                                                                 style: state
//                                                                     .previewLabelTextStyle,
//                                                               ),
//                                                               const SizedBox(
//                                                                 height: 4,
//                                                               ),
//                                                               Text(
//                                                                 _mentorScheduleLogic
//                                                                     .scheduleTypeDropDownList[
//                                                                 _mentorScheduleLogic
//                                                                     .forDisplayWithoutScheduleList![
//                                                                 index]
//                                                                     .appointmentTypeId! -
//                                                                     1],
//                                                                 softWrap: true,
//                                                                 overflow:
//                                                                 TextOverflow.ellipsis,
//                                                                 maxLines: 1,
//                                                                 style: state
//                                                                     .previewValueTextStyle,
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//
//                                                         ///---fee-day
//                                                         Expanded(
//                                                           child: Column(
//                                                             mainAxisAlignment:
//                                                             MainAxisAlignment.start,
//                                                             crossAxisAlignment:
//                                                             CrossAxisAlignment.start,
//                                                             children: [
//                                                               Text(
//                                                                 'charges'.tr,
//                                                                 style: state
//                                                                     .previewLabelTextStyle,
//                                                               ),
//                                                               const SizedBox(
//                                                                 height: 4,
//                                                               ),
//                                                               Text(
//                                                                 '${_mentorScheduleLogic.forDisplayWithoutScheduleList![index].fee}',
//                                                                 style: state
//                                                                     .previewValueTextStyle,
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         InkWell(
//                                                           onTap: () {
//                                                             _generalController
//                                                                 .updateFormLoaderController(
//                                                                 true);
//                                                             postMethod(
//                                                                 context,
//                                                                 deleteMentorScheduleUrl,
//                                                                 {
//                                                                   'token': '123',
//                                                                   'id': _mentorScheduleLogic
//                                                                       .forDisplayWithoutScheduleList![
//                                                                   index]
//                                                                       .id,
//                                                                   'appointment_type_id':
//                                                                   _mentorScheduleLogic
//                                                                       .forDisplayWithoutScheduleList![
//                                                                   index]
//                                                                       .appointmentTypeId
//                                                                 },
//                                                                 true,
//                                                                 deleteMentorScheduleRepo);
//                                                             setState(() {});
//                                                           },
//                                                           child: Padding(
//                                                             padding:
//                                                             const EdgeInsetsDirectional
//                                                                 .all(8.0),
//                                                             child: SvgPicture.asset(
//                                                                 'assets/Icons/deleteIcon.svg'),
//                                                           ),
//                                                         )
//                                                       ],
//                                                     ),
//
//                                                     const SizedBox(
//                                                       height: 14,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )),
//                                         );
//                                       }),
//                                     )),
//                                 Padding(
//                                     padding:
//                                     const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 20),
//                                     child: Wrap(
//                                       children: List.generate(
//                                           _mentorScheduleLogic
//                                               .forDisplayScheduleList!.length, (index) {
//                                         return Padding(
//                                           padding: const EdgeInsetsDirectional.fromSTEB(
//                                               0, 15, 0, 0),
//                                           child: Container(
//                                               decoration: BoxDecoration(
//                                                   borderRadius: BorderRadius.circular(14),
//                                                   color: Colors.white),
//                                               child: Padding(
//                                                 padding:
//                                                 const EdgeInsetsDirectional.fromSTEB(
//                                                     15, 15, 7, 15),
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                                   mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                                   children: [
//                                                     ///---type
//                                                     Row(
//                                                       mainAxisAlignment:
//                                                       MainAxisAlignment.spaceBetween,
//                                                       children: [
//                                                         Expanded(
//                                                           child: Column(
//                                                             mainAxisAlignment:
//                                                             MainAxisAlignment.start,
//                                                             crossAxisAlignment:
//                                                             CrossAxisAlignment.start,
//                                                             children: [
//                                                               Text(
//                                                                 'type'.tr,
//                                                                 style: state
//                                                                     .previewLabelTextStyle,
//                                                               ),
//                                                               const SizedBox(
//                                                                 height: 4,
//                                                               ),
//                                                               Text(
//                                                                 _mentorScheduleLogic
//                                                                     .scheduleTypeDropDownList[
//                                                                 _mentorScheduleLogic
//                                                                     .forDisplayScheduleList![
//                                                                 index]
//                                                                     .appointmentTypeId! -
//                                                                     1],
//                                                                 softWrap: true,
//                                                                 overflow:
//                                                                 TextOverflow.ellipsis,
//                                                                 maxLines: 1,
//                                                                 style: state
//                                                                     .previewValueTextStyle,
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         Expanded(
//                                                           child: Column(
//                                                             mainAxisAlignment:
//                                                             MainAxisAlignment.start,
//                                                             crossAxisAlignment:
//                                                             CrossAxisAlignment.start,
//                                                             children: [
//                                                               Text(
//                                                                 'charges'.tr,
//                                                                 style: state
//                                                                     .previewLabelTextStyle,
//                                                               ),
//                                                               const SizedBox(
//                                                                 height: 4,
//                                                               ),
//                                                               Text(
//                                                                 '${_mentorScheduleLogic.forDisplayScheduleList![index].fee}',
//                                                                 style: state
//                                                                     .previewValueTextStyle,
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         InkWell(
//                                                           onTap: () {
//                                                             _generalController
//                                                                 .updateFormLoaderController(
//                                                                 true);
//                                                             postMethod(
//                                                                 context,
//                                                                 deleteMentorScheduleUrl,
//                                                                 {
//                                                                   'token': '123',
//                                                                   'id': _mentorScheduleLogic
//                                                                       .forDisplayScheduleList![
//                                                                   index]
//                                                                       .id
//                                                                 },
//                                                                 true,
//                                                                 deleteMentorScheduleRepo);
//                                                             setState(() {});
//                                                           },
//                                                           child: Padding(
//                                                             padding:
//                                                             const EdgeInsetsDirectional
//                                                                 .all(8.0),
//                                                             child: SvgPicture.asset(
//                                                                 'assets/Icons/deleteIcon.svg'),
//                                                           ),
//                                                         )
//                                                       ],
//                                                     ),
//
//                                                     const SizedBox(
//                                                       height: 14,
//                                                     ),
//
//                                                     ///---fee-day
//                                                     Row(
//                                                       children: [
//                                                         Expanded(
//                                                           child: Column(
//                                                             mainAxisAlignment:
//                                                             MainAxisAlignment.start,
//                                                             crossAxisAlignment:
//                                                             CrossAxisAlignment.start,
//                                                             children: [
//                                                               Text(
//                                                                 'day'.tr,
//                                                                 style: state
//                                                                     .previewLabelTextStyle,
//                                                               ),
//                                                               const SizedBox(
//                                                                 height: 4,
//                                                               ),
//                                                               Text(
//                                                                 _mentorScheduleLogic
//                                                                     .forDisplayScheduleList![
//                                                                 index]
//                                                                     .day!
//                                                                     .toUpperCase(),
//                                                                 style: state
//                                                                     .previewValueTextStyle,
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     const SizedBox(
//                                                       height: 14,
//                                                     ),
//                                                     Text(
//                                                       'slots'.tr,
//                                                       style: state.previewLabelTextStyle,
//                                                     ),
//                                                     const SizedBox(
//                                                       height: 4,
//                                                     ),
//                                                     Wrap(
//                                                       children: List.generate(
//                                                           _mentorScheduleLogic
//                                                               .forDisplayScheduleList![
//                                                           index]
//                                                               .scheduleSlots!
//                                                               .length, (innerIndex) {
//                                                         return Padding(
//                                                           padding:
//                                                           const EdgeInsetsDirectional
//                                                               .fromSTEB(0, 7, 14, 7),
//                                                           child: Container(
//                                                             color: customTextFieldColor,
//                                                             child: Padding(
//                                                               padding:
//                                                               const EdgeInsets.fromLTRB(
//                                                                   10, 8, 10, 8),
//                                                               child: Row(
//                                                                 mainAxisSize:
//                                                                 MainAxisSize.min,
//                                                                 children: [
//                                                                   Text(
//                                                                       '${_mentorScheduleLogic.forDisplayScheduleList![index].scheduleSlots![innerIndex].startTime}',
//                                                                       textDirection:
//                                                                       TextDirection.ltr,
//                                                                       style: state
//                                                                           .slotTextStyle),
//                                                                   // InkWell(
//                                                                   //     onTap: () {
//                                                                   //       log('--->>>Deactivate');
//                                                                   //     },
//                                                                   //     child:
//                                                                   //         const Padding(
//                                                                   //       padding:
//                                                                   //           EdgeInsets
//                                                                   //               .fromLTRB(
//                                                                   //                   5,
//                                                                   //                   0,
//                                                                   //                   10,
//                                                                   //                   0),
//                                                                   //       child: Icon(
//                                                                   //         Icons.clear,
//                                                                   //         color: Colors
//                                                                   //             .red,
//                                                                   //         size: 20,
//                                                                   //       ),
//                                                                   //     ))
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         );
//                                                       }),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )),
//                                         );
//                                       }),
//                                     )),
//                               ],
//                             ),
//                           )),
//                       Positioned(
//                         bottom: 0.h,
//                         left: 15.w,
//                         right: 15.w,
//                         child: InkWell(
//                           onTap: () {
//                             _generalController.focusOut(context);
//                             if (_profileFormKey.currentState!.validate()) {
//                               if (_editUserProfileLogic.profileImage != null) {
//                                 Get.find<GeneralController>()
//                                     .updateFormLoaderController(true);
//                                 menteeUpdateProfileImageRepo(
//                                     _editUserProfileLogic.profileImage);
//                               } else if (_editUserProfileLogic
//                                   .getMenteeProfileModel
//                                   .data!
//                                   .user!
//                                   .imagePath !=
//                                   null &&
//                                   _editUserProfileLogic.profileImage == null) {
//                                 Get.find<GeneralController>()
//                                     .updateFormLoaderController(true);
//                                 postMethod(
//                                     context,
//                                     updateMenteeProfileUrl,
//                                     {
//                                       'token': '123',
//                                       'user_id': Get.find<GeneralController>()
//                                           .storageBox
//                                           .read('userID'),
//                                       'first_name': _editUserProfileLogic
//                                           .firstNameController.text,
//                                       'last_name': _editUserProfileLogic
//                                           .lastNameController.text,
//                                       'gender':
//                                       _editUserProfileLogic.selectedGender,
//                                       'country': _editUserProfileLogic
//                                           .menteeProfileGenericDataModel
//                                           .data!
//                                           .countries![_editUserProfileLogic
//                                           .countryDropDownList
//                                           .indexOf(_editUserProfileLogic
//                                           .selectedCountry!)]
//                                           .id,
//                                       'city':
//                                       _editUserProfileLogic.selectedCity,
//                                     },
//                                     true,
//                                     menteeUpdateProfileRepo);
//                               } else {
//                                 showDialog(
//                                     context: context,
//                                     barrierDismissible: false,
//                                     builder: (BuildContext context) {
//                                       return CustomDialogBox(
//                                         title: 'SORRY!'.tr,
//                                         titleColor: customDialogErrorColor,
//                                         descriptions:
//                                         'Upload Your Profile Picture'.tr,
//                                         text: 'ok'.tr,
//                                         functionCall: () {
//                                           Navigator.pop(context);
//                                         },
//                                         img: 'assets/Icons/dialog_error.svg',
//                                       );
//                                     });
//                               }
//                             }
//                           },
//                           child: const MyCustomBottomBar(
//                             title: 'Update',
//                             disable: false,
//                           ),
//                         ),
//                       )
//                     ]),
//                   )),
//             ),
//           ),
//         );
//       });
//     });
//   }
// }
