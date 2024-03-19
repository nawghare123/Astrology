import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/modules/user/home/get_repo.dart';
import 'package:consultant_product/src/modules/user/home/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class TopRatedConsultants extends StatefulWidget {
  const TopRatedConsultants({Key? key}) : super(key: key);

  @override
  _TopRatedConsultantsState createState() => _TopRatedConsultantsState();
}

class _TopRatedConsultantsState extends State<TopRatedConsultants> {
  final state = Get.find<UserHomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserHomeLogic>(builder: (_userHomeLogic) {
      return _userHomeLogic.topRatedLoader!
          ? SkeletonLoader(
              period: const Duration(seconds: 2),
              highlightColor: Colors.grey,
              direction: SkeletonDirection.ltr,
              builder: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.w, 20.h, 15.w, 0.h),
                      child: Container(
                        height: 15.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r)),
                      )),
                  SizedBox(
                    height: 25.h,
                  ),
                  Center(
                    child: Wrap(
                      children: List.generate(4, (index) {
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.w, 0.h, 15.w, 15.h),
                          child: Container(
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
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ))
          : _userHomeLogic.topRatedModel.data == null
              ? const SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.w, 20.h, 15.w, 0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LanguageConstant.topRatedConsultant.tr,
                            style: state.subHeadingTextStyle,
                          ),
                          // InkWell(
                          //   onTap: () {},
                          //   child: Text(
                          //     'View All',
                          //     style: state.viewAllTextStyle,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Center(
                      child: Wrap(
                        children: List.generate(
                            _userHomeLogic.topRatedConsultantList.length,
                            (index) {
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15.w, 0.h, 15.w, 15.h),
                            child: InkWell(
                              onTap: () {
                                _userHomeLogic.selectedConsultantID =
                                    _userHomeLogic
                                        .topRatedConsultantList[index].userId;
                                _userHomeLogic.selectedConsultantName =
                                    '${_userHomeLogic.topRatedConsultantList[index].firstName}';
                                _userHomeLogic.update();
                                Get.toNamed(
                                    PageRoutes.consultantProfileForUser);
                              },
                              child: Container(
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
                                        child: _userHomeLogic
                                                    .topRatedConsultantList[
                                                        index]
                                                    .imagePath ==
                                                null
                                            ? SizedBox(
                                                width: 76.w,
                                                height: 85.h,
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                child: Image.network(
                                                  _userHomeLogic
                                                          .topRatedConsultantList[
                                                              index]
                                                          .imagePath!
                                                          .contains('assets')
                                                      ? '$mediaUrl/public/${_userHomeLogic.topRatedConsultantList[index].imagePath}'
                                                      : '${_userHomeLogic.topRatedConsultantList[index].imagePath}',
                                                  width: 76.w,
                                                  height: 85.h,
                                                  fit: BoxFit.cover,
                                                  errorBuilder:
                                                      (context, object, trace) {
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
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 6.h,
                                          ),

                                          ///---title
                                          Text(
                                            '${_userHomeLogic.topRatedConsultantList[index].firstName!.toUpperCase()}',
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: state.topTitleTextStyle!
                                                .copyWith(
                                                    color:
                                                        customTextBlackColor),
                                          ),
                                                 const Spacer(),
   const Spacer(),
                                                                      Text((((( _userHomeLogic
                                                            .topRatedConsultantList[
                                                                index].from!.difference( _userHomeLogic
                                                            .topRatedConsultantList[
                                                                index].to!).inDays ~/30) % 12) / 3).toInt() .toString()) + " months " + (( _userHomeLogic
                                                            .topRatedConsultantList[
                                                                index].from!.difference( _userHomeLogic
                                                            .topRatedConsultantList[
                                                                index].to!).inDays ~/30) ~/ 12).toString() + " years",
                                                                                     softWrap:
                                                                              true,
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          maxLines:
                                                                              1,
                                                                          style:
                                                                              TextStyle(fontSize: 12)),
                                        
   const Spacer(),
                                          ///---sub-title
                                          // Text(
                                          //   (_userHomeLogic
                                          //               .topRatedConsultantList[
                                          //                   index]
                                          //               .subTitle ==
                                          //           "category")
                                          //       ? "occupation"
                                          //       : "",
                                          //   softWrap: true,
                                          //   overflow: TextOverflow.ellipsis,
                                          //   style: state.topSubTitleTextStyle!
                                          //       .copyWith(
                                          //           color:
                                          //               customTextBlackColor),
                                          // ),
                                                   const Spacer(),
Wrap(children: [

  for (int k =
                                                                              0;
                                                                          k < _userHomeLogic
                                                            .topRatedConsultantList[
                                                                index].occupation!.length;
                                                                          k++)
                                                                        Text(
                                                                          _userHomeLogic
                                                            .topRatedConsultantList[
                                                                index]
                                                                              .occupation![k]!
                                                                          [0].name
                                                                      .toString()+
                                                                    " ",
                                                                          softWrap:
                                                                              true,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: state
                                                                              .topSubTitleTextStyle!
                                                                              .copyWith(color: customTextBlackColor),
                                                                        ),
],),
                                          

                                          const Spacer(),
                                                                     Wrap(children: [
 for (int  r = 0; r<_userHomeLogic .topRatedConsultantList[index].religion!.length; r++)
                                                                          Text(
                                                                          (_userHomeLogic
                                                            .topRatedConsultantList[
                                                                index].religion![r]??'').toString()+" ",
                                                                              
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
                                                                     
                                          const Spacer(),

                                          ///---rating-bar
                                          RatingBar.builder(
                                            ignoreGestures: true,
                                            initialRating: double.parse(
                                                (_userHomeLogic
                                                            .topRatedConsultantList[
                                                                index]
                                                            .topRating ??
                                                        0)
                                                    .toString()),
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 15,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 0.0),
                                            itemBuilder: (context, _) =>
                                                SvgPicture.asset(
                                                    'assets/Icons/ratingStarIcon.svg'),
                                            onRatingUpdate: (rating) {},
                                          ),
                                          SizedBox(
                                            height: 6.h,
                                          ),
                                        ],
                                      ),
                                      const Spacer(),

                                      // Container(height: 30.h,width: 50.w,child: Center(child: Text("Chat",style: TextStyle(fontSize: 14),)),
                                      //   decoration: BoxDecoration(border: Border.all(color: Colors.yellow),color: Colors.yellow, borderRadius: BorderRadius.circular(15),
                                      //   ),
                                      // ),
                                      SvgPicture.asset(
                                        'assets/Icons/forwardBlueIcon.svg',
                                        width: 29.w,
                                        height: 29.h,
                                      )
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
                    _userHomeLogic.topRatedLoaderMore!
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: customThemeColor,
                            ),
                          )
                        : _userHomeLogic.topRatedModel.data!.topRatedMentors!
                                    .currentPage! <
                                _userHomeLogic.topRatedModel.data!
                                    .topRatedMentors!.lastPage!
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 30.h),
                                  child: InkWell(
                                    onTap: () {
                                      _userHomeLogic
                                          .updateTopRatedLoaderMore(true);

                                      ///---top-rated-API-call
                                      getMethod(
                                          context,
                                          getTopRatedConsultantURL,
                                          {
                                            'token': '123',
                                            'page': _userHomeLogic
                                                    .topRatedModel
                                                    .data!
                                                    .topRatedMentors!
                                                    .currentPage! +
                                                1
                                          },
                                          false,
                                          getTopRatedConsultantMoreRepo);
                                    },
                                    child: Container(
                                      height: 36.h,
                                      width: 116.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: customThemeColor),
                                          borderRadius:
                                              BorderRadius.circular(18.r)),
                                      child: Center(
                                        child: Text(
                                          LanguageConstant.loadMore.tr,
                                          style: TextStyle(
                                              fontFamily:
                                                  SarabunFontFamily.medium,
                                              fontSize: 12.sp,
                                              color: customThemeColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox()
                  ],
                );
   
   
    });
  }
}
