import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/dashboard/logic.dart';
import 'package:consultant_product/src/modules/consultant/dashboard/repo_post.dart';
import 'package:consultant_product/src/modules/user/user_drawer/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../../../api_services/urls.dart';
import 'logic.dart';

class ConsultantDrawerPage extends StatefulWidget {
  const ConsultantDrawerPage({Key? key}) : super(key: key);

  @override
  State<ConsultantDrawerPage> createState() => _ConsultantDrawerPageState();
}

class _ConsultantDrawerPageState extends State<ConsultantDrawerPage> {
  final logic = Get.put(ConsultantDrawerLogic());

  final state = Get.find<ConsultantDrawerLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<GeneralController>().updateFormLoaderController(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<DashboardLogic>(builder: (_dashboardLogic) {
        return GetBuilder<ConsultantDrawerLogic>(builder: (_consultantDrawerLogic) {
          return ModalProgressHUD(
            inAsyncCall: _generalController.formLoaderController!,
            child: Scaffold(
              backgroundColor: customThemeColor,
              body: Stack(
                children: [
                  ///---background
                  PositionedDirectional(
                      top: 0,
                      end: 0,
                      child: Image.asset(
                        'assets/images/drawerBackground.png',
                        width: MediaQuery.of(context).size.width * .8,
                      )),

                  ///---body
                  SafeArea(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),

                          ///---profile-area
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _generalController.getConsultantProfileModel.data == null
                                      ? SkeletonLoader(
                                          period: const Duration(seconds: 2),
                                          highlightColor: Colors.grey,
                                          direction: SkeletonDirection.ltr,
                                          builder: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              ///---image
                                              Container(
                                                height: 49.h,
                                                width: 49.w,
                                                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                              ),
                                              SizedBox(
                                                width: 15.w,
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  ///---name
                                                  Container(
                                                    height: 10.h,
                                                    width: 80.w,
                                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5.r)),
                                                  ),

                                                  SizedBox(
                                                    height: 10.h,
                                                  ),

                                                  ///---email
                                                  Container(
                                                    height: 10.h,
                                                    width: 150.w,
                                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5.r)),
                                                  ),
                                                ],
                                              ),
                                              const Spacer()
                                            ],
                                          ),
                                        )
                                      : Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            ///---image
                                            Container(
                                              height: 49.h,
                                              width: 49.w,
                                              decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                                              child: Get.find<GeneralController>().getConsultantProfileModel.data!.userDetail!.imagePath == null
                                                  ? const SizedBox()
                                                  : ClipRRect(
                                                      borderRadius: BorderRadius.circular(30),
                                                      child: Image.network(
                                                        Get.find<GeneralController>().getConsultantProfileModel.data!.userDetail!.imagePath!.contains('assets')
                                                            ? '$mediaUrl/public/${Get.find<GeneralController>().getConsultantProfileModel.data!.userDetail!.imagePath}'
                                                            : '${Get.find<GeneralController>().getConsultantProfileModel.data!.userDetail!.imagePath}',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                ///---name
                                                Text(
                                                  Get.find<GeneralController>().getConsultantProfileModel.data!.userDetail!.firstName ?? '',
                                                  style: state.nameTextStyle,
                                                ),

                                                SizedBox(
                                                  height: 5.h,
                                                ),

                                                ///---email
                                                Text(
                                                  Get.find<GeneralController>().getConsultantProfileModel.data!.userDetail!.email ?? '',
                                                  style: state.emailTextStyle,
                                                ),
                                              ],
                                            ),
                                            const Spacer()
                                          ],
                                        ),
                                ),
                                InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(5.w, 5.h, 0, 5.h),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: SvgPicture.asset('assets/Icons/drawerBackArrowIcon.svg'),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 0.h,
                          ),

                          ListTile(
                            title: Text(LanguageConstant.onlineStatus.tr, style: TextStyle(fontSize: 14.sp, fontFamily: SarabunFontFamily.regular, color: Colors.white)),
                            trailing: Switch(
                              activeColor: customLightThemeColor,
                              value: Get.find<GeneralController>().getConsultantProfileModel.data?.userDetail?.onlineStatus == 'online' ? true : false,
                              onChanged: (bool? newValue) {
                                if (!newValue!) {
                                  Get.find<GeneralController>().storageBox.write('onlineStatus', 'off');
                                } else {
                                  Get.find<GeneralController>().storageBox.remove('onlineStatus');
                                }
                                postMethod(
                                    context,
                                    changeMentorOnlineStatusUrl,
                                    {'token': '123', 'user_id': Get.find<GeneralController>().storageBox.read('userID'), 'status': newValue ? 'online' : 'offline'},
                                    true,
                                    changeMentorOnlineStatusRepo);
                              },
                            ),
                          ),

                          ///---list
                          Expanded(
                              child: ListView(
                            children: List.generate(_consultantDrawerLogic.drawerList.length, (index) {
                              List<DrawerTile> drawerShowList = _consultantDrawerLogic.drawerList;
                              return Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child: FadedSlideAnimation(
                                    slideDuration: const Duration(milliseconds: 1000),
                                    fadeDuration: const Duration(milliseconds: 2000),
                                    beginOffset: const Offset(0.3, 0.2),
                                    endOffset: const Offset(0, 0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ListTile(
                                          onTap: () {
                                            _consultantDrawerLogic.consultantDrawerNavigation(index, context);
                                          },
                                          leading: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                '${drawerShowList[index].icon}',
                                                height: 20.h,
                                                width: 20.w,
                                              ),
                                            ],
                                          ),
                                          title: Text(
                                            '${drawerShowList[index].title}',
                                            style: state.titleTextStyle,
                                          ),
                                        ),
                                        Divider(
                                          color: const Color(0xff404191),
                                          thickness: 1.5,
                                          height: 10.h,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      });
    });
  }
}
