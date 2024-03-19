import 'dart:async';

import 'package:consultant_product/src/modules/user/call/callpage.dart';
import 'package:consultant_product/src/modules/user/edit_user_profile/view.dart';
import 'package:consultant_product/src/modules/user/home/view.dart';
import 'package:consultant_product/src/modules/user/live/Live.dart';
import 'package:consultant_product/src/utils/colors.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../chatlist.dart';
import 'bottom_nav_controller.dart';

class BottomNavScreen extends StatefulWidget {
  final int pageIndex;
  BottomNavScreen({required this.pageIndex});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  var bottomBar = Get.put(() => BottomNavController());
  final int _pageIndex = 0;

  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;

  @override
  Widget build(BuildContext context) {
    Get.put(BottomNavController());
    // bool _isUserLoggedIn = Get.find<AuthController>().isLoggedIn();
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          Get.find<BottomNavController>().changePage(BnbItem.home);
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
          //Icon(Icons.live_tv_outlined,color: customLightThemeColor,),
          backgroundColor: Colors.white70,
          onPressed: () {
            var foo = Get.put(() => Live());
            Get.find<BottomNavController>().changePage(BnbItem.live);
            // showDialog(
            //
            //   context: context,
            //   barrierDismissible: false,
            //   builder: (BuildContext context) {
            //     return AlertDialog(
            //       insetPadding: EdgeInsets.symmetric(vertical: 50),
            //
            //
            //       content:  Container(height: 70,
            //         child: Column(mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //
            //             Row(children: [
            //               CircleAvatar(backgroundColor: customHintColor,radius: 15,child: Icon(Icons.graphic_eq_outlined),),
            //               SizedBox(width: 10,),
            //               Text("Go Live",style:TextStyle(color: Colors.black,) ,)
            //             ],),
            //             SizedBox(height: 10,),
            //             Row(children: [
            //               CircleAvatar(backgroundColor: customHintColor,radius: 15,child: Icon(Icons.upload_outlined),),
            //               SizedBox(width: 10,),
            //               Text("Upload a video",style:TextStyle(color: Colors.black,) ,)
            //             ],)
            //
            //
            //
            //           ],
            //         ),
            //       ),
            //
            //     );
            //   },
            // );
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
                // : Theme.of(context).customThemeColor,
                : customThemeColor,
            // : Colors.grey.withOpacity(0.001),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      var foo = Get.put(() => UserHomePage());
                      // await Get.find<HomeController>().getInit();
                      Get.find<BottomNavController>().changePage(BnbItem.home);
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
                      var foo = Get.put(() => Chatlist());
                      Get.find<BottomNavController>().changePage(BnbItem.chat);
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
                      Get.find<BottomNavController>().changePage(BnbItem.live);
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
                      var foo = Get.put(() => CallPage());
                      //  await Get.find<ProfileController>().getInit();
                      Get.find<BottomNavController>().changePage(BnbItem.call);
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
                      var foo = Get.put(() => EditUserProfilePage(
                            wannaShowBackButton: false,
                          ));
                      //  await Get.find<ProfileController>().getInit();
                      Get.find<BottomNavController>()
                          .changePage(BnbItem.profile);
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
                    color: Get.find<BottomNavController>().currentPage.value ==
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
    switch (Get.find<BottomNavController>().currentPage.value) {
      case BnbItem.home:
        return UserHomePage();
      case BnbItem.chat:
        return Chatlist();
      case BnbItem.live:
        return Live();
      case BnbItem.call:
        return CallPage();
      case BnbItem.profile:
        return EditUserProfilePage(
          wannaShowBackButton: false,
        );
    }
  }
}
