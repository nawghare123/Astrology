import 'package:consultant_product/src/modules/user/KundaliPages/MatchMakingModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart' as intl;
import 'package:consultant_product/src/modules/user/KundaliPages/apiclass.dart';
import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:consultant_product/src/widgets/notififcation_icon.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:resize/resize.dart';
import '../../../controller/general_controller.dart';
import '../../../utils/colors.dart';
import '../home/logic.dart';
import 'package:intl/intl.dart' as intl;

class MatchMakingPage extends StatefulWidget {
  const MatchMakingPage({Key? key}) : super(key: key);

  @override
  State<MatchMakingPage> createState() => _MatchMakingPageState();
}

class _MatchMakingPageState extends State<MatchMakingPage> {

   TextEditingController dateControllerMale = TextEditingController();


  TextEditingController timeinputMale = TextEditingController(); 


   TextEditingController dateControllerFemale = TextEditingController();


  TextEditingController timeinputFemale = TextEditingController(); 
  bool isloading = false; 
  MatchMakingModel? matchmakingmodel;
 
 final timeFormat = intl.DateFormat.jm();
  bool timeValidator = false;
TimeOfDay initialTime = TimeOfDay.now();


  @override
  void initState() {
   
    super.initState();
     setState(() {
      isloading = true;
      // timeinput.text = "";
    });
    }
 
 
  Future<void> matchmaking(maleYear, maletime, femaleYear,femaletime) async {
    
    matchmakingmodel = await ApiKundali.matchmakingclass(maleYear, maletime,femaleYear,femaletime);
    

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
                                    Text(LanguageConstant.matchmaking.tr,
                               style:     TextStyle(
        fontFamily: SarabunFontFamily.bold,
        fontSize: 28.sp,
        color: customLightThemeColor)
                                        ),
                                    SizedBox(
                                      height: 20.h,
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
                body: 
             
                ListView(
                    padding: EdgeInsetsDirectional.fromSTEB(15.w, 10.h, 15.w, 0.h),
                    children:  [
SizedBox(height: 5.h,),
// Male

                       Text("Male"),

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
            controller: dateControllerMale,
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
                          dateControllerMale.text = formattedDate;
                        });
                      } else {}},




          )
                                          
                                     
                                        ),
                                      ),
                                    ),


                                  Expanded(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
                                            10.w, 0, 0.w, 16.h),
          child: TextField(
        readOnly: true,
        
                    controller: timeinputMale, //editing controller of this TextField
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
                            timeinputMale.text = formattedTime; 
                          });
                      }else{
                          print("Time is not selected");
                      }
                    },
                 ),
        ),
      )


                                  
                                               
                                 ],
                               ),
    


// Female
                       Text("Female"),

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
            controller: dateControllerFemale,
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
                          dateControllerFemale.text = formattedDate;
                        });
                      } else {}},




          )
                                          
                                     
                                        ),
                                      ),
                                    ),


                                  Expanded(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
                                            10.w, 0, 0.w, 16.h),
          child: TextField(
        readOnly: true,
                    controller: timeinputFemale, //editing controller of this TextField
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
                            timeinputFemale.text = formattedTime; 
                          });
                      }else{
                          print("Time is not selected");
                      }
                    },
                 ),
        ),
      )


                                  
                                               
                                 ],
                               ),
    

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
             
    if (timeinputMale.text.length <= 0) {
    msg = 'Please choose time';
    }
     
    else if (dateControllerMale.text.length <= 0 ) {
      msg = 'Please choose date';
    }

    else  {
      print("print1");
   print(dateControllerMale.text);
   print(timeinputMale.text);
     await matchmaking(dateControllerMale.text ?? '',timeinputMale.text ?? '', dateControllerFemale.text ?? '',timeinputFemale.text ?? '');
      
     
    }
                    
                    },
            ),
  SizedBox(height: 10,),
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
           Text("Total Score  :"),
           SizedBox(width:5),
        Text((matchmakingmodel!.output!.totalScore??0).toString()),
    

      ],),

        Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("Out of  :"),
           SizedBox(width:5),
        Text((matchmakingmodel!.output!.outOf??0).toString()),
      ],),

      // ],),

      //   SizedBox(height: 10,),

        Text("Varna kootam",style: TextStyle(fontSize: 16,color: Colors.black),),


    SizedBox(height: 5,),

    Text("Bride",style: TextStyle(fontSize: 16,color: Colors.black),),
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("moon sign number  :"),
           SizedBox(width:5),
        Text((matchmakingmodel!.output!.varnaKootam!.bride!.moonSignNumber??0).toString()),
    

      ],)
      ,
      SizedBox(height: 3,),
    
    
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Moon sign  :"),
             SizedBox(width:5),
            Text((matchmakingmodel!.output!.varnaKootam!.bride!.moonSign??"").toString()),
          ],
        ),
    
         SizedBox(height: 3,),
    
    
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Varnam  :"),
             SizedBox(width:5),
            Text((matchmakingmodel!.output!.varnaKootam!.bride!.varnam??0).toString()),
          ],
        ),
      SizedBox(height: 10,),

       Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Varnam name  :"),
             SizedBox(width:5),
            Text((matchmakingmodel!.output!.varnaKootam!.bride!.varnamName??'').toString()),
          ],
        ),



 SizedBox(height: 5,),

    Text("Groom",style: TextStyle(fontSize: 16,color: Colors.black),),
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("moon sign number  :"),
           SizedBox(width:5),
        Text((matchmakingmodel!.output!.varnaKootam!.bride!.moonSignNumber??0).toString()),
    

      ],)
      ,
      SizedBox(height: 3,),
    
    
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Moon sign  :"),
             SizedBox(width:5),
            Text((matchmakingmodel!.output!.varnaKootam!.bride!.moonSign??"").toString()),
          ],
        ),
    
         SizedBox(height: 3,),
    
    
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Varnam  :"),
             SizedBox(width:5),
            Text((matchmakingmodel!.output!.varnaKootam!.bride!.varnam??0).toString()),
          ],
        ),
      SizedBox(height: 10,),

       Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Varnam name  :"),
             SizedBox(width:5),
            Text((matchmakingmodel!.output!.varnaKootam!.bride!.varnamName??'').toString()),
          ],
        ),


  
       Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Out of :"),
             SizedBox(width:5),
            Text((matchmakingmodel!.output!.varnaKootam!.outOf??0).toString()),
          ],
        ),


   Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Score :"),
             SizedBox(width:5),
            Text((matchmakingmodel!.output!.varnaKootam!.score??0).toString()),
          ],
        ),



    

        
    Text("Tara kootam",style: TextStyle(fontSize: 16,color: Colors.black),),


    SizedBox(height: 5,),

    Text("Bride",style: TextStyle(fontSize: 16,color: Colors.black),),
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("star number  :"),
           SizedBox(width:5),
        Text((matchmakingmodel!.output!.varnaKootam!.bride!.moonSignNumber??0).toString()),
    

      ],)
      ,
      SizedBox(height: 3,),
    
    
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Moon sign  :"),
             SizedBox(width:5),
            Text((matchmakingmodel!.output!.varnaKootam!.bride!.moonSign??"").toString()),
          ],
        ),
    
         SizedBox(height: 3,),
    
    
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Varnam  :"),
             SizedBox(width:5),
            Text((matchmakingmodel!.output!.varnaKootam!.bride!.varnam??0).toString()),
          ],
        ),
      SizedBox(height: 10,),

       Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Varnam name  :"),
             SizedBox(width:5),
            Text((matchmakingmodel!.output!.varnaKootam!.bride!.varnamName??'').toString()),
          ],
        ),



 SizedBox(height: 5,),

    Text("Groom",style: TextStyle(fontSize: 16,color: Colors.black),),
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text("moon sign number  :"),
           SizedBox(width:5),
        Text((matchmakingmodel!.output!.varnaKootam!.bride!.moonSignNumber??0).toString()),
    

      ],)
      ,
      SizedBox(height: 3,),
    
    
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Moon sign  :"),
             SizedBox(width:5),
            Text((matchmakingmodel!.output!.varnaKootam!.bride!.moonSign??"").toString()),
          ],
        ),
    
         SizedBox(height: 3,),
    
    
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Varnam  :"),
             SizedBox(width:5),
            Text((matchmakingmodel!.output!.varnaKootam!.bride!.varnam??0).toString()),
          ],
        ),
      SizedBox(height: 10,),

       Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Varnam name  :"),
             SizedBox(width:5),
            Text((matchmakingmodel!.output!.varnaKootam!.bride!.varnamName??'').toString()),
          ],
        ),


  
       Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Out of :"),
             SizedBox(width:5),
            Text((matchmakingmodel!.output!.varnaKootam!.outOf??0).toString()),
          ],
        ),


   Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Score :"),
             SizedBox(width:5),
            Text((matchmakingmodel!.output!.varnaKootam!.score??0).toString()),
          ],
        ),
                    ]))):SizedBox()

       
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