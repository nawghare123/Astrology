import 'dart:developer';
import 'dart:io';

import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/book_appointment/logic.dart';
import 'package:consultant_product/src/modules/user/book_appointment/payTm/payTm_view.dart';
import 'package:consultant_product/src/modules/user/book_appointment/post_repo.dart';
import 'package:consultant_product/src/modules/user/book_appointment/razorpay_payment/view_razorpay.dart';
import 'package:consultant_product/src/modules/user/book_appointment/view_confirmation.dart';
import 'package:consultant_product/src/modules/user/book_appointment/view_flutterWave_payment.dart';
import 'package:consultant_product/src/modules/user/book_appointment/wallet_payment/view.dart';
import 'package:consultant_product/src/modules/user/home/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:consultant_product/src/widgets/custom_dialog.dart';
import 'package:consultant_product/src/widgets/custom_sliver_app_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';
import 'package:dio/dio.dart' as dio_instance;
import 'package:upi_india/upi_india.dart';

class AppointmentQuestionPage extends StatefulWidget {
  int? appointmentId;
  int? mentorId;
  bool? showPaymentSection;
  AppointmentQuestionPage(
      {Key? key, this.appointmentId, this.mentorId, this.showPaymentSection})
      : super(key: key);

  @override
  _AppointmentQuestionPageState createState() =>
      _AppointmentQuestionPageState();
}

class _AppointmentQuestionPageState extends State<AppointmentQuestionPage> {
  final state = Get.find<BookAppointmentLogic>().state;

  @override
  void initState() {
    super.initState();

    Get.find<BookAppointmentLogic>().scrollController2 = ScrollController()
      ..addListener(Get.find<BookAppointmentLogic>().scrollListener2);
    Get.find<BookAppointmentLogic>().selectedPaymentType = null;
    Get.find<BookAppointmentLogic>().questionController.clear();
    if (widget.appointmentId != null) {
      getMethod(
          context,
          getAppointmentsDetailURL,
          {
            'token': 123,
            'appointment_id': widget.appointmentId,
            'user_id': Get.find<GeneralController>().storageBox.read('userID'),
          },
          true,
          getAppDetailForReschedule);
    }

    getMethod(
        context,
        getPaymentMethodsUrl,
        {
          'token': 123,
          'platform': 'app',
        },
        true,
        getPaymentMethodsRepo);

    // UPI INTEGRATION STUFF

    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
  }

  @override
  void dispose() {
    Get.find<BookAppointmentLogic>()
        .scrollController2!
        .removeListener(Get.find<BookAppointmentLogic>().scrollListener2);
    Get.find<BookAppointmentLogic>().scrollController2!.dispose();
    super.dispose();
  }

  bool? disableButton = true;
  bool? wave = false;
  bool? razorPay = false;
  bool? paytm = false;
  bool? wallet = false;

  final GlobalKey<FormState> _formKey = GlobalKey();

  // UPI INTEGRATION STUFF

  Future<UpiResponse>? _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  TextStyle header = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle value = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  // @override
  // void initState() {
  //   _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
  //     setState(() {
  //       apps = value;
  //     });
  //   }).catchError((e) {
  //     apps = [];
  //   });
  //   super.initState();
  // }

  Future<UpiResponse> initiateTransaction(UpiApp app, double money) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "9340254599@ybl",
      receiverName: 'Ashok Gehlot',
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'Book Appointment.',
      amount: money,
    );
  }

  Widget displayUpiApps(double money) {
    if (apps == null)
      return Center(child: CircularProgressIndicator());
    else if (apps!.length == 0)
      return Center(
        child: Text(
          "No apps found to handle transaction.",
          style: header,
        ),
      );
    else
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () {
                                          
        // setState(() {
        //   disableButton = false;
        // });
                  _transaction = initiateTransaction(app, money);
                  // setState(() {});
                 
                },
                child: Container(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.memory(
                        app.icon,
                        height: 60,
                        width: 60,
                      ),
                      Text(app.name),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        break;
      default:
        print('Received an Unknown transaction status');
    }
  }

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: ", style: header),
          Flexible(
              child: Text(
            body,
            style: value,
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<BookAppointmentLogic>(builder: (_bookAppointmentLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: ModalProgressHUD(
            inAsyncCall: _generalController.formLoaderController!,
            progressIndicator: const CircularProgressIndicator(
              color: customThemeColor,
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: NestedScrollView(
                  controller: _bookAppointmentLogic.scrollController2,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      ///---header
                      MyCustomSliverAppBar(
                        heading: LanguageConstant.bookAppointment.tr,
                        subHeading: LanguageConstant.byJustFewEasySteps.tr,
                        trailing: LanguageConstant.step2Of3.tr,
                        isShrink: _bookAppointmentLogic.isShrink2,
                        fee:
                            '${Get.find<GeneralController>().storageBox.read('currency')}${_bookAppointmentLogic.consultantProfileLogic.appointmentTypes[_bookAppointmentLogic.selectedAppointmentTypeIndex!].fee}',
                        feeImage:
                            '${_bookAppointmentLogic.consultantProfileLogic.imagesForAppointmentTypes[_bookAppointmentLogic.consultantProfileLogic.appointmentTypes[_bookAppointmentLogic.selectedAppointmentTypeIndex!].appointmentTypeId! - 1]}',
                      ),
                    ];
                  },
                  body: Stack(
                    children: [
                      ListView(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.w, 20.h, 15.w, 0),
                          children: [
                            ///---question-area
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3,
                                      blurRadius: 15,
                                      // offset: Offset(1,5)
                                    )
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 25.h, horizontal: 20.w),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        LanguageConstant.typeYourQuestion.tr,
                                        style: state.headingTextStyle,
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),

                                      ///---question-field

                                      TextFormField(
                                        controller: _bookAppointmentLogic
                                            .questionController,
                                        keyboardType: TextInputType.text,
                                        maxLines: 3,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  25.w, 15.h, 25.w, 15.h),
                                          fillColor: customTextFieldColor,
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
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return LanguageConstant
                                                .fieldRequired.tr;
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 25.h,
                            ),

                            ///---upload-file-area
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3,
                                      blurRadius: 15,
                                      // offset: Offset(1,5)
                                    )
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 25.h, horizontal: 20.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          LanguageConstant.uploadFile.tr,
                                          style: state.headingTextStyle,
                                        ),
                                        Text(
                                          '  (${LanguageConstant.ifAny.tr})',
                                          style: TextStyle(
                                              fontFamily:
                                                  SarabunFontFamily.medium,
                                              fontSize: 12.sp,
                                              color: customTextBlackColor),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        if (_bookAppointmentLogic
                                                .selectedFileName ==
                                            null) {
                                          _bookAppointmentLogic
                                                  .filePickerResult =
                                              await FilePicker.platform
                                                  .pickFiles(
                                            type: FileType.any,
                                            // allowedExtensions: ["jpg", "png", "pdf", "doc"],
                                          );
                                          if (_bookAppointmentLogic
                                                  .filePickerResult !=
                                              null) {
                                            final file = File(
                                                _bookAppointmentLogic
                                                    .filePickerResult!
                                                    .files[0]
                                                    .path!);
                                            setState(() {});
                                            int sizeInBytes = file.lengthSync();
                                            double sizeInMb =
                                                sizeInBytes / (1024 * 1024);
                                            if (sizeInMb > 10) {
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder:
                                                      (BuildContext context) {
                                                    return CustomDialogBox(
                                                      title: LanguageConstant
                                                          .failed.tr,
                                                      titleColor:
                                                          customDialogErrorColor,
                                                      descriptions: LanguageConstant
                                                          .fileIsGreaterThan10mb
                                                          .tr,
                                                      text: LanguageConstant
                                                          .ok.tr,
                                                      functionCall: () {
                                                        Navigator.pop(context);
                                                      },
                                                      img:
                                                          'assets/Icons/dialog_error.svg',
                                                    );
                                                  });
                                            } else {
                                              _bookAppointmentLogic
                                                  .updateSelectedFileName(
                                                      _bookAppointmentLogic
                                                          .filePickerResult!
                                                          .files[0]
                                                          .name);
                                              setState(() {});
                                            }
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: 69.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: customLightOrangeColor,
                                            borderRadius:
                                                BorderRadius.circular(8.r)),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SvgPicture.asset(
                                                'assets/Icons/dottedBorder.svg',
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Center(
                                              child: _bookAppointmentLogic
                                                          .selectedFileName !=
                                                      null
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              _bookAppointmentLogic
                                                                  .selectedFileName!,
                                                              softWrap: true,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      SarabunFontFamily
                                                                          .medium,
                                                                  fontSize:
                                                                      12.sp,
                                                                  color:
                                                                      customOrangeColor),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              _bookAppointmentLogic
                                                                  .updateSelectedFileName(
                                                                      null);
                                                            },
                                                            child: const Icon(
                                                              Icons.cancel,
                                                              color:
                                                                  customOrangeColor,
                                                              size: 25,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SvgPicture.asset(
                                                          'assets/Icons/uploadIcon.svg',
                                                          height: 23.h,
                                                          width: 25.w,
                                                        ),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        Text(
                                                          LanguageConstant
                                                              .uploadHere.tr,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  SarabunFontFamily
                                                                      .medium,
                                                              fontSize: 12.sp,
                                                              color:
                                                                  customOrangeColor),
                                                        )
                                                      ],
                                                    ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),

                            // ///---payment-method-area
                            widget.showPaymentSection == true
                                ? const SizedBox()
                                // NEW UPI INTEGRATION CODE
                                // : displayUpiApps(double.parse(_bookAppointmentLogic
                                //         .consultantProfileLogic
                                //         .appointmentTypes[_bookAppointmentLogic
                                //             .selectedAppointmentTypeIndex!]
                                //         .fee
                                //         .toString()) ??
                                //     0.0),
                                : ListView(
                                    primary: false,
                                    shrinkWrap: true,
                                    children: <Widget>[
                                      Expanded(
                                        child: displayUpiApps((_bookAppointmentLogic
                                                    .consultantProfileLogic
                                                    .appointmentTypes[
                                                        _bookAppointmentLogic
                                                            .selectedAppointmentTypeIndex!]
                                                    .fee ??
                                                0)
                                            .toDouble()),
                                      ),
                                      Expanded(
                                        child: FutureBuilder(
                                          future: _transaction,
                                          builder: (BuildContext context,
                                              AsyncSnapshot<UpiResponse>
                                                  snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              if (snapshot.hasError) {
                                                return Center(
                                                  child: Text(
                                                    _upiErrorHandler(snapshot
                                                        .error.runtimeType),
                                                    style: header,
                                                  ), // Print's text message on screen
                                                );
                                              }

                                              // If we have data then definitely we will have UpiResponse.
                                              // It cannot be null
                                              UpiResponse _upiResponse =
                                                  snapshot.data!;

                                              // Data in UpiResponse can be null. Check before printing
                                              String txnId =
                                                  _upiResponse.transactionId ??
                                                      'N/A';
                                              String resCode =
                                                  _upiResponse.responseCode ??
                                                      'N/A';
                                              String txnRef = _upiResponse
                                                      .transactionRefId ??
                                                  'N/A';
                                              String status =
                                                  _upiResponse.status ?? 'N/A';
                                              String approvalRef =
                                                  _upiResponse.approvalRefNo ??
                                                      'N/A';
                                              _checkTxnStatus(status);
                       

                                              // return AppointmentConfirmationView();

                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    displayTransactionData(
                                                        'Transaction Id',
                                                        txnId),
                                                    displayTransactionData(
                                                        'Response Code',
                                                        resCode),
                                                    displayTransactionData(
                                                        'Reference Id', txnRef),
                                                    displayTransactionData(
                                                        'Status',
                                                        status.toUpperCase()),
                                                    displayTransactionData(
                                                        'Approval No',
                                                        approvalRef),
                                                  ],
                                                ),
                                              );
                                            } else
                                              return Center(
                                                child: Text(''),
                                              );
                                          },
                                        ),
                                      )
                                    ],
                                  ),

                            // // OLD PAYMENT GATEWAY
                            // : Container(
                            //     decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(8.r), border: Border.all(color: customTextBlackColor, width: 1)),
                            //     child: Padding(
                            //       padding: EdgeInsetsDirectional.fromSTEB(20.w, 25.h, 20.w, 7.h),
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         mainAxisAlignment: MainAxisAlignment.start,
                            //         children: [
                            //           Text(
                            //             LanguageConstant.paymentMethod.tr,
                            //             style: state.headingTextStyle,
                            //           ),
                            //           SizedBox(
                            //             height: 20.h,
                            //           ),
                            //           Wrap(
                            //             children: List.generate(_bookAppointmentLogic.getPaymentMethodList.length, (index) {
                            //               return Padding(
                            //                 padding: index % 2 == 0 ? EdgeInsetsDirectional.fromSTEB(0, 0, 8.w, 18.h) : EdgeInsetsDirectional.fromSTEB(8.w, 0.h, 0.w, 18.h),
                            //                 child: InkWell(
                            //                   onTap: () {
                            //                     // for (var element in _bookAppointmentLogic.paymentMethodList) {
                            //                     //   element.isSelected = false;
                            //                     // }
                            //                     log('${_bookAppointmentLogic.getPaymentMethodList[index].id}');
                            //                     log('${_bookAppointmentLogic.getPaymentMethodList[index].name}');

                            //                     _bookAppointmentLogic.updateSelectedMethod(
                            //                         _bookAppointmentLogic.getPaymentMethodList[index].id, _bookAppointmentLogic.getPaymentMethodList[index].name!);
                            //                     // _bookAppointmentLogic.selectedPaymentType = index;
                            //                     _bookAppointmentLogic.update();
                            //                     setState(() {
                            //                       disableButton = false;
                            //                     });

                            //                     /// Show flutterwave payment button
                            //                     if (_bookAppointmentLogic.getPaymentMethodList[index].code!.contains('flutterwave')) {
                            //                       setState(() {
                            //                         wave = true;
                            //                       });
                            //                     } else {
                            //                       setState(() {
                            //                         wave = false;
                            //                       });
                            //                     }

                            //                     /// Show razorPay payment button
                            //                     if (_bookAppointmentLogic.getPaymentMethodList[index].code!.contains('razorpay')) {
                            //                       setState(() {
                            //                         razorPay = true;
                            //                       });
                            //                     } else {
                            //                       setState(() {
                            //                         razorPay = false;
                            //                       });
                            //                     }

                            //                     /// Show paytm payment button
                            //                     if (_bookAppointmentLogic.getPaymentMethodList[index].code!.contains('paytm')) {
                            //                       setState(() {
                            //                         paytm = true;
                            //                       });
                            //                     } else {
                            //                       setState(() {
                            //                         paytm = false;
                            //                       });
                            //                     }

                            //                     /// Show wallet payment button
                            //                     if (_bookAppointmentLogic.getPaymentMethodList[index].code!.contains('wallet')) {
                            //                       setState(() {
                            //                         wallet = true;
                            //                       });
                            //                     } else {
                            //                       setState(() {
                            //                         wallet = false;
                            //                       });
                            //                     }
                            //                   },
                            //                   child: Container(
                            //                     height: 61.h,
                            //                     width: MediaQuery.of(context).size.width * .38,
                            //                     decoration: BoxDecoration(
                            //                         color: Colors.white,
                            //                         border: Border.all(
                            //                             color: (_bookAppointmentLogic.selectedMethodId ?? 9091) == _bookAppointmentLogic.getPaymentMethodList[index].id
                            //                                 ? customLightThemeColor
                            //                                 : Colors.white,
                            //                             width: 2),
                            //                         borderRadius: BorderRadius.circular(8.r),
                            //                         boxShadow: [
                            //                           BoxShadow(
                            //                             color: _bookAppointmentLogic.getPaymentMethodList[index].isDefault == 1 ? customLightThemeColor.withOpacity(0.2) : Colors.grey.withOpacity(0.2),
                            //                             spreadRadius: -2,
                            //                             blurRadius: 15,
                            //                             // offset: Offset(1,5)
                            //                           )
                            //                         ]),
                            //                     child: _bookAppointmentLogic.getPaymentMethodList[index].code!.contains('braintreePayment')
                            //                         ? ClipRRect(
                            //                             borderRadius: BorderRadius.circular(8.r),
                            //                             child: Image.network(
                            //                               '$mediaUrl/public/${_bookAppointmentLogic.getPaymentMethodList[index].imagePath}',
                            //                               width: double.infinity,
                            //                               height: double.infinity,
                            //                             ),
                            //                           )
                            //                         : Column(
                            //                             crossAxisAlignment: CrossAxisAlignment.center,
                            //                             mainAxisAlignment: MainAxisAlignment.center,
                            //                             children: [
                            //                               _bookAppointmentLogic.getPaymentMethodList[index].id == 110
                            //                                   ? SvgPicture.asset(
                            //                                       _bookAppointmentLogic.getPaymentMethodList[index].imagePath!,
                            //                                       width: 25.w,
                            //                                       height: 25.h,
                            //                                     )
                            //                                   : Image.network(
                            //                                       '$mediaUrl/public/${_bookAppointmentLogic.getPaymentMethodList[index].imagePath}',
                            //                                       width: MediaQuery.of(context).size.width * .15,
                            //                                     ),
                            //                             ],
                            //                           ),
                            //                   ),
                            //                 ),
                            //               );
                            //             }),
                            //           )
                            //         ],
                            //       ),
                            //     ),
                            //   ),

                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .15),
                          ]),

                      ///---bottom-bar
                      widget.showPaymentSection == true
                          ? Positioned(
                              bottom: 0.h,
                              left: 15.w,
                              right: 15.w,
                              child: InkWell(
                                onTap: () {
                                  Get.find<GeneralController>()
                                      .updateFormLoaderController(true);
                                  print(_bookAppointmentLogic
                                      .selectMentorAppointmentType!
                                      .appointmentType!
                                      .id);
                                  print(_bookAppointmentLogic
                                      .selectMentorAppointmentType!
                                      .appointmentType);
                                  postMethod(
                                      context,
                                      bookAppointmentUrl,
                                      {
                                        'token': '123',
                                        'mentee_id': _bookAppointmentLogic
                                            .getAppDetailForReschedule
                                            .data!
                                            .appointment!
                                            .menteeId,
                                        'mentor_id': widget.mentorId,
                                        'payment': _bookAppointmentLogic
                                            .getAppDetailForReschedule
                                            .data!
                                            .appointment!
                                            .payment,
                                        'payment_id': _bookAppointmentLogic
                                            .getAppDetailForReschedule
                                            .data!
                                            .appointment!
                                            .paymentId,
                                        'questions': _bookAppointmentLogic
                                            .getAppDetailForReschedule
                                            .data!
                                            .appointment!
                                            .questions,
                                        'appointment_type_string':
                                            _bookAppointmentLogic
                                                .selectMentorAppointmentType!
                                                .appointmentType!
                                                .name,
                                        'appointment_type_id':
                                            _bookAppointmentLogic
                                                .selectMentorAppointmentType!
                                                .appointmentType!
                                                .id,
                                        'date': _bookAppointmentLogic
                                            .selectedDateForAppointment
                                            .substring(0, 11),
                                        'time': _bookAppointmentLogic
                                            .selectedTimeForAppointment,
                                        'bookAppointmentId':
                                            widget.appointmentId,
                                        'end_time': _bookAppointmentLogic
                                            .selectedEndTimeForAppointment
                                      },
                                      true,
                                      bookRescheduleAppointmentWithoutFileRepo);
                                },
                                child: const MyCustomBottomBar(
                                  title: 'Update',
                                  disable: false,
                                ),
                              ),
                            )
                          :

                          ///  Paytm
                          paytm == true
                              ? Positioned(
                                  bottom: 0.h,
                                  left: 15.w,
                                  right: 15.w,
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(const PayTm());
                                      // postMethod(
                                      //     context,
                                      //     'https://securegw-stage.paytm.in/theia/api/v1/initiateTransaction?mid=Ddqckl36992914432459&orderId=ORDERID_98765',
                                      //     {
                                      //       "body": {
                                      //         "requestType": "Payment",
                                      //         "mid": "Ddqckl36992914432459",
                                      //         "websiteName": "Consultant",
                                      //         "orderId": "ORDERID_98765",
                                      //         "txnAmount": {"value": "100.00", "currency": "USD"},
                                      //         "userInfo": {"custId": "CUST_001"},
                                      //         "callbackUrl": "https://docs.flutter.dev/cookbook/networking/fetch-data"
                                      //       },
                                      //       "head": {"signature": "Consultant"}
                                      //     },
                                      //     true,
                                      //     pytmRepo);
                                    },
                                    child: const MyCustomBottomBar(
                                        title: 'Paytm', disable: false),
                                  ),
                                )

                              ///  wallet
                              // : wallet == true
                              //     ? Positioned(
                              //         bottom: 0.h,
                              //         left: 15.w,
                              //         right: 15.w,
                              //         child: InkWell(
                              //           onTap: () {
                              //             if (_formKey.currentState!.validate()) {
                              //               print("-=-=----=-=-=-=-=-=-=-");
                              //               print(widget.appointmentId);
                              //
                              //               Get.to(WalletPaymentView(appointmentId: widget.appointmentId));
                              //             }
                              //           },
                              //           child: const MyCustomBottomBar(
                              //             title: 'Wallet',
                              //             disable: false,
                              //           ),
                              //         ),
                              //       )

                              /// RazorPay
                              : razorPay == true
                                  ? Positioned(
                                      bottom: 0.h,
                                      left: 15.w,
                                      right: 15.w,
                                      child: InkWell(
                                        onTap: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            Get.to(RazorPayView(
                                                amount: _bookAppointmentLogic
                                                    .selectMentorAppointmentType!
                                                    .fee
                                                    .toString()));
                                          }
                                        },
                                        child: const MyCustomBottomBar(
                                          title: 'Razor Pay',
                                          disable: false,
                                        ),
                                      ),
                                    )

                                  /// FlutterWave
                                  : wave == true
                                      ? Positioned(
                                          bottom: 0.h,
                                          left: 15.w,
                                          right: 15.w,
                                          child: InkWell(
                                            onTap: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                Get.to(FlutterWave(
                                                    amount: _bookAppointmentLogic
                                                        .selectMentorAppointmentType!
                                                        .fee
                                                        .toString()));
                                              }
                                            },
                                            child: const MyCustomBottomBar(
                                              title: 'Flutter Wave',
                                              disable: false,
                                            ),
                                          ),
                                        )
                                      : Positioned(
                                          bottom: 0.h,
                                          left: 15.w,
                                          right: 15.w,
                                          child: InkWell(
                                            onTap: () async {
                                              // setState(() {
                                              //   disableButton = false;
                                              // });
                                              if (!disableButton! &&
                                                  _formKey.currentState!
                                                      .validate()) {
                                                _generalController
                                                    .updateFormLoaderController(
                                                        true);

                                                dio_instance.FormData formData =
                                                    dio_instance.FormData
                                                        .fromMap(<String,
                                                            dynamic>{
                                                  'token': '123',
                                                  'mentee_id': Get.find<
                                                          GeneralController>()
                                                      .storageBox
                                                      .read('userID'),
                                                  'mentor_id':
                                                      Get.find<UserHomeLogic>()
                                                          .selectedConsultantID,
                                                  'payment': _bookAppointmentLogic
                                                      .selectMentorAppointmentType!
                                                      .fee,
                                                  'payment_id':
                                                      _bookAppointmentLogic
                                                          .paymentId,
                                                  'questions':
                                                      _bookAppointmentLogic
                                                          .questionController
                                                          .text,
                                                  'appointment_type_string':
                                                      _bookAppointmentLogic
                                                          .selectMentorAppointmentType!
                                                          .appointmentType!
                                                          .name,
                                                  'appointment_type_id':
                                                      _bookAppointmentLogic
                                                          .selectMentorAppointmentType!
                                                          .appointmentType!
                                                          .id,
                                                  if (_bookAppointmentLogic
                                                          .selectMentorAppointmentType!
                                                          .appointmentType!
                                                          .isScheduleRequired ==
                                                      1)
                                                    'date': _bookAppointmentLogic
                                                        .selectedDateForAppointment
                                                        .substring(0, 11),
                                                  if (_bookAppointmentLogic
                                                          .selectMentorAppointmentType!
                                                          .appointmentType!
                                                          .isScheduleRequired ==
                                                      1)
                                                    'time': _bookAppointmentLogic
                                                        .selectedTimeForAppointment,
                                                  'end_time': _bookAppointmentLogic
                                                      .selectedEndTimeForAppointment,
                                                  if (_bookAppointmentLogic
                                                          .selectedFileName !=
                                                      null)
                                                    'book_file':
                                                        await dio_instance
                                                                .MultipartFile
                                                            .fromFile(
                                                      File(_bookAppointmentLogic
                                                              .filePickerResult!
                                                              .files[0]
                                                              .path!)
                                                          .path,
                                                    )
                                                });

                                                postMethod(
                                                    context,
                                                    bookAppointmentUrl,
                                                    formData,
                                                    true,
                                                    bookAppointmentRepo);
                                                Get.to(() =>
                                                    AppointmentConfirmationView());
                                              }
                                            },
                                            child: MyCustomBottomBar(
                                              title: LanguageConstant
                                                  .continueText.tr,
                                              // disable: disableButton!,
                                              disable: false,
                                            ),
                                          ),
                                        )
                    ],
                  )),
            ),
          ),
        );
      });
    });
  }
}
