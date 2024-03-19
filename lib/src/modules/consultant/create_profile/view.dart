import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/consultant/create_profile/repos/get_repo.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'logic.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({Key? key}) : super(key: key);

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final logic = Get.put(CreateProfileLogic());

  final state = Get.find<CreateProfileLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    logic.scrollController = ScrollController()..addListener(Get.find<CreateProfileLogic>().scrollListener);
    logic.stepperScrollController = ScrollController();

    logic.emptyOccupationDropDownList();
    logic.emptyCountryDropDownList();
    logic.emptyCityDropDownList();
    logic.emptyDegreeDropDownList();
    logic.emptyForDisplayEducationList();

    logic.getSetData(context);

    getMethod(context, mentorProfileGenericDataUrl, {'token': '123'}, false, getGenericDataRepo);

    getMethod(context, mentorParentCategoryDataUrl, {'token': '123'}, false, getParentCategoryRepo);
  }

  @override
  void dispose() {
    logic.scrollController!.removeListener(logic.scrollListener);
    logic.scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<CreateProfileLogic>(builder: (_createProfileLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: customThemeColor,
            body: NestedScrollView(
                controller: _createProfileLogic.scrollController,
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height * .3,
                      floating: true,
                      pinned: true,
                      snap: false,
                      elevation: 0,
                      backgroundColor: _createProfileLogic.isShrink ? customThemeColor : Colors.transparent,
                      leading: InkWell(
                          onTap: () {
                            Get.find<GeneralController>().storageBox.remove('userID');
                            Get.find<GeneralController>().storageBox.remove('authToken');
                            Get.find<GeneralController>().storageBox.remove('userRole');
                            Get.find<GeneralController>().storageBox.remove('fcmToken');
                            Get.offAllNamed(PageRoutes.userHome);
                          },
                          child: const Icon(Icons.logout, color: Colors.red)),
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: Container(
                          decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.vertical(bottom: Radius.circular(40.r))),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/bookAppointmentAppBar.svg',
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height * .23,
                                    fit: BoxFit.fill,
                                  ),
                                  SafeArea(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0.w, 25.h, 0.w, 16.h),
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 25.h,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                                child: Text(LanguageConstant.createProfile.tr, style: state.headingTextStyle),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                                child: Text(LanguageConstant.createYourProfile.tr, style: state.subHeadingTextStyle),
                                              ),

                                              ///---stepper
                                              Column(
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(5.w, 20.h, 5.w, 0),
                                                      child: SizedBox(
                                                        height: 85.h,
                                                        width: MediaQuery.of(context).size.width,
                                                        child: ListView(
                                                            controller: _createProfileLogic.stepperScrollController,
                                                            scrollDirection: Axis.horizontal,
                                                            children: List.generate(
                                                              _createProfileLogic.stepperList.length,
                                                              (index) {
                                                                return InkWell(
                                                                  onTap: () {
                                                                    if (_createProfileLogic.stepperList[index].isCompleted! || _createProfileLogic.stepperList[index].isSelected!) {
                                                                      _createProfileLogic.updateStepperIndex(index);
                                                                    }
                                                                  },
                                                                  child: SizedBox(
                                                                    width: MediaQuery.of(context).size.width * .25,
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [
                                                                            index == 0
                                                                                ? const Spacer()
                                                                                : Expanded(
                                                                                    child: Container(
                                                                                      height: 5.h,
                                                                                      color: _createProfileLogic.stepperList[index - 1].isCompleted! ? customGreenColor : Colors.white,
                                                                                    ),
                                                                                  ),
                                                                            CircleAvatar(
                                                                              radius: 20.r,
                                                                              backgroundColor: !_createProfileLogic.stepperList[index].isCompleted!
                                                                                  ? _createProfileLogic.stepperList[index].isSelected!
                                                                                      ? customOrangeColor
                                                                                      : Colors.white
                                                                                  : customGreenColor,
                                                                              child: _createProfileLogic.stepperList[index].isCompleted!
                                                                                  ? const Icon(
                                                                                      Icons.check,
                                                                                      color: Colors.white,
                                                                                      size: 20,
                                                                                    )
                                                                                  : Text(
                                                                                      _createProfileLogic.stepperList[index].stepperLabel!,
                                                                                      style: state.stepperTextStyle!.copyWith(
                                                                                          color: !_createProfileLogic.stepperList[index].isCompleted!
                                                                                              ? _createProfileLogic.stepperList[index].isSelected!
                                                                                                  ? Colors.white
                                                                                                  : const Color(0xff727377)
                                                                                              : Colors.white),
                                                                                    ),
                                                                            ),
                                                                            index == _createProfileLogic.stepperList.length - 1
                                                                                ? const Spacer()
                                                                                : Expanded(
                                                                                    child: Container(
                                                                                      height: 5.h,
                                                                                      color: _createProfileLogic.stepperList[index + 1].isSelected!
                                                                                          ? customGreenColor
                                                                                          : _createProfileLogic.stepperList[index + 1].isCompleted!
                                                                                              ? customGreenColor
                                                                                              : Colors.white,
                                                                                    ),
                                                                                  ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height: 4.h,
                                                                        ),
                                                                        Text(
                                                                          _createProfileLogic.stepperList[index].title!,
                                                                          textAlign: TextAlign.center,
                                                                          style: state.stepperLabelTextStyle,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            )),
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: customTextFieldColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r)),
                      child: _createProfileLogic.consultantProfileNavigation(_createProfileLogic.stepperIndex, context),
                    ))),
          ),
        );
      });
    });
  }
}
