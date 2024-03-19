
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:resize/resize.dart';

class TimeLogic extends GetxController {


  final TextEditingController chargesController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  ///---------------------------------------get-appointment-types
  String? selectedScheduleType;
  int? selectedScheduleTypeId;
  List<String> scheduleTypeDropDownList = [];
  updateScheduleTypeDropDownList(String newValue) {
    scheduleTypeDropDownList.add(newValue);
    update();
  }
  emptyScheduleTypeDropDownList() {
    scheduleTypeDropDownList = [];
    update();
  }



  Iterable<TimeOfDay> getTimes(TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += step.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }

  List slotsList = [];

  int? selectedDayForScheduleIndex;
  String? selectedAvailableDay;
  List<String> availableDaysList = [];
  updateAvailableDaysList(String? newValue) {
    availableDaysList.add(newValue!);
    update();
  }
  emptyAvailableDaysList() {
    availableDaysList = [];
    update();
  }

  List<DaySelectorForScheduleModel> dayListForHoliday = [
    DaySelectorForScheduleModel(
        title: 'M',
        slug:'monday',
        isSelected: false,
        isCompleted: false
    ),
    DaySelectorForScheduleModel(
        title: 'T',
        slug:'tuesday',
        isSelected: false,
        isCompleted: false
    ),
    DaySelectorForScheduleModel(
        title: 'W',
        slug:'wednesday',
        isSelected: false,
        isCompleted: false
    ),
    DaySelectorForScheduleModel(
        title: 'T',
        slug:'thursday',
        isSelected: false,
        isCompleted: false
    ),
    DaySelectorForScheduleModel(
        title: 'F',
        slug:'friday',
        isSelected: false,
        isCompleted: false
    ),
    DaySelectorForScheduleModel(
        title: 'S',
        slug:'saturday',
        isSelected: false,
        isCompleted: false
    ),
    DaySelectorForScheduleModel(
        title: 'S',
        slug:'sunday',
        isSelected: false,
        isCompleted: false
    ),
  ];

  int? shiftIndex = 0;
  updateScheduleShiftIndex(int newValue) {
    shiftIndex = newValue;
    update();
  }

  String? selectedTimeForStart;
  String? selectedTimeForStartForCalculate;
  String? selectedTimeForEnd;
  String? selectedTimeForEndForCalculate;






  ScrollController? scrollController;
  bool lastStatus = true;
  double height = 100.h;

  bool get isShrink {
    return scrollController!.hasClients &&
        scrollController!.offset > (height - kToolbarHeight);
  }

  void scrollListener() {
    if (isShrink != lastStatus) {
      lastStatus = isShrink;
      update();
    }
  }
}
class DaySelectorForScheduleModel {
  DaySelectorForScheduleModel({this.title, this.slug, this.isSelected, this.isCompleted});

  String? title;
  String? slug;
  bool? isSelected;
  bool? isCompleted;
}

