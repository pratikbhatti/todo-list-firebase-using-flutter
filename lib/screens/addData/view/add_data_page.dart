import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:demo49/screens/addData/controller/add_data_controller.dart';
import 'package:demo49/screens/homepage/view/home_page.dart';
import 'package:demo49/screens/utility/constant/constant.dart';
import 'package:demo49/screens/utility/constant/style_color.dart';
import 'package:demo49/screens/utility/helper/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  AddDataController addDataController = Get.put(AddDataController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: StyleColor.black,
        appBar: AppBar(
          backgroundColor: StyleColor.black,
          title: Text(
            "Add Task",
            style: TextStyle(color: StyleColor.white),
          ),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.off(
                HomePage(),
                transition: Transition.upToDown,
                duration: Duration(milliseconds: 500),
              );
            },
            icon: Icon(
              Icons.arrow_back,
              color: StyleColor.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  controller: addDataController.addTasktxt,
                  style: TextStyle(color: StyleColor.white),
                  decoration: InputDecoration(
                    labelText: 'Task Name',
                    labelStyle: TextStyle(color: StyleColor.grey),
                    hintText: 'Enter Task Name',
                    hintStyle: TextStyle(color: StyleColor.grey),
                    prefixIcon: Icon(Icons.edit),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: StyleColor.grey),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide: new BorderSide(color: StyleColor.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      borderSide: BorderSide(
                        width: 1,
                        color: StyleColor.greyShade700,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (addDataController.addTasktxt.text.isEmpty) {
                          Contansts.contansts
                              .errorToast(errorName: "Please Enter Task");
                        } else {
                          FirebaseHelper.firebaseHelper.addData(
                              task_name: addDataController.addTasktxt.text,
                              status: "0");
                          Contansts.contansts.awesome_dialog(
                            context: context,
                            title: "Task Added Successfully",
                          );
                          Get.back();
                        }
                      },
                      child: Text("Add"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.off(
                          HomePage(),
                        );
                      },
                      child: Text("Cancel"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
