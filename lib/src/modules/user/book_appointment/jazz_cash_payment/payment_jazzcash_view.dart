import 'dart:developer';

import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/book_appointment/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_app_bar.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';

import 'jazz_cash_payment_repo.dart';

class PaymentJazzCashView extends StatefulWidget {
  const PaymentJazzCashView({Key? key}) : super(key: key);

  @override
  _PaymentJazzCashViewState createState() => _PaymentJazzCashViewState();
}

class _PaymentJazzCashViewState extends State<PaymentJazzCashView> with TickerProviderStateMixin {
  final logic = Get.put(BookAppointmentLogic());
  final state = Get.find<BookAppointmentLogic>().state;

  bool _canVibrate = true;
  final Iterable<Duration> pauses = [
    const Duration(milliseconds: 500),
    const Duration(milliseconds: 1000),
    const Duration(milliseconds: 500),
  ];

  final GlobalKey<FormState> _paymentFormKey = GlobalKey();

  AnimationController? slidAbleAnimationController1;
  AnimationController? slidAbleAnimationController2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Get.find<BookAppointmentLogic>().paymentAccountNumberTextController.clear();
      Get.find<BookAppointmentLogic>().jazzCashCnicTextController.clear();
    });
    slidAbleAnimationController1 = AnimationController.unbounded(vsync: this);
    slidAbleAnimationController2 = AnimationController.unbounded(vsync: this);

    _init();
  }

  Future<void> _init() async {
    bool canVibrate = await Vibrate.canVibrate;
    setState(() {
      _canVibrate = canVibrate;
      _canVibrate ? debugPrint('This device can vibrate') : debugPrint('This device cannot vibrate');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    slidAbleAnimationController1!.dispose();
    slidAbleAnimationController2!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: GetBuilder<BookAppointmentLogic>(
        builder: (_bookAppointmentLogicController) => GetBuilder<GeneralController>(builder: (_generalController) {
          return ModalProgressHUD(
            progressIndicator: const CircularProgressIndicator(
              color: customThemeColor,
            ),
            inAsyncCall: _generalController.formLoaderController!,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: const MyCustomAppBar(drawerShow: false, whiteBackground: true),
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                  child: Form(
                    key: _paymentFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ///---fee-section
                        Container(
                          height: 52,
                          width: double.infinity,
                          decoration: BoxDecoration(color: customThemeColor, borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: _generalController.isDirectionRTL(context) ? Alignment.centerRight : Alignment.centerLeft,
                                    child: Text(
                                      '${'you_will_be_charge'.tr}:',
                                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '${'rs'.tr}. ${Get.find<BookAppointmentLogic>().selectMentorAppointmentType!.fee}',
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        ///---heading
                        Text(
                          'enter_jazzCash_details'.tr,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        ///---jazz-cash-number-field
                        Container(
                          decoration: BoxDecoration(color: const Color(0xffF4F6FB), borderRadius: BorderRadius.circular(7)),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(15, 20, 15, 20),
                            child: Column(
                              children: [
                                ///---cnic-field
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'enter_last_6_digits'.tr,
                                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff757575)),
                                        )
                                      ],
                                    ),
                                    TextFormField(
                                      inputFormatters: [LengthLimitingTextInputFormatter(6), FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
                                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff757575)),
                                      controller: _bookAppointmentLogicController.jazzCashCnicTextController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        filled: true,
                                        fillColor: Color(0xffF4F6FB),
                                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: customThemeColor)),
                                        errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffDEE8EE))),
                                        border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffDEE8EE))),
                                      ),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'field_required'.tr;
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),

                                ///---number-field
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'jazzCash_number'.tr,
                                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff757575)),
                                        ),
                                      ],
                                    ),
                                    TextFormField(
                                      inputFormatters: [LengthLimitingTextInputFormatter(11), FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
                                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff757575)),
                                      controller: _bookAppointmentLogicController.paymentAccountNumberTextController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        filled: true,
                                        fillColor: Color(0xffF4F6FB),
                                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: customThemeColor)),
                                        errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffDEE8EE))),
                                        border: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffDEE8EE))),
                                      ),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'field_required'.tr;
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: InkWell(
                onTap: () {
                  if (_canVibrate) {
                    Vibrate.feedback(FeedbackType.heavy);
                  }
                  if (_paymentFormKey.currentState!.validate()) {
                    _generalController.updateFormLoaderController(true);
                    postMethod(
                        context,
                        jazzCashPaymentUrl,
                        {
                          'token': '123',
                          'mobile_no': _bookAppointmentLogicController.paymentAccountNumberTextController.text,
                          'bookAppointmentId': _bookAppointmentLogicController.bookAppointmentModel.data!.appointmentNo,
                          'cnic': _bookAppointmentLogicController.jazzCashCnicTextController.text,
                          'amount': _bookAppointmentLogicController.selectMentorAppointmentType!.fee,
                        },
                        true,
                        jazzCashPaymentRepo);

                    log('URl api---- $jazzCashPaymentUrl');
                  }
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.w, 0, 20.w, 0),
                  child: MyCustomBottomBar(
                    title: LanguageConstant.continueText.tr,
                    disable: false,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
