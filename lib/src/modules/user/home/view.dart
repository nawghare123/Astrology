import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/KundaliPages/KundaliPage.dart';
import 'package:consultant_product/src/modules/user/home/get_repo.dart';
import 'package:consultant_product/src/modules/user/home/widgets/categories.dart';
import 'package:consultant_product/src/modules/user/home/widgets/top_consultants.dart';
import 'package:consultant_product/src/modules/user/home/widgets/top_rated_consultant.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/notififcation_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'logic.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final logic = Get.put(UserHomeLogic());

  final state = Get.find<UserHomeLogic>().state;

  @override
  void initState() {
    super.initState();
    if (Get.find<GeneralController>().storageBox.hasData('userID')) {
      Get.find<GeneralController>().updateFcmToken(context);

      ///---get-user-API-call
      getMethod(
          context,
          getMenteeProfileUrl,
          {
            'token': '123',
            'user_id': Get.find<GeneralController>().storageBox.read('userID')
          },
          true,
          getUserProfileRepo);
    }

    ///---featured-API-call
    getMethod(context, getFeaturedURL, {'token': '123'}, false,
        getFeaturedConsultantRepo);

    ///---categories-API-call
    getMethod(
        context, getCategoriesURL, {'token': '123'}, false, getCategoriesRepo);

    ///---top-rated-API-call
    getMethod(context, getTopRatedConsultantURL, {'token': '123'}, false,
        getTopRatedConsultantRepo);

    Get.find<UserHomeLogic>().scrollController = ScrollController()
      ..addListener(Get.find<UserHomeLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<UserHomeLogic>()
        .scrollController!
        .removeListener(Get.find<UserHomeLogic>().scrollListener);
    Get.find<UserHomeLogic>().scrollController!.dispose();
    super.dispose();
  }

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
                                    Text(
                                      LanguageConstant.findYour.tr,
                                      style: TextStyle(
                                          fontFamily: SarabunFontFamily.medium,
                                          fontSize: 17.sp,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(LanguageConstant.mentor.tr,
                                        style: state.headingTextStyle),
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
                body:
                    ListView(padding: const EdgeInsets.only(top: 0), children: [
                  ///kundali
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => KundaliPages());
                    },
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.w, 10.h, 15.w, 0.h),
                      child: Container(
                        height: 126.h,
                        width: 232.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/horoscope.jpg"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(9.r),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(15.w, 15.h, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Kundali',
                                style: state.topTitleTextStyle,
                              ),
                              const Spacer(),

                              ///---arrow-icon
                              SvgPicture.asset(
                                'assets/Icons/whiteForwardIcon.svg',
                                width: 29.w,
                                height: 29.h,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  ///---top-consultants
                  TopConsultants(),

                  ///---categories
                  CategoriesWidget(),

                  ///---top-rated-consultant
                  TopRatedConsultants(),
                ])),
          ),
        );
      });
    });
  }
}
