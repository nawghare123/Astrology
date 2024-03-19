// import 'package:flutter/material.dart';
//
// class DialogForNotes extends StatefulWidget {
//   const DialogForNotes({Key? key}) : super(key: key);
//
//   @override
//   _DialogForNotesState createState() => _DialogForNotesState();
// }
//
// class _DialogForNotesState extends State<DialogForNotes> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
//
// /// dialog
// GlobalKey<FormState> noteFormKey = GlobalKey();
// TextEditingController noteController = TextEditingController();
// customDialogForNotes(BuildContext context) {
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//           return Dialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               elevation: 0,
//               backgroundColor: Colors.transparent,
//               child: Container(
//                 decoration: BoxDecoration(
//                   shape: BoxShape.rectangle,
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Form(
//                   key: noteFormKey,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: const BorderRadius.vertical(
//                               top: Radius.circular(20)),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.7),
//                               spreadRadius: 3,
//                               blurRadius: 9,
//                             )
//                           ],
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text(
//                                 //  LanguageConstant.withdrawRequest.tr,
//                                 'Attachment Request',
//                                 textAlign: TextAlign.start,
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 18.sp,
//                                     color: Colors.black),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsetsDirectional.fromSTEB(
//                             15, 15, 15, 15),
//                         child: TextFormField(
//                           style: TextStyle(
//                               fontFamily: SarabunFontFamily.regular,
//                               fontSize: 16.sp,
//                               color: Colors.black),
//                           controller: noteController,
//                           keyboardType: TextInputType.text,
//                           maxLines: null,
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsetsDirectional.fromSTEB(
//                                 25.w, 15.h, 25.w, 15.h),
//                             hintText:
//                                 // LanguageConstant.addAmount.tr,
//                                 'Note',
//                             hintStyle: TextStyle(
//                                 fontFamily: SarabunFontFamily.regular,
//                                 fontSize: 16.sp,
//                                 color: customTextGreyColor),
//                             fillColor: customTextFieldColor,
//                             filled: true,
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8.r),
//                                 borderSide: const BorderSide(
//                                     color: Colors.transparent)),
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8.r),
//                                 borderSide: const BorderSide(
//                                     color: Colors.transparent)),
//                             focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8.r),
//                                 borderSide: const BorderSide(
//                                     color: customLightThemeColor)),
//                             errorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8.r),
//                                 borderSide:
//                                     const BorderSide(color: Colors.red)),
//                           ),
//                           validator: (String? value) {
//                             if (value!.isEmpty) {
//                               return LanguageConstant.fieldRequired.tr;
//                             } else {
//                               return null;
//                             }
//                           },
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(15.w, 0, 0, 0),
//                         child: InkWell(
//                           onTap: () {
//                             imagePickerDialog(context);
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: customTextFieldColor,
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(8.r))),
//                             child: Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   10.w, 10.h, 10.w, 10.h),
//                               child: Text(
//                                 'Attachment',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 18.sp,
//                                     color: Colors.black),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 Navigator.pop(context);
//                               },
//                               child: Text(
//                                 LanguageConstant.cancel.tr,
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 16.sp,
//                                     color: customThemeColor),
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 30,
//                             ),
//                             InkWell(
//                               onTap: () {
//
//                               },
//                               child: Text(
//                                 LanguageConstant.submit.tr,
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 16.sp,
//                                     color: customThemeColor),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//           );
//       });
//
// }
// /// file function
// void imagePickerDialog(BuildContext context) {
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return CupertinoAlertDialog(
//           actions: <Widget>[
//             CupertinoDialogAction(
//                 isDefaultAction: true,
//                 onPressed: () async {
//                   Navigator.pop(context);
//                   setState(() {
//                     degreeImagesList = [];
//                   });
//                   degreeImagesList.add(await ImagePickerGC.pickImage(
//                       enableCloseButton: true,
//                       context: context,
//                       source: ImgSource.Camera,
//                       barrierDismissible: true,
//                       imageQuality: 10,
//                       maxWidth: 400,
//                       maxHeight: 600));
//                   if (degreeImagesList.isNotEmpty) {
//                     setState(() {
//                       degreeImage = File(degreeImagesList[0].path);
//                     });
//                   }
//                 },
//                 child: Text(
//                   LanguageConstant.camera.tr,
//                   style: Theme.of(context)
//                       .textTheme
//                       .headline5!
//                       .copyWith(fontSize: 18),
//                 )),
//             CupertinoDialogAction(
//                 isDefaultAction: true,
//                 onPressed: () async {
//                   Navigator.pop(context);
//                   setState(() {
//                     degreeImagesList = [];
//                   });
//                   degreeImagesList.add(await ImagePickerGC.pickImage(
//                       enableCloseButton: true,
//                       context: context,
//                       source: ImgSource.Gallery,
//                       barrierDismissible: true,
//                       imageQuality: 10,
//                       maxWidth: 400,
//                       maxHeight: 600));
//                   if (degreeImagesList.isNotEmpty) {
//                     setState(() {
//                       degreeImage = File(degreeImagesList[0].path);
//                     });
//                   }
//                 },
//                 child: Text(
//                   LanguageConstant.gallery.tr,
//                   style: Theme.of(context)
//                       .textTheme
//                       .headline5!
//                       .copyWith(fontSize: 18),
//                 )),
//           ],
//         );
//       });
// }
