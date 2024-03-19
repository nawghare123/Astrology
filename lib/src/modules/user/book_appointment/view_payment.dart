//
//
// import 'package:consultant_product/route_generator.dart';
// import 'package:consultant_product/src/controller/general_controller.dart';
// import 'package:consultant_product/src/modules/user/book_appointment/logic.dart';
// import 'package:consultant_product/src/utils/colors.dart';
// import 'package:consultant_product/src/utils/constants.dart';
// import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
// import 'package:consultant_product/src/widgets/custom_sliver_app_bar.dart';
// import 'package:consultant_product/src/widgets/notififcation_icon.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:resize/resize.dart';
//
// class PaymentView extends StatefulWidget {
//   const PaymentView({Key? key}) : super(key: key);
//
//   @override
//   _PaymentViewState createState() => _PaymentViewState();
// }
//
// class _PaymentViewState extends State<PaymentView> {
//   final state = Get.find<BookAppointmentLogic>().state;
//
//   @override
//   void initState() {
//     super.initState();
//
//     Get.find<BookAppointmentLogic>().scrollController3 = ScrollController()
//       ..addListener(Get.find<BookAppointmentLogic>().scrollListener3);
//   }
//
//   @override
//   void dispose() {
//     Get.find<BookAppointmentLogic>()
//         .scrollController3!
//         .removeListener(Get.find<BookAppointmentLogic>().scrollListener3);
//     Get.find<BookAppointmentLogic>().scrollController3!.dispose();
//     super.dispose();
//   }
//
//   double translateX = 0.0;
//   double translateY = 0.0;
//   double myWidth = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<GeneralController>(builder: (_generalController) {
//       return GetBuilder<BookAppointmentLogic>(builder: (_bookAppointmentLogic) {
//         return GestureDetector(
//           onTap: () {
//             _generalController.focusOut(context);
//           },
//           child: Scaffold(
//             resizeToAvoidBottomInset: false,
//             body: NestedScrollView(
//                 controller: _bookAppointmentLogic.scrollController3,
//                 headerSliverBuilder:
//                     (BuildContext context, bool innerBoxIsScrolled) {
//                   return <Widget>[
//                     ///---header
//                     MyCustomSliverAppBar(
//                       heading: 'Book Appointment',
//                       subHeading: 'By just few easy steps',
//                       trailing: 'Step 3 Of 3',
//                       fee:
//                       '\$${_bookAppointmentLogic.consultantProfileLogic.appointmentTypes[_bookAppointmentLogic.selectedAppointmentTypeIndex!].fee}',
//                       feeImage:
//                       '${_bookAppointmentLogic.consultantProfileLogic.imagesForAppointmentTypes[_bookAppointmentLogic.consultantProfileLogic.appointmentTypes[_bookAppointmentLogic.selectedAppointmentTypeIndex!].appointmentTypeId! - 1]}',
//                       isShrink: _bookAppointmentLogic.isShrink3,
//                     ),
//                   ];
//                 },
//                 body: Stack(
//                   children: [
//                     ListView(
//                         padding:
//                             EdgeInsetsDirectional.fromSTEB(15.w, 20.h, 15.w, 0),
//                         children: [
//                           ///---card-heading
//                           Text(
//                             'Card Details',
//                             style: state.headingTextStyle,
//                           ),
//                           SizedBox(
//                             height: 18.h,
//                           ),
//                           SizedBox(
//                               height: 250.h,
//                               width: MediaQuery.of(context).size.width,
//                               child: Stack(
//                                 children: [
//                                   Image.asset(
//                                     'assets/images/cardBackground.png',
//                                     fit: BoxFit.fill,
//                                     height: 200.h,
//                                     width: MediaQuery.of(context).size.width,
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         vertical: 27.h, horizontal: 21.w),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: [
//                                         ///---card-number
//                                         Row(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Expanded(
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                     'Enter Card Number',
//                                                     style: TextStyle(
//                                                         fontFamily:
//                                                             SarabunFontFamily
//                                                                 .regular,
//                                                         fontSize: 14.sp,
//                                                         color: Colors.white),
//                                                   ),
//                                                   TextFormField(
//                                                     controller: _bookAppointmentLogic.accountCardNumberController,
//                                                     style:  TextStyle(
//                                                         fontFamily:
//                                                             SarabunFontFamily
//                                                                 .semiBold,
//                                                         fontSize: 16.sp,
//                                                         color: Colors.white),
//                                                     cursorColor: Colors.white,
//                                                     keyboardType:
//                                                         TextInputType.number,
//                                                     maxLines: 1,
//                                                     inputFormatters: [
//                                                       _bookAppointmentLogic.cardNumberMask
//                                                     ],
//                                                     decoration: InputDecoration(
//                                                       contentPadding:
//                                                           EdgeInsetsDirectional
//                                                               .fromSTEB(
//                                                                   0.w,
//                                                                   0.h,
//                                                                   0.w,
//                                                                   0.h),
//                                                       enabledBorder: UnderlineInputBorder(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                       8.r),
//                                                           borderSide:
//                                                               const BorderSide(
//                                                                   color: Colors
//                                                                       .transparent)),
//                                                       border: UnderlineInputBorder(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                       8.r),
//                                                           borderSide:
//                                                               const BorderSide(
//                                                                   color: Colors
//                                                                       .transparent)),
//                                                       focusedBorder:
//                                                           UnderlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           8.r),
//                                                               borderSide:
//                                                                   const BorderSide(
//                                                                       color: Colors
//                                                                           .white)),
//                                                       errorBorder:
//                                                           UnderlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           8.r),
//                                                               borderSide:
//                                                                   const BorderSide(
//                                                                       color: Colors
//                                                                           .red)),
//                                                     ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return 'field_required'.tr;
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             SvgPicture.asset(
//                                               'assets/Icons/masterCardIcon.svg',
//                                               height: 22.h,
//                                               width: 37.w,
//                                             )
//                                           ],
//                                         ),
//
//                                         SizedBox(
//                                           height: 30.h,
//                                         ),
//                                         Expanded(
//                                           child: Row(
//                                             children: [
//                                               ///---card-holder-name
//                                               Expanded(
//                                                 child: Align(
//                                                   alignment: Alignment.center,
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.start,
//                                                     children: [
//                                                       Text(
//                                                         'CARD HOLDER',
//                                                         style: TextStyle(
//                                                             fontFamily:
//                                                                 SarabunFontFamily
//                                                                     .regular,
//                                                             fontSize: 12.sp,
//                                                             color:
//                                                                 Colors.white),
//                                                       ),
//                                                       TextFormField(
//                                                         controller: _bookAppointmentLogic.accountCardHolderNameController,
//                                                         style:  TextStyle(
//                                                             fontFamily:
//                                                                 SarabunFontFamily
//                                                                     .semiBold,
//                                                             fontSize: 14.sp,
//                                                             color:
//                                                                 Colors.white),
//                                                         cursorColor:
//                                                             Colors.white,
//                                                         keyboardType:
//                                                             TextInputType.name,
//                                                         maxLines: 1,
//                                                         inputFormatters: [
//                                                           FilteringTextInputFormatter.allow(
//                                                               RegExp("[a-z A-Z ]"))
//                                                         ],
//                                                         decoration:
//                                                             InputDecoration(
//                                                           contentPadding:
//                                                               EdgeInsetsDirectional
//                                                                   .fromSTEB(
//                                                                       0.w,
//                                                                       0.h,
//                                                                       0.w,
//                                                                       0.h),
//                                                           enabledBorder: UnderlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           8.r),
//                                                               borderSide:
//                                                                   const BorderSide(
//                                                                       color: Colors
//                                                                           .transparent)),
//                                                           border: UnderlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           8.r),
//                                                               borderSide:
//                                                                   const BorderSide(
//                                                                       color: Colors
//                                                                           .transparent)),
//                                                           focusedBorder: UnderlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           8.r),
//                                                               borderSide:
//                                                                   const BorderSide(
//                                                                       color: Colors
//                                                                           .white)),
//                                                           errorBorder: UnderlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           8.r),
//                                                               borderSide:
//                                                                   const BorderSide(
//                                                                       color: Colors
//                                                                           .red)),
//                                                         ),
//                                                         validator: (value) {
//                                                           if (value!.isEmpty) {
//                                                             return 'field_required'.tr;
//                                                           } else {
//                                                             return null;
//                                                           }
//                                                         },
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//
//                                               ///---card-expiry
//                                               Expanded(
//                                                 child: Align(
//                                                   alignment: Alignment.center,
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .center,
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.start,
//                                                     children: [
//                                                       Text(
//                                                         'EXPIRES',
//                                                         style: TextStyle(
//                                                             fontFamily:
//                                                                 SarabunFontFamily
//                                                                     .regular,
//                                                             fontSize: 12.sp,
//                                                             color:
//                                                                 Colors.white),
//                                                       ),
//                                                       TextFormField(
//                                                         controller: _bookAppointmentLogic.accountCardExpiresController,
//                                                         textAlign: TextAlign.center,
//                                                         style:  TextStyle(
//                                                             fontFamily:
//                                                                 SarabunFontFamily
//                                                                     .semiBold,
//                                                             fontSize: 14.sp,
//                                                             color:
//                                                                 Colors.white),
//                                                         cursorColor:
//                                                             Colors.white,
//                                                         keyboardType:
//                                                             TextInputType.datetime,
//                                                         maxLines: 1,
//                                                         inputFormatters: [
//                                                           LengthLimitingTextInputFormatter(5),
//                                                           _bookAppointmentLogic.cardExpiryMask
//                                                         ],
//                                                         decoration:
//                                                             InputDecoration(
//                                                           contentPadding:
//                                                               EdgeInsetsDirectional
//                                                                   .fromSTEB(
//                                                                       0.w,
//                                                                       0.h,
//                                                                       0.w,
//                                                                       0.h),
//                                                           enabledBorder: UnderlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           8.r),
//                                                               borderSide:
//                                                                   const BorderSide(
//                                                                       color: Colors
//                                                                           .transparent)),
//                                                           border: UnderlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           8.r),
//                                                               borderSide:
//                                                                   const BorderSide(
//                                                                       color: Colors
//                                                                           .transparent)),
//                                                           focusedBorder: UnderlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           8.r),
//                                                               borderSide:
//                                                                   const BorderSide(
//                                                                       color: Colors
//                                                                           .white)),
//                                                           errorBorder: UnderlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           8.r),
//                                                               borderSide:
//                                                                   const BorderSide(
//                                                                       color: Colors
//                                                                           .red)),
//                                                         ),
//                                                         validator: (value) {
//                                                           if (value!.isEmpty) {
//                                                             return 'field_required'.tr;
//                                                           } else {
//                                                             return null;
//                                                           }
//                                                         },
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//
//                                               ///---card-cvv
//                                               Expanded(
//                                                 child: Align(
//                                                   alignment: Alignment.center,
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .center,
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.start,
//                                                     children: [
//                                                       Text(
//                                                         'CVV',
//                                                         style: TextStyle(
//                                                             fontFamily:
//                                                                 SarabunFontFamily
//                                                                     .regular,
//                                                             fontSize: 12.sp,
//                                                             color:
//                                                                 Colors.white),
//                                                       ),
//                                                       TextFormField(
//                                                         controller: _bookAppointmentLogic.accountCardCvcController,
//                                                         textAlign: TextAlign.center,
//                                                         style:  TextStyle(
//                                                             fontFamily:
//                                                                 SarabunFontFamily
//                                                                     .semiBold,
//                                                             fontSize: 14.sp,
//                                                             color:
//                                                                 Colors.white),
//                                                         cursorColor:
//                                                             Colors.white,
//                                                         keyboardType:
//                                                             TextInputType.number,
//                                                         obscureText: true,
//                                                         maxLines: 1,
//                                                         inputFormatters: [
//                                                           LengthLimitingTextInputFormatter(3),
//                                                           FilteringTextInputFormatter.allow(
//                                                               RegExp("[0-9 ]"))
//                                                         ],
//                                                         decoration:
//                                                             InputDecoration(
//                                                           contentPadding:
//                                                               EdgeInsetsDirectional
//                                                                   .fromSTEB(
//                                                                       0.w,
//                                                                       0.h,
//                                                                       0.w,
//                                                                       0.h),
//                                                           enabledBorder: UnderlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           8.r),
//                                                               borderSide:
//                                                                   const BorderSide(
//                                                                       color: Colors
//                                                                           .transparent)),
//                                                           border: UnderlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           8.r),
//                                                               borderSide:
//                                                                   const BorderSide(
//                                                                       color: Colors
//                                                                           .transparent)),
//                                                           focusedBorder: UnderlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           8.r),
//                                                               borderSide:
//                                                                   const BorderSide(
//                                                                       color: Colors
//                                                                           .white)),
//                                                           errorBorder: UnderlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           8.r),
//                                                               borderSide:
//                                                                   const BorderSide(
//                                                                       color: Colors
//                                                                           .red)),
//                                                         ),
//                                                         validator: (value) {
//                                                           if (value!.isEmpty) {
//                                                             return 'field_required'.tr;
//                                                           } else {
//                                                             return null;
//                                                           }
//                                                         },
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               )),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * .15,
//                           ),
//                         ]),
//
//                     ///---bottom-bar
//                     Positioned(
//                       bottom: 0.h,
//                       left: 15.w,
//                       right: 15.w,
//                       child: Center(
//                         child: Container(
//                           color: Colors.white,
//                           child: Padding(
//                             padding: EdgeInsets.only(bottom: 25.h),
//                             child: GestureDetector(
//                               onHorizontalDragUpdate: (event) async {
//                                 if (event.primaryDelta! > 10) {
//                                   _incTansXVal();
//                                 }
//                               },
//                               onHorizontalDragEnd: (event){
//                                 log('END---->>>');
//                                 // Get.toNamed(PageRoutes.appointmentConfirmation);
//                               },
//                               child: Container(
//                                 height: 56.h,
//                                 width: MediaQuery.of(context).size.width * .7,
//                                 decoration: BoxDecoration(
//                                     color: customThemeColor,
//                                     borderRadius: BorderRadius.circular(5.r),
//                                     boxShadow: [
//                                       BoxShadow(
//                                           color:
//                                               customThemeColor.withOpacity(0.7),
//                                           spreadRadius: -18,
//                                           blurRadius: 30,
//                                           offset: const Offset(0, 35))
//                                     ]),
//                                 child: Center(
//                                   child: Padding(
//                                     padding:
//                                         EdgeInsets.symmetric(horizontal: 25.w),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         paymentSuccessful(),
//                                         myWidth == 0.0
//                                             ? SvgPicture.asset(
//                                                 'assets/Icons/slideArrows.svg',
//                                                 height: 12.h,
//                                                 width: 42.w,
//                                               )
//                                             : const SizedBox(),
//                                         myWidth == 0.0
//                                             ?  Text(
//                                                 'Slide To Pay',
//                                                 style: TextStyle(
//                                                     fontFamily:
//                                                         SarabunFontFamily.bold,
//                                                     fontSize: 16.sp,
//                                                     color: Color(0xff8889BB)),
//                                               )
//                                             : const SizedBox(),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 )),
//           ),
//         );
//       });
//     });
//   }
//
//   Widget paymentSuccessful() => Transform.translate(
//         offset: Offset(translateX, translateY),
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           curve: Curves.linear,
//           width: 29 + myWidth,
//           height: 29,
//           child: myWidth > 0.0
//               ? const Icon(
//                   Icons.check,
//                   color: Colors.white,
//                   size: 30,
//                 )
//               : Center(
//                   child: SvgPicture.asset(
//                     'assets/Icons/slideToPayArrowIcon.svg',
//                     height: 29.h,
//                     width: 29.w,
//                   ),
//                 ),
//         ),
//       );
//
//   _incTansXVal() async {
//     int canLoop = -1;
//     for (var i = 0; canLoop == -1; i++) {
//       await Future.delayed(const Duration(milliseconds: 1), () {
//         setState(() {
//           if (translateX + 1 <
//               MediaQuery.of(context).size.width - (200 + myWidth)) {
//             translateX += 1;
//             myWidth = MediaQuery.of(context).size.width - (200 + myWidth);
//           } else {
//             canLoop = 1;
//           }
//         });
//       });
//     }
//   }
// }
