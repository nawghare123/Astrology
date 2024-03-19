import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/modules/user/book_appointment/logic.dart';
import 'package:consultant_product/src/modules/wallet/easyPaisa_patment_wallet/maintenece.dart';
import 'package:consultant_product/src/modules/wallet/flutterwave_payment/view_flutterWave_payment.dart';
import 'package:consultant_product/src/modules/wallet/jazz_cash_payment/payment_jazzcash_view.dart';
import 'package:consultant_product/src/modules/wallet/logic.dart';
import 'package:consultant_product/src/modules/wallet/razorpay_payment/view_razorpay.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

paymentBottomSheetForWallet(BuildContext context) async {
  return Get.bottomSheet(
    ///---payment-method-area
    GetBuilder<WalletLogic>(builder: (_walletLogic) {
      return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: customTextBlackColor, width: 1)),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20.w, 25.h, 20.w, 7.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  LanguageConstant.paymentMethod.tr,
                  style: _walletLogic.state.headingTextStyle,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Wrap(
                  children: List.generate(
                      Get.find<BookAppointmentLogic>()
                          .getPaymentMethodList
                          .length, (index) {
                    if (Get.find<BookAppointmentLogic>()
                            .getPaymentMethodList[index]
                            .name ==
                        'wallet') {
                      return Container();
                    }
                    return Padding(
                      padding: index % 2 == 0
                          ? EdgeInsetsDirectional.fromSTEB(0, 0, 8.w, 18.h)
                          : EdgeInsetsDirectional.fromSTEB(8.w, 0.h, 0.w, 18.h),
                      child: InkWell(
                        onTap: () {
                          // Get.put(GeneralController());
                          // _walletLogic.selectedPaymentType = index;
                          Get.find<BookAppointmentLogic>().updateSelectedMethod(
                              Get.find<BookAppointmentLogic>()
                                  .getPaymentMethodList[index]
                                  .id,
                              Get.find<BookAppointmentLogic>()
                                  .getPaymentMethodList[index]
                                  .name!);
                          _walletLogic.update();
                          _walletLogic.amountController.clear();
                          if (Get.find<BookAppointmentLogic>()
                              .getPaymentMethodList[index]
                              .code!
                              .contains('razorpay')) {
                            Get.to(const RazorPayWalletView());
                          } else if (Get.find<BookAppointmentLogic>()
                              .getPaymentMethodList[index]
                              .code!
                              .contains('flutterwave')) {
                            Get.to(FlutterWaveWalletDeposit());
                          } else if (Get.find<BookAppointmentLogic>()
                              .getPaymentMethodList[index]
                              .code!
                              .contains('jazzcash')) {
                            Get.to(const PaymentJazzCashWalletView());
                          } else if (Get.find<BookAppointmentLogic>()
                              .getPaymentMethodList[index]
                              .code!
                              .contains('easypaisa')) {
                            Get.to(const EnvironmentMaintenancePage());
                          } else {
                            Get.offNamed(PageRoutes.stripePaymentForWallet);
                          }
                        },
                        child: Container(
                          height: 61.h,
                          width: MediaQuery.of(context).size.width * .38,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Get.find<BookAppointmentLogic>()
                                              .getPaymentMethodList[index]
                                              .isDefault ==
                                          1
                                      ? customLightThemeColor
                                      : Colors.white,
                                  width: 2),
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Get.find<BookAppointmentLogic>()
                                              .getPaymentMethodList[index]
                                              .isDefault ==
                                          1
                                      ? customLightThemeColor.withOpacity(0.2)
                                      : Colors.grey.withOpacity(0.2),
                                  spreadRadius: -2,
                                  blurRadius: 15,
                                  // offset: Offset(1,5)
                                )
                              ]),
                          child: Get.find<BookAppointmentLogic>()
                                  .getPaymentMethodList[index]
                                  .code!
                                  .contains('braintreePayment')
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: Image.network(
                                    '$mediaUrl/public/${Get.find<BookAppointmentLogic>().getPaymentMethodList[index].imagePath}',
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      '$mediaUrl/public/${Get.find<BookAppointmentLogic>().getPaymentMethodList[index].imagePath}',
                                      width: MediaQuery.of(context).size.width *
                                          .15,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      );
    }),
  );
}
