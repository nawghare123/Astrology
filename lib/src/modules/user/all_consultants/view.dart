import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/api_services/get_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/modules/user/all_consultants/get_repo.dart';
import 'package:consultant_product/src/modules/user/all_consultants/widgets/consultant_grid_view.dart';
import 'package:consultant_product/src/modules/user/all_consultants/widgets/page_loader.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_sliver_app_bar.dart';
import 'package:consultant_product/src/widgets/sliver_delegate_tab_fix.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../../controller/general_controller.dart';
import 'logic.dart';

class AllConsultantsPage extends StatefulWidget {
  const AllConsultantsPage({Key? key}) : super(key: key);

  @override
  State<AllConsultantsPage> createState() => _AllConsultantsPageState();
}

class _AllConsultantsPageState extends State<AllConsultantsPage>
    with SingleTickerProviderStateMixin {
  final logic = Get.put(AllConsultantsLogic());

  final state = Get.find<AllConsultantsLogic>().state;

  @override
  void initState() {
    super.initState();

    Get.find<AllConsultantsLogic>().scrollController = ScrollController()
      ..addListener(Get.find<AllConsultantsLogic>().scrollListener);

    /// for tab

    super.initState();

    logic.reference = this;
    getMethod(context, getCategoriesWithMentorURL, null, false,
        getCategoriesWithConsultantRepo);
  }

  @override
  void dispose() {
    Get.find<AllConsultantsLogic>()
        .scrollController!
        .removeListener(Get.find<AllConsultantsLogic>().scrollListener);
    Get.find<AllConsultantsLogic>().scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<AllConsultantsLogic>(builder: (_allConsultantsLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            body: _allConsultantsLogic.allConsultantLoader!
                ? const PageLoader()
                : NestedScrollView(
                    controller: _allConsultantsLogic.scrollController,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        ///---header
                        MyCustomSliverAppBar(
                          heading: LanguageConstant.consultant.tr,
                          subHeading: LanguageConstant
                              .bestConsultantsJustOneClickAway.tr,
                          isShrink: _allConsultantsLogic.isShrink,
                          searchIconShow: true,
                        ),
                        SliverPersistentHeader(
                          delegate: SliverAppBarDelegate(
                            TabBar(
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        6), // Creates border
                                    color: customLightThemeColor),
                                labelPadding:
                                    EdgeInsets.symmetric(horizontal: 25.w),
                                indicatorSize: TabBarIndicatorSize.tab,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.w, 5.h, 10.w, 5.h),
                                automaticIndicatorColorAdjustment: true,
                                isScrollable: true,
                                controller: _allConsultantsLogic.tabController,
                                labelColor: Colors.white,
                                unselectedLabelColor: customLightThemeColor,
                                indicatorColor: Colors.transparent,
                                tabs: _allConsultantsLogic.allCategoriesList),
                          ),
                          pinned: true,
                        ),
                      ];
                    },
                    body: TabBarView(
                      physics: const BouncingScrollPhysics(),
                      controller: _allConsultantsLogic.tabController,
                      children: List.generate(
                          _allConsultantsLogic.allConsultantList.length,
                          (index) => ConsultantGridView(
                                parentIndex: index,
                              )),
                    )),
          ),
        );
      });
    });
  }
}
