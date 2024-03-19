import 'dart:async';
import 'package:consultant_product/src/modules/consultant/callpage.dart';
import 'package:consultant_product/src/modules/consultant/chatlist.dart';
import 'package:consultant_product/src/modules/consultant/dashboard/view.dart';
// import 'package:consultant_product/src/modules/consultant/dashboard/view.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../constlive/Live.dart';
import '../edit_consultant_profile/view.dart';
import 'bottom_nav_controller.dart';

class BottomNavConsultantScreen extends StatefulWidget {
  BottomNavConsultantScreen({required this.pageIndex});

  final int pageIndex;

  @override
  State<BottomNavConsultantScreen> createState() =>
      _BottomNavConsultantScreenState();
}

class _BottomNavConsultantScreenState extends State<BottomNavConsultantScreen> {
  var bottomBar = Get.put(() => ConsultantBottomNavController());

  bool _canExit = GetPlatform.isWeb ? true : false;
  final int _pageIndex = 0;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  Widget _bnbItem(
      {required String icon,
      required BnbItem bnbItem,
      required GestureTapCallback onTap,
      context}) {
    return Obx(() => Expanded(
            child: InkWell(
          onTap: onTap,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            icon.isEmpty
                ? SizedBox(width: 20, height: 20)
                : Image.asset(
                    icon,
                    width: 18,
                    height: 18,
                    color: Get.find<ConsultantBottomNavController>()
                                .currentPage
                                .value ==
                            bnbItem
                        ? Colors.white
                        : Theme.of(context).secondaryHeaderColor,
                  ),
            SizedBox(height: 10),
            Text(
              bnbItem.name.toString(),
            ),
          ]),
        )));
  }

  _bottomNavigationView() {
    switch (Get.find<ConsultantBottomNavController>().currentPage.value) {
      case BnbItem.consthome:
        return ConsultantDashboardPage();
      case BnbItem.constchat:
        return ConsultantChatlist();
      case BnbItem.constlive:
        return Live();
      case BnbItem.constcall:
        return ConsultantCallPage();
      case BnbItem.constprofile:
        return EditConsultantProfilePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ConsultantBottomNavController());
    // bool _isUserLoggedIn = Get.find<AuthController>().isLoggedIn();
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          Get.find<ConsultantBottomNavController>()
              .changePage(BnbItem.consthome);
          return false;
        } else {
          if (_canExit) {
            return true;
          } else {
            Fluttertoast.showToast(
                msg: "Toast msg",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.black,
                fontSize: 16.0);
            _canExit = true;
            Timer(Duration(seconds: 2), () {
              _canExit = false;
            });
            return false;
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          // isExtended: true,
          child: Image.asset("assets/images/video.png"),
         // Icon(Icons.live_tv_outlined,color: customLightThemeColor,),
          backgroundColor: Colors.white70,
          onPressed: () {
            var foo = Get.put(() => Live());
            Get.find<ConsultantBottomNavController>().changePage(BnbItem.constlive);
          },
        ),

        bottomNavigationBar: SafeArea(
          child: Container(
            width: Get.width,
            height: 70,
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            color: Get.isDarkMode
                ? Theme.of(context).cardColor.withOpacity(.5)
                // : Theme.of(context).primaryColor,
                // : Colors.grey.withOpacity(0.001),

                : customThemeColor,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      var foo = Get.put(() => ConsultantDashboardPage());
                      // await Get.find<HomeController>().getInit();
                      Get.find<ConsultantBottomNavController>()
                          .changePage(BnbItem.consthome);
                    },
                    child: SizedBox(
                      width: Get.width / 5.4,
                      child: Column(
                        children: [
                          SizedBox(height: 8),
                          // Icon(
                          //   Icons.home,
                          //   size: 25,
                          //   color: customLightThemeColor,
                          // ),
                          Image.asset("assets/images/home.png"),
                          Align(
                            alignment: Alignment.center,
                            child: Text("Home",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      var foo = Get.put(() => ConsultantChatlist());
                      Get.find<ConsultantBottomNavController>()
                          .changePage(BnbItem.constchat);
                    },
                    child: SizedBox(
                      width: Get.width / 5.4,
                      child: Column(
                        children: [
                          SizedBox(height: 8),
                          // Icon(
                          //   Icons.chat,
                          //   size: 25,
                          //   color: customLightThemeColor,
                          // ),

                          Image.asset("assets/images/messages.png"),
                          Align(
                            alignment: Alignment.center,
                            child: Text("Chat",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      var foo = Get.put(() => Live());
                      Get.find<ConsultantBottomNavController>().changePage(BnbItem.constlive);

                      // var foo = Get.put(() => ConsultantChatlist());
                      // Get.find<ConsultantBottomNavController>().changePage(BnbItem.constchat);
                    },
                    child: SizedBox(
                      width: Get.width / 5.4,
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 15,),

                        Align(
                        alignment: Alignment.center,
                        child:  Text("Live",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ))),
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () async {
                      var foo = Get.put(() => ConsultantCallPage());
                      //  await Get.find<ProfileController>().getInit();
                      Get.find<ConsultantBottomNavController>()
                          .changePage(BnbItem.constcall);
                    },
                    child: SizedBox(
                      width: Get.width / 5.4,
                      child: Column(
                        children: [
                          SizedBox(height: 8),
                          // Icon(
                          //   Icons.call,
                          //   size: 25,
                          //   color: customLightThemeColor,
                          // ),

                          Image.asset("assets/images/call.png"),
                          Align(
                            alignment: Alignment.center,
                            child: Text("Call",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      var foo = Get.put(() => EditConsultantProfilePage());
                      //  await Get.find<ProfileController>().getInit();
                      Get.find<ConsultantBottomNavController>()
                          .changePage(BnbItem.constprofile);
                    },
                    child: SizedBox(
                      width: Get.width / 5.4,
                      child: Column(
                        children: [
                          SizedBox(height: 8),
                          // Icon(
                          //   Icons.person,
                          //   size: 25,
                          //   color: customLightThemeColor,
                          // ),

                          Image.asset("assets/images/profile.png"),
                          Align(
                            alignment: Alignment.center,
                            child: Text("Profile",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        ),
        body: Obx(() => _bottomNavigationView()),
      ),
    );
  }

  // Widget _bnbItem(
  //     {required String icon,
  //       required BnbItem bnbItem,
  //       required GestureTapCallback onTap,
  //       context}) {
  //   return Obx(() => Expanded(
  //       child: InkWell(
  //         onTap: onTap,
  //         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
  //           icon.isEmpty
  //               ? SizedBox(width: 20, height: 20)
  //               : Image.asset(
  //             icon,
  //             width: 18,
  //             height: 18,
  //             color: Get.find<ConsultantBottomNavController>().currentPage.value ==
  //                 bnbItem
  //                 ? Colors.white
  //                 : Theme.of(context).secondaryHeaderColor,
  //           ),
  //           SizedBox(height: 10),
  //           Text(
  //             bnbItem.name.toString(),
  //           ),
  //         ]),
  //       )));
  // }
  //
  // _bottomNavigationView() {
  //   switch (Get.find<ConsultantBottomNavController>().currentPage.value) {
  //     case BnbItem.consthome:
  //       return ConsultantDashboardPage();
  //     case BnbItem.constchat:
  //       return ConsultantChatlist();
  //     case BnbItem.constcall:
  //       return ConsultantCallPage();
  //     case BnbItem.constprofile:
  //       return EditConsultantProfilePage(showtrue: false,);
  //   }
  }
