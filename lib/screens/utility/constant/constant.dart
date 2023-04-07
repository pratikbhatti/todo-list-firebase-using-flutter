import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:demo49/screens/utility/constant/style_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Contansts {
  Contansts._();
  static Contansts contansts = Contansts._();
  void errorToast({required String errorName}) {
    Fluttertoast.showToast(
      msg: errorName,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: StyleColor.red,
      textColor: StyleColor.white,
    );
  }

  void awesome_dialog({
    required BuildContext context,
    required String title,
  }) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: "$title",
        btnOkOnPress: () {
          Get.back();
        })
      ..show();
  }

  void awesome_dialog_pendding_task({
    required BuildContext context,
    required String title,
  }) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.rightSlide,
        title: "$title",
        btnOkOnPress: () {
          Get.back();
        })
      ..show();
  }
}
