import 'package:demo49/screens/homepage/modal/home_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxString month_name = "".obs;
  RxBool change_leading = false.obs;
  List<HomeModal> l1 = [];
  TextEditingController edit_task_name = TextEditingController();
  RxInt pedding_count = 0.obs;
  RxInt done_count = 0.obs;

  RxInt? pendding_data() {
    // print("====================object ${l1}");
    // homeController.l1[index].status == "0"
    for (int i = 0; i < l1.length; i++) {
      // print("heloooooooooooooooooooo");
      if (l1[i].status == "0") {
        // print("heloooooooooooooooooooo");
        return pedding_count++;
      } else {
        // return done_count++;
      }
    }
  }

  void change_icon() {
    change_leading.value = !change_leading.value;
    update();
  }

  /// month wise
  void date_condition(month) {
    if (month == 1) {
      month_name.value = 'January';
    } else if (month == 2) {
      month_name.value = 'February';
    } else if (month == 3) {
      month_name.value = 'March';
    } else if (month == 4) {
      month_name.value = 'April';
    } else if (month == 5) {
      month_name.value = 'May';
    } else if (month == 6) {
      month_name.value = 'June';
    } else if (month == 7) {
      month_name.value = 'july';
    } else if (month == 8) {
      month_name.value = 'August';
    } else if (month == 9) {
      month_name.value = 'September';
    } else if (month == 10) {
      month_name.value = 'October';
    } else if (month == 11) {
      month_name.value = 'November';
    } else if (month == 12) {
      month_name.value = 'December';
    }
    update();
  }
}
