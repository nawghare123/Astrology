import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/book_appointment/flutter_wave_repo.dart';
import 'package:consultant_product/src/modules/user/book_appointment/logic.dart';
import 'package:consultant_product/src/modules/user/home/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/subaccount.dart';
import 'package:flutterwave_standard/view/flutterwave_style.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';
import 'package:uuid/uuid.dart';

class FlutterWave extends StatefulWidget {
  String? amount;
  FlutterWave({Key? key, this.amount}) : super(key: key);

  @override
  _FlutterWaveState createState() => _FlutterWaveState();
}

class _FlutterWaveState extends State<FlutterWave> {
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  // Get.find<BookAppointmentLogic>().selectMentorAppointmentType!.fee;
  final currencyController = TextEditingController();

  // final narrationController = TextEditingController();
  // final publicKeyController = TextEditingController();
  // final encryptionKeyController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final nameController = TextEditingController();

  String selectedCurrency = "USD";

  bool isTestMode = true;

  final pbk = "FLWPUBK_TEST";
  @override
  void initState() {
    amountController.text = widget.amount.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currencyController.text = selectedCurrency;

    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<BookAppointmentLogic>(builder: (_bookAppointmentLogic) {
        return ModalProgressHUD(
          inAsyncCall: _generalController.formLoaderController!,
          progressIndicator: const CircularProgressIndicator(
            color: customThemeColor,
          ),
          child: Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/Icons/whiteBackArrow.svg',
                    ),
                  ],
                ),
              ),
              backgroundColor: customThemeColor,
            ),

            body: Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      Text(
                        'Flutter Wave Payment',
                        style: TextStyle(fontFamily: SarabunFontFamily.bold, fontSize: 28.sp, color: customTextBlackColor),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child:

                            /// Amount
                            TextFormField(
                          enabled: false,
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsetsDirectional.fromSTEB(25.w, 15.h, 25.w, 15.h),
                            hintText: 'Amount',
                            hintStyle: TextStyle(fontFamily: SarabunFontFamily.regular, fontSize: 16.sp, color: customTextGreyColor),
                            fillColor: customTextFieldColor,
                            filled: true,
                            enabledBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.transparent)),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.transparent)),
                            focusedBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: customLightThemeColor)),
                            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.red)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is Required';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),

                      /// Currency
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: TextFormField(
                          controller: currencyController,
                          textInputAction: TextInputAction.next,
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsetsDirectional.fromSTEB(25.w, 15.h, 25.w, 15.h),
                            hintText: 'Currency',
                            hintStyle: TextStyle(fontFamily: SarabunFontFamily.regular, fontSize: 16.sp, color: customTextGreyColor),
                            fillColor: customTextFieldColor,
                            filled: true,
                            enabledBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.transparent)),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.transparent)),
                            focusedBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: customLightThemeColor)),
                            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.red)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is Required';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),

                      /// name
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-z A-Z ]"))],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsetsDirectional.fromSTEB(25.w, 15.h, 25.w, 15.h),
                            hintText: 'Name',
                            hintStyle: TextStyle(fontFamily: SarabunFontFamily.regular, fontSize: 16.sp, color: customTextGreyColor),
                            fillColor: customTextFieldColor,
                            filled: true,
                            enabledBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.transparent)),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.transparent)),
                            focusedBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: customLightThemeColor)),
                            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.red)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is Required';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),

                      /// Email
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsetsDirectional.fromSTEB(25.w, 15.h, 25.w, 15.h),
                            hintText: "Email",
                            hintStyle: TextStyle(fontFamily: SarabunFontFamily.regular, fontSize: 16.sp, color: customTextGreyColor),
                            fillColor: customTextFieldColor,
                            filled: true,
                            enabledBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.transparent)),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.transparent)),
                            focusedBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: customLightThemeColor)),
                            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.red)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is Required';
                            } else if (!GetUtils.isEmail(value)) {
                              return 'Enter Valid Email';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),

                      /// Phone number
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: TextFormField(
                          controller: phoneNumberController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsetsDirectional.fromSTEB(25.w, 15.h, 25.w, 15.h),
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(fontFamily: SarabunFontFamily.regular, fontSize: 16.sp, color: customTextGreyColor),
                            fillColor: customTextFieldColor,
                            filled: true,
                            enabledBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.transparent)),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.transparent)),
                            focusedBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: customLightThemeColor)),
                            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.red)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field is Required';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),

                      // Container(
                      //   color: Colors.blue,
                      //   width: double.infinity,
                      //   height: 50,
                      //   margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                      //   child: ElevatedButton(
                      //     onPressed: _onPressed,
                      //     child: const Text(
                      //       "Make Payment",
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .06,
                      ),

                      /// Make Payment Button
                      InkWell(
                        onTap: () {
                          _onPressed();
                        },
                        child: const MyCustomBottomBar(
                          title: 'Make Payment',
                          disable: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          ),
        );
      });
    });
  }

  _onPressed() {
    if (formKey.currentState!.validate()) {
      _handlePaymentInitialization();
    }
  }

  _handlePaymentInitialization() async {
    final style = FlutterwaveStyle(
      appBarText: "Pay Your Consultant",
      buttonColor: customThemeColor,
      buttonTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      appBarColor: const Color(0xff101276),
      dialogCancelTextStyle: const TextStyle(
        color: Colors.red,
        fontSize: 18,
      ),
      dialogContinueTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      mainBackgroundColor: Colors.white,
      mainTextStyle: const TextStyle(color: Colors.white, fontSize: 19, letterSpacing: 2),
      dialogBackgroundColor: customThemeColor,
      appBarIcon: const Icon(Icons.monetization_on, color: Colors.white),
      buttonText: "Click to Pay $selectedCurrency ${Get.find<BookAppointmentLogic>().selectMentorAppointmentType!.fee.toString()}",
      appBarTitleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    );

    final Customer customer = Customer(name: nameController.text, phoneNumber: phoneNumberController.text, email: emailController.text);

    final subAccounts = [
      SubAccount(id: "RS_1A3278129B808CB588B53A14608169AD", transactionChargeType: "flat", transactionPercentage: 25),
      SubAccount(id: "RS_C7C265B8E4B16C2D472475D7F9F4426A", transactionChargeType: "flat", transactionPercentage: 50)
    ];

    final Flutterwave flutterwave = Flutterwave(
        context: context,
        style: style,
        publicKey: '${GlobalConfiguration().get('flutterWave_publicKey')}',
        currency: selectedCurrency,
        txRef: const Uuid().v1(),
        amount: amountController.text.toString().trim(),
        customer: customer,
        subAccounts: subAccounts,
        paymentOptions: "card, payattitude",
        customization: Customization(title: "Payment"),
        redirectUrl: "https://www.google.com",
        isTestMode: isTestMode);
    final ChargeResponse? response = await flutterwave.charge();
    if (response != null) {
      showLoading(response.status.toString());
      print("${response.toJson()}");
    } else {
      showErrorLoading("No Response!");
    }
  }

  void _openBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return _getCurrency();
        });
  }

  Widget _getCurrency() {
    final currencies = ["USD"];
    return Container(
      height: 250,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: currencies
            .map((currency) => ListTile(
                  onTap: () => {this._handleCurrencyTap(currency)},
                  title: Column(
                    children: [
                      Text(
                        currency,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 4),
                      Divider(height: 1)
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  _handleCurrencyTap(String currency) {
    setState(() {
      selectedCurrency = currency;
      currencyController.text = currency;
    });
    Navigator.pop(context);
  }

  Future<void> showLoading(String message) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 90.h,
            child: Column(
              children: [
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 24.sp,
                  ),
                ),
                InkWell(
                    onTap: () {
                      Get.find<GeneralController>().updateFormLoaderController(true);
                      postMethod(
                          context,
                          bookAppointmentUrl,
                          {
                            'token': '123',
                            'mentee_id': Get.find<GeneralController>().storageBox.read('userID'),
                            'mentor_id': Get.find<UserHomeLogic>().selectedConsultantID,
                            'payment': Get.find<BookAppointmentLogic>().selectMentorAppointmentType!.fee,
                            'payment_id': Get.find<BookAppointmentLogic>().paymentId,
                            'questions': Get.find<BookAppointmentLogic>().questionController.text,
                            'appointment_type_string': Get.find<BookAppointmentLogic>().selectMentorAppointmentType!.appointmentType!.name,
                            'appointment_type_id': Get.find<BookAppointmentLogic>().selectMentorAppointmentType!.appointmentType!.id,
                            'date': Get.find<BookAppointmentLogic>().selectedDateForAppointment.substring(0, 11),
                            'time': Get.find<BookAppointmentLogic>().selectedTimeForAppointment,
                            'end_time': Get.find<BookAppointmentLogic>().selectedEndTimeForAppointment
                          },
                          true,
                          flutterWaveRepo);
                    },
                    child: Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Container(
                            decoration: BoxDecoration(color: customThemeColor, borderRadius: BorderRadius.all(Radius.circular(12.r))),
                            height: 45.h,
                            width: 50.h,
                            child: Center(
                              child: Text(
                                'ok',
                                style: TextStyle(color: Colors.white, fontSize: 18.sp),
                              ),
                            ))))
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showErrorLoading(String message) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 90.h,
            child: Column(
              children: [
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 24.sp,
                  ),
                ),
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(12.r))),
                        height: 45.h,
                        width: 50.h,
                        child: Center(
                          child: Text(
                            'ok',
                            style: TextStyle(color: Colors.white, fontSize: 18.sp),
                          ),
                        )))
              ],
            ),
          ),
        );
      },
    );
  }
}
