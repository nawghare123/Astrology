import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:resize/resize.dart';

import '../../api_services/urls.dart';
import '../../controller/general_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/custom_sliver_app_bar.dart';
import '../../widgets/notififcation_icon.dart';
import 'logic.dart';

class BlogDetailPage extends StatefulWidget {
  const BlogDetailPage({Key? key}) : super(key: key);

  @override
  State<BlogDetailPage> createState() => _BlogDetailPage();
}

class _BlogDetailPage extends State<BlogDetailPage> {
  final logic = Get.put(BlogsLogic());

  final state = Get.find<BlogsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<BlogsLogic>(builder: (_blogsLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            body: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header

                    SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height * .35,
                      // floating: true,
                      pinned: true,
                      // snap: true,
                      elevation: 0,
                      leading: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/Icons/whiteBackArrow.svg'),
                          ],
                        ),
                      ),
                      backgroundColor: customThemeColor,
                      actions: const [
                        ///---notifications

                        CustomNotificationIcon(color: Colors.white)
                      ],
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(30),
                        child: Container(
                          height: 15.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
                              color: Colors.white,
                              boxShadow: const [BoxShadow(color: Colors.white, spreadRadius: 3, offset: Offset(0, 1))]),
                        ),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          background: _blogsLogic.selectedBlogForView.imagePath.toString() != 'null'
                              ? Image.network(
                                  _blogsLogic.selectedBlogForView.imagePath!.contains('assets')
                                      ? '$mediaUrl/public/${_blogsLogic.selectedBlogForView.imagePath}'
                                      : '${_blogsLogic.selectedBlogForView.imagePath}',
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/real-estate-01.png',
                                  fit: BoxFit.cover,
                                )),
                    ),
                  ];
                },
                body: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16.w, 0, 16.w, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 25.h,
                                  width: 108.w,
                                  decoration: BoxDecoration(color: customLightOrangeColor, borderRadius: BorderRadius.all(Radius.circular(6.r))),
                                  child: Center(
                                    child: Text(
                                      '${_blogsLogic.selectedBlogCategory}',
                                      style: state.blogCategoryTextStyle,
                                    ),
                                  ),
                                ),

                                /// Time
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/Icons/blogTimeIcon.svg'),
                                    SizedBox(width: 4.w),
                                    Text(
                                      //  '  ${_blogsLogic.selectedBlogForView.createdAt!.substring(0, 10)}',
                                      DateFormat('dd-MM-yyyy').format(DateTime.parse('${_blogsLogic.selectedBlogForView.createdAt}')),
                                      style: state.blogCategoryTextStyle?.copyWith(color: customTextBlackColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),

                            /// Text
                            Text(
                              '${_blogsLogic.selectedBlogForView.title}',
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: state.blogNameTextStyle,
                            ),
                            SizedBox(height: 23.h),

                            /// Author name
                            // Row(
                            //   children: [
                            //     Container(
                            //       height: 50.h,
                            //       width: 50.w,
                            //       child: ClipRRect(
                            //         borderRadius: BorderRadius.circular(25),
                            //         child: _blogsLogic
                            //                     .selectedBlogForView.imagePath
                            //                     .toString() !=
                            //                 'null'
                            //             ? Image.network(
                            //                 '$mediaUrl${_blogsLogic.selectedBlogForView.imagePath}',
                            //                 fit: BoxFit.cover,
                            //                 height: 60,
                            //                 width: 60,
                            //               )
                            //             : Container(
                            //                 height: 50.h,
                            //                 width: 50.w,
                            //                 decoration: const BoxDecoration(
                            //                     color: Colors.grey,
                            //                     shape: BoxShape.circle),
                            //               ),
                            //       ),
                            //     ),
                            //     SizedBox(width: 8.w),
                            //     Text(
                            //       'John Doe',
                            //       softWrap: true,
                            //       overflow: TextOverflow.ellipsis,
                            //       maxLines: 1,
                            //       style: state.blogNameTextStyle,
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(height: 20.h),

                            ///Divider
                            const Divider(
                              color: Colors.grey,
                            ),
                            SizedBox(height: 20.h),

                            /// Text
                            Text(
                              '${_blogsLogic.selectedBlogForView.title}.',
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: state.blogNameTextStyle?.copyWith(color: customTextBlackColor),
                            ),
                            SizedBox(height: 18.h),
                            Html(
                              data: '${_blogsLogic.selectedBlogForView.description}',
                            )
                            // Text(
                            //   '${_blogsLogic.selectedBlogForView.description}',
                            //   style: state.blogDescTextStyle,
                            //   textAlign: TextAlign.justify,
                            // )
                          ],
                        ),
                      ),
                    ))),
          ),
        );
      });
    });
  }
}
