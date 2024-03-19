import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/bottomNav/bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.dart';

class UserDrawerLogic extends GetxController {
  final UserDrawerState state = UserDrawerState();

  List<DrawerTile> drawerLoginList = [
    DrawerTile(
        title: LanguageConstant.home.tr,
        icon: 'assets/Icons/drawerHomeIcon.svg'),
    DrawerTile(
        title: LanguageConstant.categories.tr,
        icon: 'assets/Icons/drawerCategoryIcon.svg'),
    DrawerTile(
        title: LanguageConstant.appointmentLogs.tr,
        icon: 'assets/Icons/drawerAppointmentIcon.svg'),
    DrawerTile(
        title: LanguageConstant.chathistory.tr,
        icon: 'assets/Icons/messagetime.svg'),
    DrawerTile(
        title: LanguageConstant.editProfile.tr,
        icon: 'assets/Icons/editProfile.svg'),
    DrawerTile(title: 'My Wallet', icon: 'assets/Icons/wallet.svg'),
    DrawerTile(
        title: LanguageConstant.customersupport.tr,
        icon: 'assets/Icons/drawerContactUsIcon.svg'),
    DrawerTile(
        title: LanguageConstant.blogs.tr,
        icon: 'assets/Icons/drawerBlogIcon.svg'),
    DrawerTile(
        title: LanguageConstant.aboutUs.tr,
        icon: 'assets/Icons/drawerPrivacyIcon.svg'),
    DrawerTile(
        title: 'Languages',
        icon: 'assets/Icons/language.svg'),
    DrawerTile(
        title: LanguageConstant.logout.tr,
        icon: 'assets/Icons/drawerLogoutIcon.svg'),
  ];
  List<DrawerTile> drawerList = [
    DrawerTile(
        title: LanguageConstant.home.tr,
        icon: 'assets/Icons/drawerHomeIcon.svg'),
    DrawerTile(
        title: LanguageConstant.categories.tr,
        icon: 'assets/Icons/drawerCategoryIcon.svg'),
    DrawerTile(
        title: LanguageConstant.customersupport.tr,
        icon: 'assets/Icons/drawerContactUsIcon.svg'),
    DrawerTile(
        title: LanguageConstant.blogs.tr,
        icon: 'assets/Icons/drawerBlogIcon.svg'),
    DrawerTile(
        title: LanguageConstant.aboutUs.tr,
        icon: 'assets/Icons/drawerPrivacyIcon.svg'),
    DrawerTile(
        title: 'Languages',
        icon: 'assets/Icons/language.svg'),
  ];

  userLoginDrawerNavigation(
      int? index,
      BuildContext context,
      ) {
    switch (index) {
      case 0:
        {
          // return Get.back();
          // return Get.offAllNamed(PageRoutes.userHome);
          return Get.to(BottomNavScreen(pageIndex:0));
        }
      case 1:
        {
          Get.back();
          return Get.toNamed(PageRoutes.allConsultants);
        }
      case 2:
        {
          Get.back();
          return Get.toNamed(PageRoutes.myAppointment);
        }
      case 3:
        {
          Get.back();
          return Get.toNamed(PageRoutes.chathistoryuser);
        }
      case 4:
        {
          Get.back();
          return Get.toNamed(PageRoutes.editUserProfile);
        }
      case 5:
        {
          Get.back();
          return Get.toNamed(PageRoutes.walletScreen);
        }

      case 6:
        {
          Get.back();
          return Get.toNamed(PageRoutes.contactUs);
        }
      case 7:
        {
          Get.back();
          return Get.toNamed(PageRoutes.blogs);
        }
      case 8:
        {
          Get.back();
          return Get.toNamed(PageRoutes.aboutUs);
        }
      case 9:
        {
          return Get.find<GeneralController>().customDropDownDialogForLocale(context);
        }
      case 10:
        {
          Get.find<GeneralController>()
              .storageBox
              .remove('userID');
          Get.find<GeneralController>()
              .storageBox
              .remove('authToken');
          Get.find<GeneralController>()
              .storageBox
              .remove('onlineStatus');
          Get.find<GeneralController>()
              .storageBox
              .remove('userRole');
          Get.find<GeneralController>()
              .storageBox
              .remove('fcmToken');

          return Get.offAllNamed(PageRoutes.userHome);
        }
      default:
        {
          return Scaffold(
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          );
        }
    }
  }

  userDrawerNavigation(
      int? index,
      BuildContext context,
      ) {
    switch (index) {
      case 0:
        {
          return Get.back();
        }
      case 1:
        {
          Get.back();
          return Get.toNamed(PageRoutes.allConsultants);
        }
      case 2:
        {
          Get.back();
          return Get.toNamed(PageRoutes.contactUs);
        }
      case 3:
        {
          Get.back();
          return Get.toNamed(PageRoutes.blogs);
        }
      case 4:
        {
          Get.back();
          return Get.toNamed(PageRoutes.aboutUs);
        }
      case 5:
        {
          return Get.find<GeneralController>().customDropDownDialogForLocale(context);
        }
      default:
        {
          return Scaffold(
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          );
        }
    }
  }
}

class DrawerTile {
  DrawerTile({required this.title, required this.icon});

  final String? title;
  final String? icon;
}
