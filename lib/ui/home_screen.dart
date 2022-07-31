import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/services/notification_services.dart';
import 'package:todo_app/ui/add_task_screen.dart';
import 'package:todo_app/ui/task_tile.dart';
import 'package:todo_app/ui/theme.dart';
import 'package:todo_app/ui/widgets/button.dart';

import '../models/task.dart';

class HomaScreen extends StatefulWidget {
  const HomaScreen({Key? key}) : super(key: key);

  @override
  State<HomaScreen> createState() => _HomaScreenState();
}

class _HomaScreenState extends State<HomaScreen> {
  var notifyHelper;
  final _taskController = Get.put(TaskController());
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: listBgColor,
      appBar: _appBar(),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(color: bgColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(DateTime.now()),
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                          color: listBgColor,
                          fontSize: 16,
                        )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Today",
                        style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                          color: listBgColor,
                          fontSize: 20,
                        )),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      MyButton(
                          buttonText: "+ Add Task",
                          onTap: () async {
                            await Get.to(() => const AddTask());
                            _taskController.getTasks();
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: bgColor),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: DatePicker(
              DateTime.now(),
              height: 80,
              width: 50,
              initialSelectedDate: DateTime.now(),
              selectionColor: buttonColor,
              selectedTextColor: Colors.white,
              dayTextStyle: GoogleFonts.lato(
                  textStyle:
                      const TextStyle(color: Colors.white, fontSize: 12)),
              dateTextStyle: GoogleFonts.lato(
                  textStyle: const TextStyle(color: Colors.white)),
              monthTextStyle: GoogleFonts.lato(
                  textStyle:
                      const TextStyle(color: Colors.white, fontSize: 12)),
              onDateChange: (selectedDate) => {print(selectedDate)},
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: bgColor),
            height: 45,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 30, top: 10),
              decoration: const BoxDecoration(
                  color: listBgColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(150),
                      topRight: Radius.circular(150))),
              child: Text(
                "Task List",
                style: textStyle1.copyWith(color: textColor.withOpacity(0.5)),
              ),
            ),
          ),
          Expanded(child: Obx(() {
            return ListView.builder(
                itemCount: _taskController.taskList.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                      onTap: () {
                        _showBottomSheet(
                            context, _taskController.taskList[index]);
                      },
                      child: TaskTile(
                        task: _taskController.taskList[index],
                      ));
                }));
          }))
        ],
      ),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 4),
      height: task.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.18
          : MediaQuery.of(context).size.height * 0.24,
      color: Colors.white,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.grey),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            task.isCompleted == 1
                ? Container()
                : Container(
                    padding: const EdgeInsets.only(left: 32, right: 32),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                      onPressed: () {
                        _taskController.updateRecord(task.id!);
                        _taskController.getTasks();
                        Get.back();
                      },
                      child: const Text('Task Completed'),
                    ),
                  ),
            const SizedBox(
              height: 2,
            ),
            Container(
              padding: const EdgeInsets.only(left: 32, right: 32),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 12),
                    primary: Colors.red),
                onPressed: () {
                  _taskController.delete(task);
                  _taskController.getTasks();
                  Get.back();
                },
                child: const Text('Delete Task'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(left: 32, right: 32),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 12),
                    primary: Colors.white,
                    side: const BorderSide(
                      width: 0.5,
                      color: Colors.grey,
                    )),
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        )
      ]),
    ));
  }

  _appBar() {
    return AppBar(
      backgroundColor: bgColor,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          notifyHelper.displayNotification(
              title: "Test Notification", body: "Test body");
          notifyHelper.scheduledNotification();
        },
        child: const Icon(
          Icons.nightlight_round,
          size: 20,
        ),
      ),
      actions: [
        GestureDetector(
          child: const Icon(
            Icons.person,
            size: 20,
          ),
        ),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }
}
