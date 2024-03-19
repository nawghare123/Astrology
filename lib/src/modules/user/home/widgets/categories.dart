import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/modules/user/home/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  final state = Get.find<UserHomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserHomeLogic>(builder: (_userHomeLogic) {
      return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(15.w, 30.h, 4.w, 0.h),
        child: _userHomeLogic.categoriesLoader!
            ? SkeletonLoader(
                period: const Duration(seconds: 2),
                highlightColor: Colors.grey,
                direction: SkeletonDirection.ltr,
                builder: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.w, 0.h, 11.w, 0.h),
                        child: Container(
                          height: 15.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
                        )),
                    SizedBox(
                      height: 25.h,
                    ),
                    Center(
                      child: Wrap(
                        children: List.generate(6, (index) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 11.w, 12.h),
                            child: Container(
                              height: 123.h,
                              width: 106.w,
                              decoration: BoxDecoration(color: customTextFieldColor, borderRadius: BorderRadius.circular(8)),
                            ),
                          );
                        }),
                      ),
                    )
                  ],
                ))
            : _userHomeLogic.getCategoriesModel.data == null
                ? const SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.w, 0.h, 11.w, 0.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              LanguageConstant.categories.tr,
                              style: state.subHeadingTextStyle,
                            ),
                            InkWell(
                              onTap: () {
                                _userHomeLogic.selectedCategoryId = null;
                                _userHomeLogic.update();
                                Get.toNamed(PageRoutes.allConsultants);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.dashboard_outlined,size: 15.h,color: Colors.amberAccent,),
                                  SizedBox(width: 3.w,),
                                  Text(
                                    LanguageConstant.all.tr,
                                    style: state.viewAllTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Center(
                        child: Container(
                          height: 50.h,
                        //  width: 230.w,
                          child:
                          ListView.builder(
                              shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                                itemCount: _userHomeLogic.categoriesList.length > 6 ? 6 : _userHomeLogic.categoriesList.length,
                                itemBuilder:(context, index){
                            // List.generate(_userHomeLogic.categoriesList.length > 6 ? 6 : _userHomeLogic.categoriesList.length, (index) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 11.w, 12.h),
                                child: InkWell(
                                  onTap: () {
                                    _userHomeLogic.selectedCategoryId = _userHomeLogic.categoriesList[index].id;
                                    _userHomeLogic.update();
                                    Get.toNamed(PageRoutes.allConsultants);
                                  },
                                  child: Container(
                                     height: 25.h,
                                     width: 106.w,
                                    decoration: BoxDecoration(color: customTextFieldColor, borderRadius: BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          // SizedBox(
                                          //   height: 14.h,
                                          // ),

                                          CircleAvatar(
                                            radius: 15.r,
                                            backgroundColor: _userHomeLogic.categoriesColor[index],
                                            child: CircleAvatar(
                                              radius: 15.r,
                                              backgroundImage: NetworkImage(
                                                _userHomeLogic.categoriesList[index].image!.contains('assets')
                                                    ? '$mediaUrl${_userHomeLogic.categoriesList[index].image!}'
                                                    : _userHomeLogic.categoriesList[index].image!,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            '${_userHomeLogic.categoriesList[index].title}',
                                            style: TextStyle(fontFamily: SarabunFontFamily.semiBold, fontSize: 12.sp, color: _userHomeLogic.categoriesColor[index]),
                                          ),
                                          // Text(
                                          //   '(${_userHomeLogic.categoriesList[index].subTitle} ${LanguageConstant.consultants.tr})',
                                          //   style: TextStyle(fontFamily: SarabunFontFamily.light, fontSize: 10.sp, color: customTextGreyColor),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                        ),
                        ),
                    ],
                  ),
      );
    });
  }
}
