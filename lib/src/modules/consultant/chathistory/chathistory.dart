import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/modules/consultant/chathistory/get_repo.dart';
import 'package:consultant_product/src/modules/consultant/dashboard/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/home/get_repo.dart';
import 'package:consultant_product/src/modules/user/home/logic.dart';
// import 'package:consultant_product/src/modules/user/home/widgets/top_rated_consultant.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/notififcation_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import '../../../api_services/get_service.dart';
import '../../../controller/general_controller.dart';
import '../../chat/logic.dart';
import '../../chat/view.dart';
import '../../user/home/logic.dart';

class Chathistory extends StatefulWidget {
  const Chathistory({Key? key}) : super(key: key);

  @override
  _ChathistoryState createState() => _ChathistoryState();
}

class _ChathistoryState extends State<Chathistory> {
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

    // ///---featured-API-call
    // getMethod(context, getFeaturedURL, {'token': '123'}, false,
    //     getFeaturedConsultantRepo);

    // ///---categories-API-call
    // getMethod(
    //     context, getCategoriesURL, {'token': '123'}, false, getCategoriesRepo);

    ///---get-mentee-API-call
    getMethod(context, getAllUsersList, {'token': '123'}, false,
        getmenteeRepo);


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
      return GetBuilder<DashboardLogic>(builder: (_dashboardLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            body: NestedScrollView(
                controller: _dashboardLogic.scrollController,
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
                      backgroundColor: _dashboardLogic.isShrink
                          ? customThemeColor
                          : Colors.white,
                      // backgroundColor: customThemeColor,
                      leading: InkWell(
                        onTap: () {
                          Get.toNamed(PageRoutes.consultantDrawer);
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
                                    Text(LanguageConstant.chathistory.tr,
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
                 
                  //---top-rated-consultant
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(
                      //       15.w, 20.h, 15.w, 0.h),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         LanguageConstant.chat.tr + "s",
                      //         style: state.subHeadingTextStyle,
                      //       ),
                      //       // InkWell(
                      //       //   onTap: () {},
                      //       //   child: Text(
                      //       //     'View All',
                      //       //     style: state.viewAllTextStyle,
                      //       //   ),
                      //       // ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Center(
                        child: Wrap(
                          children: List.generate(
                              _dashboardLogic!.getmenteeList.length,
                              (index) {
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.w, 0.h, 15.w, 15.h),
                              child: InkWell(
                                onTap: () {
                                  var chatPageController = Get.put(ChatLogic());
                                  chatPageController.updateUserName(
                                      _dashboardLogic
                                              .getmenteeList[index]
                                              .firstName ??
                                          "");
                                  chatPageController.updateSenderMessageGetId(
                                      _dashboardLogic
                                              .getmenteeList[index]
                                              .id ??
                                          1);
                                  chatPageController.updateReceiverMessageGetId(
                                      Get.find<GeneralController>()
                                              .storageBox
                                              .read('userID') ??
                                          1);
                                  chatPageController.updateUserEmail(
                                      _dashboardLogic
                                          .getmenteeList[index].id
                                          .toString());
                                  chatPageController.updateUserImage(
                                      _dashboardLogic
                                              .getmenteeList[index]
                                              .imagePath ??
                                          "");

                                  Get.to(() => ChatPage());
                                },
                                child:
 
                                Container(
                                  height: 150.h,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: -2,
                                          blurRadius: 15,
                                          // offset: Offset(1,5)
                                        )
                                      ]),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        18.w, 12.h, 18.w, 12.h),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ///---profile-image
                                        Material(
                                          color: customLightThemeColor,
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          child: _dashboardLogic
                                                      .getmenteeList[
                                                          index]
                                                      .imagePath ==
                                                  null
                                              ? SizedBox(
                                                  width: 76.w,
                                                  height: 85.h,
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  child: Image.network(
                                                    _dashboardLogic
                                                            .getmenteeList[
                                                                index]
                                                            .imagePath!
                                                            .contains('assets')
                                                        ? '$mediaUrl/public/${_dashboardLogic.getmenteeList[index].imagePath}'
                                                        : '${_dashboardLogic.getmenteeList[index].imagePath}',
                                                    width: 35.w,
                                                    height: 30.h,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        object, trace) {
                                                      return SizedBox(
                                                        width: 35.w,
                                                        height: 25.h,
                                                        child: const Icon(
                                                          Icons.broken_image,
                                                          color: Colors.white,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                        ),
                                        SizedBox(
                                          width: 21.w,
                                        ),


                                           Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      const Spacer(),

                                                                      ///---title
                                                                      Text(
                                                                           _dashboardLogic.getmenteeList[index].firstName.toString( ) + " "+_dashboardLogic.getmenteeList[index].lastName.toString(),
                                                                              
                                                                          softWrap:
                                                                              true,
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          maxLines:
                                                                              1,
                                                                          style:
                                                                              TextStyle(fontSize: 12)
                                                                          //state.topTitleTextStyle!.copyWith(color: customTextBlackColor),
                                                                          ),
                                                                         
                                                                      // const Spacer(),
                                                                      // Text( '${_dashboardLogic.getmenteeList[index].onlineStatus.toString()}',
                                                                      //                softWrap:
                                                                      //         true,
                                                                      //     overflow: TextOverflow
                                                                      //         .ellipsis,
                                                                      //     maxLines:
                                                                      //         1,
                                                                      //     style:
                                                                      //         TextStyle(fontSize: 12)),
//  const Spacer(),
                                                                     
//                                                                      Wrap(children: [
//                                                                        for (int k =
//                                                                               0;
//                                                                           k < _userHomeLogic.getmenteeList[index].occupation!.length;
//                                                                           k++)
//                                                                         Text(
//                                                                           _userHomeLogic.getmenteeList[index]
//                                                                               .occupation![k]!
//                                                                           [0].name
//                                                                       .toString()+ " ",
//                                                                           softWrap:
//                                                                               true,
//                                                                           overflow:
//                                                                               TextOverflow.ellipsis,
//                                                                           style: state
//                                                                               .topSubTitleTextStyle!
//                                                                               .copyWith(color: customTextBlackColor),
//                                                                         ),]),
                                                                     
//                                                                       const Spacer(),
//                                                                      Wrap(children: [
//  for (int  r = 0; r<_userHomeLogic.getmenteeList[index].religion!.length; r++)
//                                                                           Text(
//                                                                           (_userHomeLogic.getmenteeList[index].religion![r]??'').toString()+" ",
                                                                              
//                                                                           softWrap:
//                                                                               true,
//                                                                           overflow: TextOverflow
//                                                                               .ellipsis,
//                                                                           maxLines:
//                                                                               1,
//                                                                           style:
//                                                                               TextStyle(fontSize: 10)
//                                                                           //state.topTitleTextStyle!.copyWith(color: customTextBlackColor),
//                                                                           ),
                                                                    
//                                                                      ],),
                                                                     
                                                                 
                                                                      ///---rating-bar
                                                                      // const Spacer(),
                                                                      // RatingBar
                                                                      //     .builder(
                                                                      //   ignoreGestures:
                                                                      //       true,
                                                                      //   initialRating:
                                                                      //       double.parse((_userHomeLogic.getmenteeList[index].description ?? 0).toString()),
                                                                      //   minRating:
                                                                      //       1,
                                                                      //   direction:
                                                                      //       Axis.horizontal,
                                                                      //   allowHalfRating:
                                                                      //       true,
                                                                      //   //itemCount: ,
                                                                      //   itemSize:
                                                                      //       15,
                                                                      //   itemPadding:
                                                                      //       const EdgeInsets.symmetric(horizontal: 0.0),
                                                                      //   itemBuilder:
                                                                      //       (context, _) =>
                                                                      //           SvgPicture.asset('assets/Icons/ratingStarIcon.svg'),
                                                                      //   onRatingUpdate:
                                                                      //       (rating) {},
                                                                      // ),
                                                                      const Spacer(),
                                                                      // SizedBox(
                                                                      //   height:
                                                                      //       6.h,
                                                                      // ),
                                                                      // Text(appointmenttypemodel!
                                                                      //     .data
                                                                      //     .data[
                                                                      //         index]
                                                                      //     .name[
                                                                      //         j]
                                                                      //         [
                                                                      //         0]
                                                                      //     .name!
                                                                      //     .name
                                                                         
                                                                      //     .toString()),
                                                                    ],
                                                                  ),
                                                                  //const Spacer(),


                                     
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
//_dashboardLogic.menteeLoader!
                          // ? const Center(
                          //     child: CircularProgressIndicator(
                          //       color: customThemeColor,
                          //     ),
                          //   )
                          // : _dashboardLogic.top
                          //             .currentPage! <
                          //         _dashboardLogic.data!
                          //             .topRatedMentors!.lastPage!
                          //     ? Center(
                          //         child: Padding(
                          //           padding: EdgeInsets.only(bottom: 30.h),
                          //           child: InkWell(
                          //             onTap: () {
                          //               _userHomeLogic
                          //                   .updateTopRatedLoaderMore(true);

                          //               ///---top-rated-API-call
                          //               getMethod(
                          //                   context,
                          //                   getAllConsultantList,
                          //                   {
                          //                     'token': '123',
                          //                     'page': _userHomeLogic
                          //                             .topRatedModel
                          //                             .data!
                          //                             .topRatedMentors!
                          //                             .currentPage! +
                          //                         1
                          //                   },
                          //                   false,
                          //                   getTopRatedConsultantMoreRepo);
                          //             },
                          //             child: Container(
                          //               height: 36.h,
                          //               width: 116.w,
                          //               decoration: BoxDecoration(
                          //                   color: Colors.white,
                          //                   border: Border.all(
                          //                       color: customThemeColor),
                          //                   borderRadius:
                          //                       BorderRadius.circular(18.r)),
                          //               child: Center(
                          //                 child: Text(
                          //                   LanguageConstant.loadMore.tr,
                          //                   style: TextStyle(
                          //                       fontFamily:
                          //                           SarabunFontFamily.medium,
                          //                       fontSize: 12.sp,
                          //                       color: customThemeColor),
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       )
                          //     : const SizedBox()
                    ],
                  )
                ])),
        
          
          
          ),
        );
      });
    });
  }
}
