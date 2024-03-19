import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/modules/user/KundaliPages/matchmaking.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/notififcation_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:resize/resize.dart';

import '../../../controller/general_controller.dart';
import '../../../utils/colors.dart';
import '../home/logic.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';

import 'Panchangview.dart';


class KundaliPages extends StatefulWidget {
  const KundaliPages({Key? key}) : super(key: key);

  @override
  _KundaliPagesState createState() => _KundaliPagesState();
}

class _KundaliPagesState extends State<KundaliPages> {
  final logic = Get.put(UserHomeLogic());
  final state = Get.find<UserHomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<UserHomeLogic>(builder: (_userHomeLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            body: NestedScrollView(
                controller: _userHomeLogic.scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height * .35,
                      floating: true,
                      pinned: true,
                      snap: false,
                      elevation: 0,
                      backgroundColor: _userHomeLogic.isShrink
                          ? customThemeColor
                          : Colors.white,
                      // backgroundColor: customThemeColor,
                      leading: InkWell(
                        onTap: () {
                          Get.toNamed(PageRoutes.userDrawer);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/Icons/drawerIcon.svg'),
                          ],
                        ),
                      ),
                      actions: const [
                        ///---notifications
                        CustomNotificationIcon()
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: Stack(
                          children: [
                            SvgPicture.asset(
                              'assets/images/homeBackground.svg',
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .4,
                              fit: BoxFit.fill,
                            ),
                            SafeArea(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.w, 20.h, 16.w, 16.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 50.h,
                                    ),
                                    // Text(
                                    //   LanguageConstant.findYour.tr,
                                    //   style: TextStyle(
                                    //       fontFamily: SarabunFontFamily.medium,
                                    //       fontSize: 17.sp,
                                    //       color: Colors.black),
                                    // ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(LanguageConstant.kundali.tr,
                                        style: state.headingTextStyle
                                        ),
                                    SizedBox(
                                      height: 20.h,
                                    ),

                                    ///---search-field
                                    TextFormField(
                                      onTap: () {
                                        Get.toNamed(
                                            PageRoutes.searchConsultant);
                                      },
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            25.w, 15.h, 25.w, 15.h),
                                        suffixIcon: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                'assets/Icons/searchIcon.svg'),
                                          ],
                                        ),
                                        hintText:
                                        LanguageConstant.searchHere.tr,
                                        hintStyle: const TextStyle(
                                            fontFamily:
                                            SarabunFontFamily.medium,
                                            fontSize: 14,
                                            color: Color(0xffA3A7AA)),
                                        fillColor: customTextFieldColor,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(22.r),
                                            borderSide: const BorderSide(
                                                color: Colors.transparent)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(22.r),
                                            borderSide: const BorderSide(
                                                color: Colors.transparent)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(22.r),
                                            borderSide: const BorderSide(
                                                color: customLightThemeColor)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(22.r),
                                            borderSide: const BorderSide(
                                                color: Colors.red)),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return LanguageConstant
                                              .fieldRequired.tr;
                                        } else if (!GetUtils.isEmail(value)) {
                                          return LanguageConstant
                                              .enterValidEmail.tr;
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: ListView(
                    padding: EdgeInsetsDirectional.fromSTEB(15.w, 10.h, 15.w, 0.h),
                    children:  [
                      GridView(
                        physics:
                        NeverScrollableScrollPhysics(),
                        scrollDirection:
                        Axis.vertical,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                            2,
                            crossAxisSpacing:
                            8,
                            mainAxisSpacing:
                            5,
                            mainAxisExtent:
                            120),
                        children: [


                          InkWell(onTap: (){

                          },child: Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 120.h,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/panchang.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                  color: customHintColor,
                                  borderRadius: BorderRadius.all(Radius.circular(15)

                                  ),
                                ),
                                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Text(LanguageConstant.kundali.tr,
                                    ),                                  ],
                                ),
                              ),



                            ],
                          )),
                          InkWell(onTap: (){

                          },child: Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 120.h,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/horoscope.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                  color: customHintColor,
                                  borderRadius: BorderRadius.all(Radius.circular(15)

                                  ),
                                ),
                                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Text(LanguageConstant.horoscope.tr,

                                    ),                                  ],
                                ),
                              ),



                            ],
                          )),
                          InkWell(onTap: (){
Get.to(()=> PanchangeView());
                          },child: Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 120.h,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/horo3.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                  color: customHintColor,
                                  borderRadius: BorderRadius.all(Radius.circular(15)
                                  ///horo.jpg
                                  ),
                                ),
                                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Text(LanguageConstant.panchang.tr,
                                    ),                                  ],
                                ),
                              ),



                            ],
                          )),
                          InkWell(onTap: (){
Get.to(()=> MatchMakingPage());
                          },child: Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 120.h,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/horo1.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                  color: customHintColor,
                                  borderRadius: BorderRadius.all(Radius.circular(15)

                                  ),
                                ),
                                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Text(LanguageConstant.matchmaking.tr,
                                    ),                                  ],
                                ),
                              ),



                            ],
                          )),






                        ],
                        padding:
                        EdgeInsets.all(
                            5),
                        shrinkWrap: true,
                      ),
                    ])),
          ),
        );
      });
    });
  }

}
