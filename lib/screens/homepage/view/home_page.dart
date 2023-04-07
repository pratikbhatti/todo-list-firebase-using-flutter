import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo49/screens/addData/view/add_data_page.dart';
import 'package:demo49/screens/homepage/controller/home_controller.dart';
import 'package:demo49/screens/homepage/modal/home_modal.dart';
import 'package:demo49/screens/utility/constant/constant.dart';
import 'package:demo49/screens/utility/constant/style_color.dart';
import 'package:demo49/screens/utility/helper/firebase_helper.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
    homeController.date_condition(DateTime.now().month);

    // print(homeController.pedding_count);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: StyleColor.black,
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Container(
                      alignment: Alignment.center,
                      child: Text(
                        "${homeController.month_name.value}, ${DateTime.now().day},  ${DateTime.now().year}",
                        style: GoogleFonts.poppins(
                            color: StyleColor.textColor,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 3.5.w,
                  ),
                ],
              ),
              DottedLine(
                lineThickness: 2.7,
                dashColor: StyleColor.white,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 5, right: 5),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       // Obx(
              //       //   () => Text(
              //       //     "${homeController.pedding_count}",
              //       //     style: TextStyle(
              //       //         color: StyleColor.white,
              //       //         fontSize: 25.sp,
              //       //         fontWeight: FontWeight.bold),
              //       //   ),
              //       // ),
              //       Text(
              //         "${homeController.done_count}",
              //         style: TextStyle(
              //             color: StyleColor.white,
              //             fontSize: 25.sp,
              //             fontWeight: FontWeight.bold),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 3,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 5, right: 5),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         "Pendding Task",
              //         style: TextStyle(
              //             color: StyleColor.textColor,
              //             fontSize: 12.sp,
              //             fontWeight: FontWeight.bold),
              //       ),
              //       Text(
              //         "Complete Task",
              //         style: TextStyle(
              //             color: StyleColor.textColor,
              //             fontSize: 12.sp,
              //             fontWeight: FontWeight.bold),
              //       ),
              //     ],
              //   ),
              // ),
              StreamBuilder(
                stream: FirebaseHelper.firebaseHelper.readData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Data Not Found");
                  } else if (snapshot.hasData) {
                    QuerySnapshot? rawData = snapshot.data;
                    homeController.l1.clear();

                    var docs = rawData!.docs;
                    // homeController.pedding_count.value = 0;
                    for (var x in docs) {
                      HomeModal d1 = HomeModal(
                          task_name: x['task_name'],
                          status: x['status'],
                          id: x.id);

                      homeController.l1.add(d1);
                    }

                    // for (int i = 0; i < homeController.l1.length; i++) {
                    //   // print("heloooooooooooooooooooo");
                    //   if (homeController.l1[i].status == "0") {
                    //     // print("heloooooooooooooooooooo");
                    //     homeController.pedding_count.value++;
                    //   } else {
                    //     // return done_count++;
                    //   }
                    // }
                    // print("${homeController.l1[0].status}");
                  }
                  return ListView.builder(
                    itemCount: homeController.l1.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 30,
                        child: ListTile(
                          leading: (homeController.l1[index].status == "0")
                              ? IconButton(
                                  onPressed: () {
                                    // homeController.pendding_data();s
                                    // homeController.pedding_count.value = 0;
                                    FirebaseHelper.firebaseHelper.updateStatus(
                                        id: homeController.l1[index].id!,
                                        status: "1");
                                    Contansts.contansts.awesome_dialog(
                                      context: context,
                                      title: "Congress Task Your Task Is Done",
                                    );
                                  },
                                  icon: Icon(
                                    Icons.check_circle_outline,
                                    color: StyleColor.grey,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    FirebaseHelper.firebaseHelper.updateStatus(
                                        id: homeController.l1[index].id!,
                                        status: "0");
                                    Contansts.contansts
                                        .awesome_dialog_pendding_task(
                                            context: context,
                                            title: "Pending Task");
                                  },
                                  icon: Icon(
                                    Icons.check_circle,
                                    color: StyleColor.green,
                                  ),
                                ),
                          title: Text(
                            "${homeController.l1[index].task_name}",
                            style: TextStyle(
                                color: (homeController.l1[index].status == "0")
                                    ? StyleColor.black
                                    : StyleColor.grey),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  homeController.edit_task_name.text =
                                      homeController.l1[index].task_name!;
                                  Get.defaultDialog(
                                    title: "Edit Task",
                                    content: Column(
                                      children: [
                                        TextFormField(
                                          controller:
                                              homeController.edit_task_name,
                                          decoration: InputDecoration(
                                            labelText: 'Task Name',
                                            labelStyle: TextStyle(
                                                color: StyleColor.grey),
                                            hintText: 'Enter Task Name',
                                            hintStyle: TextStyle(
                                                color: StyleColor.grey),
                                            prefixIcon: Icon(Icons.edit),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: StyleColor.grey),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            border: new OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              ),
                                              borderSide: new BorderSide(
                                                  color: StyleColor.grey),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                if (homeController
                                                    .edit_task_name
                                                    .text
                                                    .isEmpty) {
                                                  Contansts.contansts.errorToast(
                                                      errorName:
                                                          "Please Enter Task Name");
                                                } else {
                                                  FirebaseHelper.firebaseHelper
                                                      .updateData(
                                                          id: homeController
                                                              .l1[index].id!,
                                                          task_name:
                                                              homeController
                                                                  .edit_task_name
                                                                  .text);
                                                  Get.back();
                                                  Contansts.contansts
                                                      .awesome_dialog(
                                                    context: context,
                                                    title:
                                                        "Task Edit Successfully",
                                                  );
                                                }
                                              },
                                              child: Text("Edit"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text("Cancel"),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: StyleColor.grey,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  FirebaseHelper.firebaseHelper.deleteData(
                                      id: homeController.l1[index].id!);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: StyleColor.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(
              AddData(),
              transition: Transition.downToUp,
              duration: Duration(milliseconds: 500),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
