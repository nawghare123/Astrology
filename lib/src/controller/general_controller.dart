import 'dart:io';
import 'dart:math' as math;

import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/modules/agora_call/get_agora_token_model.dart';
import 'package:consultant_product/src/modules/agora_call/get_fcm_token_model.dart';
import 'package:consultant_product/src/modules/agora_call/repo.dart';
import 'package:consultant_product/src/modules/user_profile/get_user_profile_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:resize/resize.dart';

class GeneralController extends GetxController {
  GetStorage storageBox = GetStorage();

  bool isDirectionRTL(BuildContext context) {
    final TextDirection currentDirection = Directionality.of(context);
    final bool isRTL = currentDirection == TextDirection.rtl;
    return isRTL;
  }

  ///---get-user-profile
  GetConsultantProfileModel getConsultantProfileModel =
      GetConsultantProfileModel();

  bool formLoaderController = false;

  updateFormLoaderController(bool newValue) {
    formLoaderController = newValue;
    update();
  }

  ///---appbar-open
  String? appBarSelectedCountryCode = '+92';

  updateAppBarSelectedCountryCode(String? newValue) {
    appBarSelectedCountryCode = newValue;
    update();
  }

  ///---appbar-close

  ///--focus-out
  focusOut(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  ///---random-string-open
  String chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  math.Random rnd = math.Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

  String? selectedChannel;

  updateSelectedChannel(String? newValue) {
    selectedChannel = newValue;
    update();
  }

  int callerType = 2;

  updateCallerType(int i) {
    callerType = i;
    update();
  }

  GetAgoraTokenModel getAgoraTokenModel = GetAgoraTokenModel();
  bool? goForCall = true;

  updateGoForCall(bool? newValue) {
    goForCall = newValue;
    update();
  }

  String? channelForCall;
  String? tokenForCall;

  updateTokenForCall(String? newValueToken) {
    tokenForCall = newValueToken;
    update();
  }

  updateChannelForCall(String? newValueChannel) {
    channelForCall = newValueChannel;
    update();
  }

  GetFcmTokenModel getFcmTokenModel = GetFcmTokenModel();
  int? userIdForSendNotification;

  updateUserIdForSendNotification(int? newValue) {
    userIdForSendNotification = newValue;
    update();
  }

  int? appointmentIdForSendNotification;

  updateAppointmentIdForSendNotification(int? newValue) {
    appointmentIdForSendNotification = newValue;
    update();
  }

  String? notificationTitle;
  String? notificationBody;
  String? notificationRouteApp;
  String? notificationRouteWeb;
  String? sound;

  updateNotificationBody(String? newTitle, String? newBody, String? newRouteApp,
      String? newRouteWeb, String? newSound) {
    notificationTitle = newTitle;
    notificationBody = newBody;
    notificationRouteApp = newRouteApp;
    notificationRouteWeb = newRouteWeb;
    sound = newSound;
    update();
  }

  ///---fcm-token
  String? fcmToken;

  updateFcmToken(BuildContext context) async {
    await FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.getToken().then((value) {
      fcmToken = value;
      storageBox.write('fcmToken', fcmToken);
      getId(context);
    }).catchError((onError) {});
  }

  Future<String?> getId(BuildContext context) async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      postMethod(
          context,
          fcmUpdateUrl,
          {
            'token': '123',
            'fcm_token': fcmToken,
            'device_id': iosDeviceInfo.identifierForVendor,
            'user_id': Get.find<GeneralController>().storageBox.read('userID')
          },
          false,
          updateFcmTokenRepo);
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;

      postMethod(
          context,
          fcmUpdateUrl,
          {
            'token': '123',
            'fcm_token': fcmToken,
            'device_id': androidDeviceInfo.id,
            'user_id': Get.find<GeneralController>().storageBox.read('userID')
          },
          false,
          updateFcmTokenRepo);
      return androidDeviceInfo.id; // unique ID on Android
    }
  }

  List<Language> localeList = [
    Language(1, 'English', '🇺🇸', 'en', 'US'),
    // Language(2, 'اردو', '🇵🇰', 'ur', 'PK'),
    Language(3, 'हिन्दी', '🇮🇳', 'hi', 'IN'),
    Language(4, 'বাংলা', '🇧🇩', 'bn', 'BD'),
  ];

  Language? selectedLocale;

  updateSelectedLocale(Language? newValue) {
    selectedLocale = newValue;
    update();
  }

  checkLanguage() {
    if (storageBox.hasData('languageIndex')) {
      updateSelectedLocale(
          localeList[int.parse(storageBox.read('languageIndex').toString())]);
    } else {
      storageBox.write('languageCode', localeList[0].languageCode);
      storageBox.write('countryCode', localeList[0].countryCode);
      updateSelectedLocale(localeList[0]);
    }
  }

  customDropDownDialogForLocale(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 3,
                            blurRadius: 9,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              LanguageConstant.selectLanguage.tr,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24.sp,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * .3,
                        child: ListView(
                          children: List.generate(localeList.length, (index) {
                            return InkWell(
                              onTap: () {
                                storageBox.write('languageCode',
                                    localeList[index].languageCode);
                                storageBox.write('countryCode',
                                    localeList[index].countryCode);
                                storageBox.write('languageIndex', index);
                                selectedLocale = localeList[index];
                                var locale = Locale(
                                    localeList[index].languageCode,
                                    localeList[index].countryCode);
                                Get.updateLocale(locale);
                                update();
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      localeList[index].name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.sp,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      localeList[index].flag,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20.sp,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  String? inAppWebService;
  String? notificationMenteeId, notificationFee;
}

class Language {
  final int id;
  final String name;
  final String flag;
  final String languageCode;
  final String countryCode;

  Language(this.id, this.name, this.flag, this.languageCode, this.countryCode);
}
