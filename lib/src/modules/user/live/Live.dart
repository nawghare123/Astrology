import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/modules/agora_call/agora_logic.dart';
import 'package:consultant_product/src/modules/agora_call/repo.dart';
import 'package:consultant_product/src/modules/consultant/consultant_appointment_detail/logic.dart';
import 'package:consultant_product/src/modules/user/appointment/AppointmenttypeModel.dart';
import 'package:consultant_product/src/modules/user/appointment/appointmentclass.dart';
import 'package:consultant_product/src/modules/user/home/widgets/categories.dart';
import 'package:flutter/material.dart';
import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/home/get_repo.dart';
import 'package:consultant_product/src/modules/user/home/logic.dart';
import 'package:consultant_product/src/modules/user/home/widgets/top_rated_consultant.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/notififcation_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

class Live extends StatefulWidget {
  const Live({Key? key}) : super(key: key);

  @override
  _LiveState createState() => _LiveState();
}

class _LiveState extends State<Live> {
  final logic = Get.put(UserHomeLogic());
  bool isloading = false;
  final state = Get.find<UserHomeLogic>().state;
  AppointmenttypeModel? appointmenttypemodel;

  @override
  void initState() {
    super.initState();
    setState(() {
      isloading = true;
    });
    appointmenttype();
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

    // ///---top-rated-API-call
    // getMethod(context, getTopRatedConsultantURL, {'token': '123'}, false,
    //     getTopRatedConsultantRepo);

    Get.find<UserHomeLogic>().scrollController = ScrollController()
      ..addListener(Get.find<UserHomeLogic>().scrollListener);
  }

  @override
  void appointmenttype() async {
    appointmenttypemodel = await ApiHelper.appointmenttypeclass();

    setState(() {
      isloading = false;
    });
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
                                    Text(LanguageConstant.watchlive.tr,
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
                body: !isloading
                    ? ListView(
                        padding: const EdgeInsets.only(top: 0),
                        children: [
                            // ///---top-consultants
                            // TopConsultants(),
                            ///---categories
                            CategoriesWidget(),

                            // ///---top-rated-consultant

                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Padding(
                                //   padding: EdgeInsetsDirectional.fromSTEB(15.w, 20.h, 15.w, 0.h),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       // Text(
                                //       //   LanguageConstant.topRatedConsultant.tr,
                                //       //   style: state.subHeadingTextStyle,
                                //       // ),
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
                                // appointmenttypemodel!.data.data.isNotEmpty?
                                Center(
                                  child: Wrap(
                                    children: List.generate(
                                        appointmenttypemodel!.data!.data!.length,
                                        (index) {
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.w, 0.h, 15.w, 15.h),
                                        child: InkWell(
                                          onTap: () {
//                                             final logic = Get.put(ConsultantAppointmentDetailLogic());
// final state = Get.find<ConsultantAppointmentDetailLogic>().state;
// logic.audioOnTap(context);

Get.find<AgoraLogic>().userName =
                                                '${appointmenttypemodel!.data!.data![index].firstName} ${appointmenttypemodel!.data!.data![index].lastName}';
                                            Get.find<AgoraLogic>().userImage =
                                                "${appointmenttypemodel!.data!.data![index].imagePath}";
                                            Get.find<AgoraLogic>().update();
                                            Get.find<GeneralController>()
                                                .updateSelectedChannel(Get.find<
                                                        GeneralController>()
                                                    .getRandomString(10));
                                            Get.find<GeneralController>()
                                                .updateChannelForCall(Get.find<
                                                        GeneralController>()
                                                    .selectedChannel);
                                            Get.find<GeneralController>()
                                                .updateUserIdForSendNotification(
                                                    appointmenttypemodel!.data!
                                                        .data![index].userId);
                                            getMethod(
                                                context,
                                                agoraTokenUrl,
                                                {
                                                  'token': '123',
                                                  'channel': Get.find<
                                                          GeneralController>()
                                                      .selectedChannel
                                                },
                                                true,
                                                getAgoraTokenRepo);
                                            Get.find<GeneralController>()
                                                .updateGoForCall(true);
                                            Get.toNamed(
                                                PageRoutes.videoCallWaiting);











                                            // _userHomeLogic
                                            //         .selectedConsultantID =
                                            //     appointmenttypemodel!
                                            //         .data!.data![index].userId;
                                            // _userHomeLogic
                                            //         .selectedConsultantName =
                                            //     '${appointmenttypemodel!.data!.data![index].firstName ?? ''}';
                                            // _userHomeLogic.update();
                                            // Get.toNamed(PageRoutes
                                            //     .consultantProfileForUser);
                                          },
                                          child: Column(
                                            children: [
                                              for (int j = 0;
                                                  j <
                                                      appointmenttypemodel!
                                                          .data!
                                                          .data![index]
                                                          .appointmentTypeId!
                                                          .length;
                                                  j++)

                                                Column(
                                                  children: [
                                                   
                                                    (appointmenttypemodel!
                                                                  .data!.data![index].appointmentTypeId![j][0].name
                                                  
                                                                  .toString() ==
                                                            "video")
                                                        ?
                                                        // appointmenttypemodel!
                                                        //         .data
                                                        //         .data[index]
                                                        //         .name[j]
                                                        //         .contains(
                                                        //             appointmenttypemodel!
                                                        //                 .data
                                                        //                 .data[
                                                        //                     index]
                                                        //                 .name[j])
                                                        //     ?
                                                        Container(
                                                            height: 150.h,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.r),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.2),
                                                                    spreadRadius:
                                                                        -2,
                                                                    blurRadius:
                                                                        15,
                                                                    // offset: Offset(1,5)
                                                                  )
                                                                ]),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          18.w,
                                                                          12.h,
                                                                          18.w,
                                                                          12.h),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  ///---profile-image
                                                                  Material(
                                                                    color:
                                                                        customLightThemeColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.r),
                                                                    child: appointmenttypemodel!.data!.data![index].imagePath ==
                                                                            null
                                                                        ? SizedBox(
                                                                            width:
                                                                                76.w,
                                                                            height:
                                                                                85.h,
                                                                          )
                                                                        : ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.r),
                                                                            child:
                                                                                Image.network(
                                                                              "https://astro.hirectjob.in/public/" + appointmenttypemodel!.data!.data![index].imagePath.toString(),
                                                                              // _userHomeLogic.topRatedConsultantList[index].image!.contains('assets')

                                                                              //     ? '$mediaUrl${_userHomeLogic.topRatedConsultantList[index].image}'
                                                                              //     : '${_userHomeLogic.topRatedConsultantList[index].image}',
                                                                              width: 76.w,
                                                                              height: 85.h,
                                                                              fit: BoxFit.cover,
                                                                              errorBuilder: (context, object, trace) {
                                                                                return SizedBox(
                                                                                  width: 76.w,
                                                                                  height: 85.h,
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
                                                                      SizedBox(
                                                                        height:
                                                                            6.h,
                                                                      ),

                                                                      ///---title
                                                                      Text(
                                                                          (appointmenttypemodel!.data!.data![index].firstName!.toUpperCase()??''),
                                                                              
                                                                          softWrap:
                                                                              true,
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          maxLines:
                                                                              1,
                                                                          style:
                                                                              TextStyle(fontSize: 10)
                                                                          //state.topTitleTextStyle!.copyWith(color: customTextBlackColor),
                                                                          ),
                                                                         
                                                                      const Spacer(),
                                                                      Text(((((appointmenttypemodel!
                                                                              .data!
                                                                               .data![index].from!.difference(appointmenttypemodel!
                                                                              .data!
                                                                               .data![index].to!).inDays ~/30) % 12) / 3).toInt() .toString()) + " months " + ((appointmenttypemodel!
                                                                              .data!
                                                                               .data![index].from!.difference(appointmenttypemodel!
                                                                              .data!
                                                                               .data![index].to!).inDays ~/30) ~/ 12).toString() + " years",
                                                                                     softWrap:
                                                                              true,
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          maxLines:
                                                                              1,
                                                                          style:
                                                                              TextStyle(fontSize: 12)),
 const Spacer(),
                                                                     
                                                                     Wrap(children: [
                                                                       for (int k =
                                                                              0;
                                                                          k < appointmenttypemodel!.data!.data![index].occupation!.length;
                                                                          k++)
                                                                        Text(
                                                                          appointmenttypemodel!
                                                                              .data!
                                                                              .data![index]
                                                                              .occupation![k]!
                                                                          [0].name
                                                                      .toString()+ " ",
                                                                          softWrap:
                                                                              true,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: state
                                                                              .topSubTitleTextStyle!
                                                                              .copyWith(color: customTextBlackColor),
                                                                        ),]),
                                                                     
                                                                      const Spacer(),
                                                                     Wrap(children: [
 for (int  r = 0; r<appointmenttypemodel!.data!.data![index].religion!.length; r++)
                                                                          Text(
                                                                          (appointmenttypemodel!.data!.data![index].religion![r]??'').toString()+" ",
                                                                              
                                                                          softWrap:
                                                                              true,
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          maxLines:
                                                                              1,
                                                                          style:
                                                                              TextStyle(fontSize: 10)
                                                                          //state.topTitleTextStyle!.copyWith(color: customTextBlackColor),
                                                                          ),
                                                                    
                                                                     ],),
                                                                     
                                                                 
                                                                      ///---rating-bar
                                                                      const Spacer(),
                                                                      RatingBar
                                                                          .builder(
                                                                        ignoreGestures:
                                                                            true,
                                                                        initialRating:
                                                                            double.parse((appointmenttypemodel!.data!.data![index].description ?? 0).toString()),
                                                                        minRating:
                                                                            1,
                                                                        direction:
                                                                            Axis.horizontal,
                                                                        allowHalfRating:
                                                                            true,
                                                                        //itemCount: ,
                                                                        itemSize:
                                                                            15,
                                                                        itemPadding:
                                                                            const EdgeInsets.symmetric(horizontal: 0.0),
                                                                        itemBuilder:
                                                                            (context, _) =>
                                                                                SvgPicture.asset('assets/Icons/ratingStarIcon.svg'),
                                                                        onRatingUpdate:
                                                                            (rating) {},
                                                                      ),
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
                                                                  const Spacer(),


                                                                  Column(
                                                                    children: [

                                                                     
                                                                      ///---sub-title

                                                                      Text(
                                                                        appointmenttypemodel!.data!.data![index].onlineStatus ??
                                                                            '',
                                                                        softWrap:
                                                                            true,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: state
                                                                            .topSubTitleTextStyle!
                                                                            .copyWith(color: (appointmenttypemodel!.data!.data![index].onlineStatus == "online") ? Colors.green : Colors.red),
                                                                      ),

                                                                       SizedBox(
                                                                        height:
                                                                            3.h,
                                                                      ),

                                                                      Container(
                                                                        height:
                                                                            30.h,
                                                                        width: 50.w,
                                                                        child: Center(
                                                                            child: Text(
                                                                          
                                                                                  //AppointmentTypeStringEnum
                                                                                  (appointmenttypemodel!
                                                                      .data!.data![index].appointmentTypeId![j][0].name
                                                  
                                                                      .toString() ==
                                                              "video")
                                                                              ? "Live"
                                                                              : "",
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  12),
                                                                        )),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          border: Border.all(
                                                                              color:
                                                                                  Colors.yellow),
                                                                          color: Colors
                                                                              .yellow,
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                                  15),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  // SvgPicture.asset(
                                                                  //   'assets/Icons/forwardBlueIcon.svg',
                                                                  //   width: 29.w,
                                                                  //   height: 29.h,
                                                                  // )
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        // : SizedBox()
                                                        : SizedBox(),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                                //   : SizedBox(),
                                SizedBox(
                                  height: 25.h,
                                ),
                         
                              ],
                            )
                          
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     // Padding(
                            //     //   padding: EdgeInsetsDirectional.fromSTEB(15.w, 20.h, 15.w, 0.h),
                            //     //   child: Row(
                            //     //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     //     children: [
                            //     //       // Text(
                            //     //       //   LanguageConstant.topRatedConsultant.tr,
                            //     //       //   style: state.subHeadingTextStyle,
                            //     //       // ),
                            //     //       // InkWell(
                            //     //       //   onTap: () {},
                            //     //       //   child: Text(
                            //     //       //     'View All',
                            //     //       //     style: state.viewAllTextStyle,
                            //     //       //   ),
                            //     //       // ),
                            //     //     ],
                            //     //   ),
                            //     // ),
                            //     SizedBox(
                            //       height: 25.h,
                            //     ),
                            //     // appointmenttypemodel!.data.data.isNotEmpty?
                            //     Center(
                            //       child: Wrap(
                            //         children: List.generate(
                            //             appointmenttypemodel!.data.data.length,
                            //             (index) {
                            //           return Padding(
                            //             padding: EdgeInsetsDirectional.fromSTEB(
                            //                 15.w, 0.h, 15.w, 15.h),
                            //             child: InkWell(
                            //               onTap: () {
                            //                 _userHomeLogic
                            //                         .selectedConsultantID =
                            //                     appointmenttypemodel!
                            //                         .data.data[index].userId;
                            //                 _userHomeLogic
                            //                         .selectedConsultantName =
                            //                     '${appointmenttypemodel!.data.data[index].firstName ?? ''}';
                            //                 _userHomeLogic.update();
                            //                 Get.toNamed(PageRoutes
                            //                     .consultantProfileForUser);
                            //               },
                            //               child: Column(
                            //                 children: [
                            //                   for (int j = 0;
                            //                       j <
                            //                           appointmenttypemodel!
                            //                               .data
                            //                               .data[index]
                            //                               .name!
                            //                               .length;
                            //                       j++)
                            //                     // (appointmenttypemodel!.data!.data![index].appointmentTypeString!.where((element) => element.appointmentTypeString.name.toString())  == "video") ?
                            //                     Column(
                            //                       children: [
                            //                         ((appointmenttypemodel!
                            //                                     .data
                            //                                     .data[index]
                            //                                     .name![
                            //                                         j]
                            //                                     .name) ==
                            //                               "video")
                            //                             ? Container(
                            //                                 height: 109.h,
                            //                                 width:
                            //                                     MediaQuery.of(
                            //                                             context)
                            //                                         .size
                            //                                         .width,
                            //                                 decoration: BoxDecoration(
                            //                                     color: Colors
                            //                                         .white,
                            //                                     borderRadius:
                            //                                         BorderRadius
                            //                                             .circular(
                            //                                                 8.r),
                            //                                     boxShadow: [
                            //                                       BoxShadow(
                            //                                         color: Colors
                            //                                             .grey
                            //                                             .withOpacity(
                            //                                                 0.2),
                            //                                         spreadRadius:
                            //                                             -2,
                            //                                         blurRadius:
                            //                                             15,
                            //                                         // offset: Offset(1,5)
                            //                                       )
                            //                                     ]),
                            //                                 child: Padding(
                            //                                   padding:
                            //                                       EdgeInsetsDirectional
                            //                                           .fromSTEB(
                            //                                               18.w,
                            //                                               12.h,
                            //                                               18.w,
                            //                                               12.h),
                            //                                   child: Row(
                            //                                     crossAxisAlignment:
                            //                                         CrossAxisAlignment
                            //                                             .center,
                            //                                     children: [
                            //                                       ///---profile-image
                            //                                       Material(
                            //                                         color:
                            //                                             customLightThemeColor,
                            //                                         borderRadius:
                            //                                             BorderRadius.circular(
                            //                                                 8.r),
                            //                                         child: appointmenttypemodel!.data.data[index].imagePath ==
                            //                                                 null
                            //                                             ? SizedBox(
                            //                                                 width:
                            //                                                     76.w,
                            //                                                 height:
                            //                                                     85.h,
                            //                                               )
                            //                                             : ClipRRect(
                            //                                                 borderRadius:
                            //                                                     BorderRadius.circular(8.r),
                            //                                                 child:
                            //                                                     Image.network(
                            //                                                   "https://astro.hirectjob.in/public/" + appointmenttypemodel!.data.data[index].imagePath.toString(),
                            //                                                   // _userHomeLogic.topRatedConsultantList[index].image!.contains('assets')

                            //                                                   //     ? '$mediaUrl${_userHomeLogic.topRatedConsultantList[index].image}'
                            //                                                   //     : '${_userHomeLogic.topRatedConsultantList[index].image}',
                            //                                                   width: 76.w,
                            //                                                   height: 85.h,
                            //                                                   fit: BoxFit.cover,
                            //                                                   errorBuilder: (context, object, trace) {
                            //                                                     return SizedBox(
                            //                                                       width: 76.w,
                            //                                                       height: 85.h,
                            //                                                       child: const Icon(
                            //                                                         Icons.broken_image,
                            //                                                         color: Colors.white,
                            //                                                       ),
                            //                                                     );
                            //                                                   },
                            //                                                 ),
                            //                                               ),
                            //                                       ),
                            //                                       SizedBox(
                            //                                         width: 21.w,
                            //                                       ),
                            //                                       Column(
                            //                                         mainAxisAlignment:
                            //                                             MainAxisAlignment
                            //                                                 .start,
                            //                                         crossAxisAlignment:
                            //                                             CrossAxisAlignment
                            //                                                 .start,
                            //                                         children: [
                            //                                           SizedBox(
                            //                                             height:
                            //                                                 6.h,
                            //                                           ),

                            //                                           ///---title
                            //                                           Text(
                            //                                               (appointmenttypemodel!.data.data[index].firstName ?? '')
                            //                                                   .toString(),
                            //                                               softWrap:
                            //                                                   true,
                            //                                               overflow: TextOverflow
                            //                                                   .ellipsis,
                            //                                               maxLines:
                            //                                                   1,
                            //                                               style:
                            //                                                   TextStyle(fontSize: 10)
                            //                                               //state.topTitleTextStyle!.copyWith(color: customTextBlackColor),
                            //                                               ),
                            //                                           SizedBox(
                            //                                             height:
                            //                                                 5.h,
                            //                                           ),

                            //                                           ///---sub-title
                            //                                           // Text(
                            //                                           //   appointmenttypemodel!.data!.data[index].category!.name??'',
                            //                                           //   softWrap: true,
                            //                                           //   overflow: TextOverflow.ellipsis,
                            //                                           //   style: state.topSubTitleTextStyle!.copyWith(color: customTextBlackColor),
                            //                                           // ),
                            //                                           // const Spacer(),

                            //                                           ///---rating-bar
                            //                                           // RatingBar
                            //                                           //     .builder(
                            //                                           //   ignoreGestures:
                            //                                           //       true,
                            //                                           //   initialRating:
                            //                                           //       double.parse((appointmenttypemodel!.data.data![index].ratingCount ?? 0).toString()),
                            //                                           //   minRating:
                            //                                           //       1,
                            //                                           //   direction:
                            //                                           //       Axis.horizontal,
                            //                                           //   allowHalfRating:
                            //                                           //       true,
                            //                                           //   //itemCount: ,
                            //                                           //   itemSize:
                            //                                           //       15,
                            //                                           //   itemPadding:
                            //                                           //       const EdgeInsets.symmetric(horizontal: 0.0),
                            //                                           //   itemBuilder:
                            //                                           //       (context, _) =>
                            //                                           //           SvgPicture.asset('assets/Icons/ratingStarIcon.svg'),
                            //                                           //   onRatingUpdate:
                            //                                           //       (rating) {},
                            //                                           // ),
                            //                                           // SizedBox(
                            //                                           //   height:
                            //                                           //       6.h,
                            //                                           // ),
                            //                                         ],
                            //                                       ),
                            //                                       const Spacer(),

                            //                                       Container(
                            //                                         height:
                            //                                             30.h,
                            //                                         width: 50.w,
                            //                                         child: Center(
                            //                                             child: Text(
                            //                                           (
                            //                                                   //AppointmentTypeStringEnum
                            //                                                   (appointmenttypemodel!.data.data[index].name![j].name) == "video")
                            //                                               ? "Live"
                            //                                               : "",
                            //                                           style: TextStyle(
                            //                                               fontSize:
                            //                                                   12),
                            //                                         )),
                            //                                         decoration:
                            //                                             BoxDecoration(
                            //                                           border: Border.all(
                            //                                               color:
                            //                                                   Colors.yellow),
                            //                                           color: Colors
                            //                                               .yellow,
                            //                                           borderRadius:
                            //                                               BorderRadius.circular(
                            //                                                   15),
                            //                                         ),
                            //                                       ),
                            //                                       // SvgPicture.asset(
                            //                                       //   'assets/Icons/forwardBlueIcon.svg',
                            //                                       //   width: 29.w,
                            //                                       //   height: 29.h,
                            //                                       // )
                            //                                     ],
                            //                                   ),
                            //                                 ),
                            //                               )
                            //                             : SizedBox(),
                            //                       ],
                            //                     ),
                            //                 ],
                            //               ),
                            //             ),
                            //           );
                            //         }),
                            //       ),
                            //     ),
                            //     //   : SizedBox(),
                            //     SizedBox(
                            //       height: 25.h,
                            //     ),
                            //     // _userHomeLogic.topRatedLoaderMore!
                            //     //     ? const Center(
                            //     //   child: CircularProgressIndicator(
                            //     //     color: customThemeColor,
                            //     //   ),
                            //     // )
                            //     //     : appointmenttypemodel!.data!.currentPage <appointmenttypemodel!.data!.lastPage!
                            //     //     ? Center(
                            //     //   child: Padding(
                            //     //     padding: EdgeInsets.only(bottom: 30.h),
                            //     //     child: InkWell(
                            //     //       onTap: () {
                            //     //         _userHomeLogic.updateTopRatedLoaderMore(true);
                            //     //
                            //     //         ///---top-rated-API-call
                            //     //         getMethod(context, getTopRatedConsultantURL, {'token': '123', 'page': _userHomeLogic.topRatedModel.data!.topRatedMentors!.currentPage! + 1}, false,
                            //     //             getTopRatedConsultantMoreRepo);
                            //     //       },
                            //     //       child: Container(
                            //     //         height: 36.h,
                            //     //         width: 116.w,
                            //     //         decoration: BoxDecoration(color: Colors.white, border: Border.all(color: customThemeColor), borderRadius: BorderRadius.circular(18.r)),
                            //     //         child: Center(
                            //     //           child: Text(
                            //     //             LanguageConstant.loadMore.tr,
                            //     //             style: TextStyle(fontFamily: SarabunFontFamily.medium, fontSize: 12.sp, color: customThemeColor),
                            //     //           ),
                            //     //         ),
                            //     //       ),
                            //     //     ),
                            //     //   ),
                            //     // )
                            //     //     : const SizedBox()
                            //   ],
                            // )
                          
                          
                          ])
                    : SizedBox()),
          ),
        );
      });
    });
  }
}
