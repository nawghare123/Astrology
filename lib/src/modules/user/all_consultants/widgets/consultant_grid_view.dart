import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/modules/user/all_consultants/get_repo.dart';
import 'package:consultant_product/src/modules/user/home/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../logic.dart';

class ConsultantGridView extends StatefulWidget {
  const ConsultantGridView({Key? key, required this.parentIndex})
      : super(key: key);

  final int parentIndex;

  @override
  _ConsultantGridViewState createState() => _ConsultantGridViewState();
}

class _ConsultantGridViewState extends State<ConsultantGridView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllConsultantsLogic>(builder: (_allConsultantsLogic) {
      return ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 20.h, 0, 0),
            child: Center(
              child: _allConsultantsLogic.allConsultantList[widget.parentIndex]
                      .mentors!.data!.isEmpty
                  ? Text(
                      'No Record Found',
                      style: TextStyle(
                          fontFamily: SarabunFontFamily.regular,
                          fontSize: 16.sp,
                          color: customTextBlackColor),
                    )
                  : Wrap(
                      spacing: 12.w,
                      runSpacing: 18.h,
                      alignment: WrapAlignment.start,
                      children: List.generate(
                        _allConsultantsLogic
                            .allConsultantList[widget.parentIndex]
                            .mentors!
                            .data!
                            .length,
                        (index) => Padding(
                          padding: EdgeInsets.only(top: 0.h),
                          child: InkWell(
                            onTap: () {
                              Get.find<UserHomeLogic>().selectedConsultantID =
                                  _allConsultantsLogic
                                      .allConsultantList[widget.parentIndex]
                                      .mentors!
                                      .data![index]
                                      .user
                                      ?.id;
                              Get.find<UserHomeLogic>().selectedConsultantName =
                                  '${_allConsultantsLogic.allConsultantList[widget.parentIndex].mentors!.data![index].user?.firstName} '
                                  '${_allConsultantsLogic.allConsultantList[widget.parentIndex].mentors!.data![index].user?.lastName}';
                              Get.find<UserHomeLogic>().update();
                              Get.toNamed(PageRoutes.consultantProfileForUser);
                            },
                            child: Container(
                              // width: 164.w,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.r)),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0xffF5F5F5),
                                        blurRadius: 10.0,
                                        spreadRadius: 5.0,
                                        offset: Offset(5, -3))
                                  ]),
                              child: Row(
                                children: [
                                    ///---profile-image
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.w, 16.h, 16.w, 14.h),
                                        child: Container(
                                          color: customLightThemeColor,
                                          height: 114.h,
                                          width: 132.w,
                                          child: _allConsultantsLogic
                                                      .allConsultantList[
                                                          widget.parentIndex]
                                                      .mentors
                                                      ?.data?[index]
                                                      .user
                                                      ?.imagePath ==
                                                  null
                                              ? const SizedBox()
                                              : Image.network(
                                                  (_allConsultantsLogic
                                                                  .allConsultantList[
                                                                      widget
                                                                          .parentIndex]
                                                                  .mentors
                                                                  ?.data?[index]
                                                                  .user
                                                                  ?.imagePath ??
                                                              "")
                                                          .contains('assets')
                                                      ? '$mediaUrl${_allConsultantsLogic.allConsultantList[widget.parentIndex].mentors!.data![index].user!.imagePath}'
                                                      : '${_allConsultantsLogic.allConsultantList[widget.parentIndex].mentors!.data![index].user!.imagePath}',
                                                  width: double.infinity,
                                                  fit: BoxFit.fill,
                                                  height: double.infinity,
                                                  // loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                                  //   if (loadingProgress == null) return child;
                                                  //   return Center(
                                                  //     child: CircularProgressIndicator(
                                                  //       value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                                  //     ),
                                                  //   );
                                                  // },
                                                  errorBuilder:
                                                      (context, object, trace) {
                                                    return const Icon(
                                                        Icons.broken_image,
                                                        size: 30,
                                                        color: Colors.white);
                                                  },
                                                ),
                                        ),
                                      ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                    
                                      ///---name
                                      Text(
                                        '${_allConsultantsLogic.allConsultantList[widget.parentIndex].mentors?.data?[index].user?.firstName ?? ''} '
                                        '${_allConsultantsLogic.allConsultantList[widget.parentIndex].mentors?.data?[index].user?.lastName ?? ''}',
                                        maxLines: 1,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: _allConsultantsLogic
                                            .state.consultantNameTextStyle,
                                      ),
                                      SizedBox(height: 8.h),

                                      ///---category
                                      Text(
                                        _allConsultantsLogic
                                                .allConsultantList[
                                                    widget.parentIndex]
                                                .mentors
                                                ?.data?[index]
                                                .category
                                                ?.name ??
                                            "N/A",
                                        style: _allConsultantsLogic
                                            .state.consultantCategoryTextStyle,
                                      ),
                                      SizedBox(height: 6.h),

                                      ///---rating
                                      RatingBar.builder(
                                        ignoreGestures: true,
                                        initialRating: double.parse(
                                            (_allConsultantsLogic
                                                        .allConsultantList[
                                                            widget.parentIndex]
                                                        .mentors
                                                        ?.data?[index]
                                                        .ratingAvg ??
                                                    0)
                                                .toString()),
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 15,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        itemBuilder: (context, _) =>
                                            SvgPicture.asset(
                                                'assets/Icons/ratingStarIcon.svg'),
                                        onRatingUpdate: (rating) {},
                                      ),
                                      SizedBox(height: 16.h),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
            ),
          ),
          (_allConsultantsLogic.allConsultantList[widget.parentIndex].mentors
                          ?.currentPage ??
                      0) <
                  (_allConsultantsLogic.allConsultantList[widget.parentIndex]
                          .mentors?.lastPage ??
                      0)
              ? _allConsultantsLogic.allConsultantMoreLoader!
                  ? Padding(
                      padding: EdgeInsets.only(top: 25.h),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: customThemeColor,
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(top: 25.h),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 30.h),
                          child: InkWell(
                            onTap: () {
                              _allConsultantsLogic.selectedParentIndexForMore =
                                  widget.parentIndex;
                              _allConsultantsLogic.update();
                              _allConsultantsLogic
                                  .updateAllConsultantMoreLoader(true);

                              getMethod(
                                  context,
                                  getCategoriesWithMentorURL,
                                  {
                                    'category_id': _allConsultantsLogic
                                        .allConsultantList[widget.parentIndex]
                                        .id,
                                    'page': _allConsultantsLogic
                                            .allConsultantList[
                                                widget.parentIndex]
                                            .mentors!
                                            .currentPage! +
                                        1
                                  },
                                  false,
                                  getCategoriesWithConsultantMoreRepo);
                            },
                            child: Container(
                              height: 36.h,
                              width: 116.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: customThemeColor),
                                  borderRadius: BorderRadius.circular(18.r)),
                              child: Center(
                                child: Text(
                                  'Load More',
                                  style: TextStyle(
                                      fontFamily: SarabunFontFamily.medium,
                                      fontSize: 12.sp,
                                      color: customThemeColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
              : const SizedBox(),
          SizedBox(
            height: MediaQuery.of(context).size.height * .1,
          )
        ],
      );
    });
  }
}
