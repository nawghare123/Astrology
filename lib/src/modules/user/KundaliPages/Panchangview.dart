import 'package:consultant_product/src/modules/user/KundaliPages/apiclass.dart';
import 'package:consultant_product/src/modules/user/KundaliPages/logic.dart';
import 'package:consultant_product/src/modules/user/KundaliPages/panchangModel.dart';
import 'package:consultant_product/src/modules/user/KundaliPages/timelogic.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/notififcation_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';
import 'package:resize/resize.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import '../../../controller/general_controller.dart';
import '../../../utils/colors.dart';
import '../home/logic.dart';
import 'package:intl/intl.dart' as intl;


class PanchangeView extends StatefulWidget {
   PanchangeView({Key? key,this.date,this.time}) : super(key: key);
 String? date;
 String? time; 
  @override
  State<PanchangeView> createState() => _PanchangeViewState();
}

class _PanchangeViewState extends State<PanchangeView> {
// var _kundalilogic = Get.put(() => KundaliLogic());


  TextEditingController dateController = TextEditingController();


  TextEditingController timeinput = TextEditingController(); 
// // var _timelogic = Get.put(() =>  TimeLogic());
//   final _timelogic = Get.put(TimeLogic());
  
  bool isloading = false; 
  PanchangModel? panchangmodel;
 final timeFormat = intl.DateFormat.jm();
  bool timeValidator = false;
TimeOfDay initialTime = TimeOfDay.now();


  @override
  void initState() {
    //panchang();
    super.initState();
     setState(() {
      isloading = true;
      timeinput.text = "";
    });
    }
 
 
  Future<void> panchang(year, time) async {
    
    panchangmodel = await ApiKundali.panchangclass(year, time);
    print("panchang");
print(panchangmodel!.weekday!.weekdayName);
    setState(() {
      
    isloading = false;
    });
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
                                    Text(LanguageConstant.panchang.tr,
                               style:     TextStyle(
        fontFamily: SarabunFontFamily.bold,
        fontSize: 28.sp,
        color: customLightThemeColor)
                                        ),
                                    SizedBox(
                                      height: 20.h,
                                    ),

                                    ///---search-field
                                    // TextFormField(
                                    //   onTap: () {
                                    //     Get.toNamed(
                                    //         PageRoutes.searchConsultant);
                                    //   },
                                    //   readOnly: true,
                                    //   decoration: InputDecoration(
                                    //     contentPadding:
                                    //         EdgeInsetsDirectional.fromSTEB(
                                    //             25.w, 15.h, 25.w, 15.h),
                                    //     suffixIcon: Column(
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.center,
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.center,
                                    //       children: [
                                    //         SvgPicture.asset(
                                    //             'assets/Icons/searchIcon.svg'),
                                    //       ],
                                    //     ),
                                    //     hintText:
                                    //         LanguageConstant.searchHere.tr,
                                    //     hintStyle: const TextStyle(
                                    //         fontFamily:
                                    //             SarabunFontFamily.medium,
                                    //         fontSize: 14,
                                    //         color: Color(0xffA3A7AA)),
                                    //     fillColor: customTextFieldColor,
                                    //     filled: true,
                                    //     enabledBorder: OutlineInputBorder(
                                    //         borderRadius:
                                    //             BorderRadius.circular(22.r),
                                    //         borderSide: const BorderSide(
                                    //             color: Colors.transparent)),
                                    //     border: OutlineInputBorder(
                                    //         borderRadius:
                                    //             BorderRadius.circular(22.r),
                                    //         borderSide: const BorderSide(
                                    //             color: Colors.transparent)),
                                    //     focusedBorder: OutlineInputBorder(
                                    //         borderRadius:
                                    //             BorderRadius.circular(22.r),
                                    //         borderSide: const BorderSide(
                                    //             color: customLightThemeColor)),
                                    //     errorBorder: OutlineInputBorder(
                                    //         borderRadius:
                                    //             BorderRadius.circular(22.r),
                                    //         borderSide: const BorderSide(
                                    //             color: Colors.red)),
                                    //   ),
                                    //   validator: (value) {
                                    //     if (value!.isEmpty) {
                                    //       return LanguageConstant
                                    //           .fieldRequired.tr;
                                    //     } else if (!GetUtils.isEmail(value)) {
                                    //       return LanguageConstant
                                    //           .enterValidEmail.tr;
                                    //     } else {
                                    //       return null;
                                    //     }
                                    //   },
                                    // ),
                                
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
                //!isloading?
                ListView(
                    padding: EdgeInsetsDirectional.fromSTEB(15.w, 10.h, 15.w, 0.h),
                    children:  [
SizedBox(height: 5.h,),
                       
                               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [

                                  Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.w, 0, 0.w, 16.h),
                                        child: Theme(
                                          data: ThemeData(
                                              colorScheme: ColorScheme.fromSwatch()
                                                  .copyWith(
                                                      primary: Color.fromRGBO(240, 223, 32, 1))),
                                          child:  TextFormField(
            controller: dateController,
            decoration: InputDecoration(
                 hintText: LanguageConstant.date.tr,
                suffixIcon: Icon(Icons.calendar_today_outlined,size: 20,color:  Colors.grey,),
                contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey,width: 0.5),
                  borderRadius:BorderRadius.circular(10),
                ),
                focusedBorder:OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey,width: 0.5),
                  borderRadius:BorderRadius.circular(10),
                )),

                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,

                          initialDate: DateTime.now(),
                          firstDate:DateTime(1800),
                          // DateTime.now(),
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        print( pickedDate);
                        String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);

                        print(
                            formattedDate);
                        setState(() {
                          dateController.text = formattedDate;
                        });
                      } else {}},




          )
                                          
                                          //  DateTimeField(
                                          //   style: TextStyle(),
                                          //   decoration: InputDecoration(
                                          //       hintText: LanguageConstant.date.tr,
                                          //       hintStyle: TextStyle(),
                                          //       contentPadding:
                                          //           EdgeInsetsDirectional.fromSTEB(
                                          //               10.w, 15.h, 15.w, 15.h),
                                          //       fillColor: Colors.white,
                                          //       filled: true,
                                          //       enabledBorder: OutlineInputBorder(
                                          //           borderRadius:
                                          //               BorderRadius.circular(8.r),
                                          //           borderSide: const BorderSide(
                                          //               color: Colors.transparent)),
                                          //       border: OutlineInputBorder(
                                          //           borderRadius:
                                          //               BorderRadius.circular(8.r),
                                          //           borderSide: const BorderSide(
                                          //               color: Colors.transparent)),
                                          //       focusedBorder: OutlineInputBorder(
                                          //           borderRadius:
                                          //               BorderRadius.circular(8.r),
                                          //           borderSide: const BorderSide(
                                          //               color:
                                          //                   customLightThemeColor)),
                                          //       errorBorder: OutlineInputBorder(
                                          //           borderRadius:
                                          //               BorderRadius.circular(8.r),
                                          //           borderSide: const BorderSide(color: Colors.red)),
                                          //       suffixIcon: Padding(
                                          //         padding:
                                          //             const EdgeInsetsDirectional
                                          //                 .all(15.0),
                                          //         child: SvgPicture.asset(
                                          //           'assets/Icons/calendarIcon.svg',
                                          //         ),
                                          //       )),
                                          //  // initialValue:
                                          //       // _createProfileLogic.selectedDob,
                                          //   format: DateFormat('dd-MM-yyyy'),
                                          //   onShowPicker:
                                          //       (context, currentValue) async {
                                          //     final date = await showDatePicker(
                                          //         context: context,
                                          //         firstDate: DateTime(1900),
                                          //         initialDate: currentValue ??
                                          //             DateTime.now(),
                                          //         lastDate: DateTime.now());
                                          //     if (date != null) {
                                          //       return date;
                                          //     } else {
                                          //       return currentValue;
                                          //     }
                                          //   },
                                          //   validator: (value) {
                                          //     if (value == null) {
                                          //       return LanguageConstant
                                          //           .fieldRequired.tr;
                                          //     }
                                          //     return null;
                                          //   },
                                          //   onChanged: (value) {
                                          //     setState(() {
                                          //       // _createProfileLogic.selectedDob =
                                          //       //     value;
                                          //     });
                                          //   },
                                          // ),
                                     
                                     
                                     
                                        ),
                                      ),
                                    ),


                                  Expanded(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
                                            10.w, 0, 0.w, 16.h),
          child: TextField(
        
                    controller: timeinput, //editing controller of this TextField
                    decoration: InputDecoration(
                        hintText: LanguageConstant.time.tr,
                suffixIcon: Icon(Icons.timer,size: 20,color:  Colors.grey,),
                contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey,width: 0.5),
                  borderRadius:BorderRadius.circular(10),
                ),
                focusedBorder:OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey,width: 0.5),
                  borderRadius:BorderRadius.circular(10),
                )),

                //    readOnly: true,  //set it true, so that user will not able to edit text
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: initialTime,
        );
                      if(pickedTime != null ){
                          print(pickedTime.format(context));   
                          DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                         
                          print(parsedTime); 
                          String formattedTime = DateFormat('HH:mm:ss a').format(parsedTime);
                          print(formattedTime); 
                          setState(() {
                            timeinput.text = formattedTime; 
                          });
                      }else{
                          print("Time is not selected");
                      }
                    },
                 ),
        ),
      )


                                  
                                                  // Expanded(
                                                  //     child: Column(
                                                  //   crossAxisAlignment:
                                                  //       CrossAxisAlignment.start,
                                                  //   mainAxisAlignment:
                                                  //       MainAxisAlignment.start,
                                                  //   children: [
                                                  //     InkWell(
                                                  //       onTap: () async {
                                                  //         /// for focus out
                                                  //         FocusScopeNode
                                                  //             currentFocus =
                                                  //             FocusScope.of(
                                                  //                 context);
                                                  //         if (!currentFocus
                                                  //             .hasPrimaryFocus) {
                                                  //           currentFocus
                                                  //               .unfocus();
                                                  //         } else {}
                                                  //         final picked =
                                                  //             await showTimePicker(
                                                  //                 context:
                                                  //                     context,
                                                  //                 initialTime:
                                                  //                     TimeOfDay
                                                  //                         .now(),
                                                  //                 builder: (BuildContext
                                                  //                         context,
                                                  //                     Widget?
                                                  //                         child) {
                                                  //                   return Theme(
                                                  //                     data: ThemeData(
                                                  //                         colorScheme:
                                                  //                             ColorScheme.fromSwatch().copyWith(primary: customThemeColor)),
                                                  //                     child:
                                                  //                         MediaQuery(
                                                  //                       data: MediaQuery.of(
                                                  //                               context)
                                                  //                           .copyWith(
                                                  //                               alwaysUse24HourFormat: false),
                                                  //                       child:
                                                  //                           child!,
                                                  //                     ),
                                                  //                   );
                                                  //                 });
                                                  //         String hour;
                                                  //         // if (picked!.hour
                                                  //         //         .toString()
                                                  //         //         .length <
                                                  //         //     2) {
                                                  //         //   hour = picked.hour.toString();
                                                  //         //   hour = '0' + hour;
                                                  //         if (picked != null) {
                                                  //           setState(() {
                                                  //             // _mentorScheduleLogic
                                                  //             //     .slotsList
                                                  //             //     .clear();
                                                  //             // _mentorScheduleLogic
                                                  //             //         .selectedTimeForStartForCalculate =
                                                  //             //     DateTimeField
                                                  //             //             .convert(
                                                  //             //                 picked)
                                                  //             //         .toString()
                                                  //             //         .substring(
                                                  //             //             11);
                                     
                                                  //           _timelogic
                                                  //                     .selectedTimeForStart = 
                                                  //                 picked.format(
                                                  //                     context);
                                                  //          //   log('This is start time: ${picked.hour}');
                                                  //           });
                                                  //         }
                                                  //       },
                                                  //       child: Container(
                                                  //           height: 45.h,
                                                  //           decoration: BoxDecoration(
                                                  //               borderRadius:
                                                  //                   BorderRadius
                                                  //                       .circular(
                                                  //                           10.r),
                                                  //               // border: Border.all(
                                                  //               //     color: timeValidator &&
                                                  //               //             _mentorScheduleLogic.selectedTimeForStart ==
                                                  //               //                 null
                                                  //               //         ? Colors
                                                  //               //             .red
                                                  //               //         : customLightThemeColor)
                                                                        
                                                  //                       ),
                                                  //           child: Row(
                                                  //             children: [
                                                  //               Padding(
                                                  //                 padding:
                                                  //                     EdgeInsetsDirectional
                                                  //                         .fromSTEB(
                                                  //                             25.w,
                                                  //                             0,
                                                  //                             0,
                                                  //                             0),
                                                  //                 child: Text(
                                                  //                   _timelogic
                                                  //                               .selectedTimeForStart ==
                                                  //                           null
                                                  //                       ? ''
                                                  //                       : '${_timelogic.selectedTimeForStart}',
                                                  //                   // textDirection:
                                                  //                   //     TextDirection
                                                  //                   //         .ltr,
                                                  //                   // style: state
                                                  //                   //     .scheduleDayTextStyle,
                                                  //                 ),
                                                  //               ),
                                                  //             ],
                                                  //           )),
                                                  //     ),
                                                  //     timeValidator &&
                                                  //             _timelogic
                                                  //                     .selectedTimeForStart ==
                                                  //                 null
                                                  //         ? Padding(
                                                  //             padding:
                                                  //                 EdgeInsetsDirectional
                                                  //                     .fromSTEB(
                                                  //                         7.w,
                                                  //                         5.h,
                                                  //                         0,
                                                  //                         0),
                                                  //             child: Row(
                                                  //               mainAxisAlignment:
                                                  //                   MainAxisAlignment
                                                  //                       .start,
                                                  //               children: [
                                                  //                 Text(
                                                  //                   LanguageConstant
                                                  //                       .fieldRequired
                                                  //                       .tr,
                                                  //                   style: TextStyle(
                                                  //                       fontFamily:
                                                  //                           SarabunFontFamily
                                                  //                               .regular,
                                                  //                       fontSize:
                                                  //                           12.sp,
                                                  //                       color: Colors
                                                  //                           .red),
                                                  //                 )
                                                  //               ],
                                                  //             ),
                                                  //           )
                                                  //         : const SizedBox(),
                                                  //     SizedBox(
                                                  //       height: 4.h,
                                                  //     ),
                                                  //     Padding(
                                                  //       padding:
                                                  //           EdgeInsetsDirectional
                                                  //               .only(start: 5.w),
                                                  //       child: Text(
                                                  //         LanguageConstant
                                                  //             .startTime.tr,
                                                  //         // style: state
                                                  //         //     .subHeadingTextStyle,
                                                  //       ),
                                                  //     )
                                                  //   ],
                                                  // )),
                                               
                                 ],
                               ),
    
SizedBox(height: 10.h,),
    ElevatedButton(
      
              child: const Text(
                'Save',
              ),
              style: ElevatedButton.styleFrom(
                      elevation: 1.0,
                    //  maximumSize: ,
                     shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
              minimumSize: Size(100, 40),
                      textStyle: const TextStyle(color: Colors.white)),
              onPressed: () async {
                    String msg = '';
             
    if (timeinput.text.length <= 0) {
    msg = 'Please choose time';
    }
     
    else if (dateController.text.length <= 0 ) {
      msg = 'Please choose date';
    }

    else  {
      print("print1");
   print(dateController.text);
   print(timeinput.text);
     await panchang(dateController.text ?? '',timeinput.text ?? '');
      
     
    }
                    
                    },
            ),

!isloading?

  Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.yellow[200]),

    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
       crossAxisAlignment:CrossAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("Sun Rise  :"),
           SizedBox(width:5),
        Text((panchangmodel!.sunRise??'')),
    

      ],),

        Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("Sun Set  :"),
           SizedBox(width:5),
        Text((panchangmodel!.sunSet??'')),
    

      ],),

        SizedBox(height: 10,),

        Text("Weekday",style: TextStyle(fontSize: 16,color: Colors.black),),
    SizedBox(height: 5,),
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("Weekday Name  :"),
           SizedBox(width:5),
        Text((panchangmodel!.weekday!.weekdayName??'')),
    

      ],)
      ,
      SizedBox(height: 3,),
    
    
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Weekday Number  :"),
             SizedBox(width:5),
            Text((panchangmodel!.weekday!.weekdayNumber??0).toString()),
          ],
        ),
    
         SizedBox(height: 3,),
    
    
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Vedic weekday number  :"),
             SizedBox(width:5),
            Text((panchangmodel!.weekday!.vedicWeekdayNumber??0).toString()),
          ],
        ),
      SizedBox(height: 10,),

      Text("Lunar Month",style: TextStyle(fontSize: 16,color: Colors.black),),
    SizedBox(height: 5,),
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("Lunar month number  :"),
            SizedBox(width:5),
        Text((panchangmodel!.weekday!.weekdayName??'')),
    
      
      ],),

Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("lunar month name  :"),
             SizedBox(width:5),
            Text((panchangmodel!.weekday!.weekdayNumber??0).toString()),
          ],
        ),

SizedBox(height: 3,),
    
    
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("lunar month full name  :"),
             SizedBox(width:5),
            Text((panchangmodel!.weekday!.weekdayNumber??0).toString()),
          ],
        ),

          SizedBox(height: 10,),
      Text("Ritu",style: TextStyle(fontSize: 16,color: Colors.black),),
    SizedBox(height: 5,),

      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("Number  :"),
            SizedBox(width:5),
        Text((panchangmodel!.ritu!.number??0).toString()),
    
      ],),

         SizedBox(height: 3,),
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("Name  :"),
            SizedBox(width:5),
        Text((panchangmodel!.ritu!.name??'')),
    
      
    
      ],)
      ,
          SizedBox(height: 10,),
      Text("Tithi",style: TextStyle(fontSize: 16,color: Colors.black),),
    SizedBox(height: 5,),

      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("number  :"),
            SizedBox(width:5),
        Text((panchangmodel!.tithi!.number??0).toString()),
    
      ],),

    SizedBox(height: 5,),

      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("name  :"),
            SizedBox(width:5),
        Text((panchangmodel!.tithi!.name??'').toString()),
    
      ],),


       SizedBox(height: 5,),

      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("paksha  :"),
            SizedBox(width:5),
        Text((panchangmodel!.tithi!.paksha??'').toString()),
    
      ],),
        
SizedBox(height: 5,),

      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("Left precentage :"),
            SizedBox(width:5),
        Text((panchangmodel!.tithi!.leftPrecentage??0).toString()),
    
      ],),


SizedBox(height: 10,),
      Text("Nakshatra",style: TextStyle(fontSize: 16,color: Colors.black),),
    SizedBox(height: 5,),

 Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("name :"),
            SizedBox(width:5),
        Text((panchangmodel!.nakshatra!.name??'').toString()),
    
      ],),

SizedBox(height: 5,),

      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("number :"),
            SizedBox(width:5),
        Text((panchangmodel!.nakshatra!.number??0).toString()),
    
      ],),
       SizedBox(height: 5,),

 Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("Start date :"),
            SizedBox(width:5),
        Text((panchangmodel!.nakshatra!.startsAt??'').toString()),
    
      ],),
 SizedBox(height: 5,),

 Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("End date :"),
            SizedBox(width:5),
        Text((panchangmodel!.nakshatra!.endsAt??'').toString()),
    
      ],),

       SizedBox(height: 5,),

 Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("left_percentage :"),
            SizedBox(width:5),
        Text((panchangmodel!.nakshatra!.leftPercentage??0).toString()),
    
      ],),

      SizedBox(height: 10,),
      Text("Year",style: TextStyle(fontSize: 16,color: Colors.black),),
    SizedBox(height: 5,),

Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("Status :"),
            SizedBox(width:5),
        Text((panchangmodel!.year!.status??"").toString()),
    
      ],),
 SizedBox(height: 5,),

Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("Timestamp :"),
            SizedBox(width:5),
        Text((panchangmodel!.year!.timestamp??"").toString()),
    
      ],),
 SizedBox(height: 5,),

Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("saka salivahana number :"),
            SizedBox(width:5),
        Text((panchangmodel!.year!.sakaSalivahanaNumber??0).toString()),
    
      ],),
SizedBox(height: 5,),

Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("Saka salivahana year name :"),
            SizedBox(width:5),
        Text((panchangmodel!.year!.sakaSalivahanaYearName??"").toString()),
    
      ],),


SizedBox(height: 5,),

Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("Saka salivahana name number :"),
            SizedBox(width:5),
        Text((panchangmodel!.year!.sakaSalivahanaNameNumber??0).toString()),
    
      ],),




SizedBox(height: 5,),

Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("Vikram chaitradi number :"),
            SizedBox(width:5),
        Text((panchangmodel!.year!.vikramChaitradiNumber??0).toString()),
    
      ],),


SizedBox(height: 5,),

Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("Vikram chaitradi name number :"),
            SizedBox(width:5),
        Text((panchangmodel!.year!.vikramChaitradiNameNumber??0).toString()),
    
      ],),

SizedBox(height: 5,),

Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("Vikram chaitradi year name :"),
            SizedBox(width:5),
        Text((panchangmodel!.year!.vikramChaitradiYearName??"").toString()),
    
      ],),
       ],),
    ), ):SizedBox()

        ],),
      ),
      ),


    );
  
 
//  SizedBox(height: 5,),




// 
// 


                   
                    //:SizedBox()),



      });
    });
  }


}