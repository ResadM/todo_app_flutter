import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/ui/theme.dart';
import 'package:todo_app/ui/widgets/button.dart';
import 'package:todo_app/ui/widgets/input_field.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _currentDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepet = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: pageColor,
      // appBar: AppBar(
      //   backgroundColor: pageColor,
      //   elevation: 0,
      // ),
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add New Task",
              style: textStyle1,
            ),
            CustomInputField(
              title: "Title",
              hint: "Enter your title",
              controller: _titleController,
            ),
            CustomInputField(
              title: "Note",
              hint: "Enter your note",
              controller: _noteController,
            ),
            CustomInputField(
              title: "Date",
              hint: DateFormat.yMd().format(_currentDate),
              widget: IconButton(
                onPressed: () {
                  _getDateFromUser();
                },
                icon: const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomInputField(
                    title: "Start Time",
                    hint: _startTime,
                    widget: IconButton(
                      onPressed: () {
                        _getStartTimeFromUser();
                      },
                      icon: const Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: CustomInputField(
                    title: "End Time",
                    hint: _endTime,
                    widget: IconButton(
                      onPressed: () {
                        _getEndTimeFromUser();
                      },
                      icon: const Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CustomInputField(
                title: "Remind",
                hint: "$_selectedRemind minutes early",
                widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRemind = int.parse(newValue!);
                    });
                  },
                  underline: Container(height: 0),
                  items: remindList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                )),
            CustomInputField(
                title: "Repeat",
                hint: _selectedRepet,
                widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepet = newValue!;
                    });
                  },
                  underline: Container(height: 0),
                  items:
                      repeatList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(
                        value,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    );
                  }).toList(),
                )),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Repeat ",
                      style: textStyle3,
                    ),
                    Text(
                      " *Test Dropdown",
                      style: textStyle3.copyWith(color: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey, width: 1.0)),
                  child: Container(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedRepet,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      elevation: 16,
                      style: textStyle3,
                      underline: Container(
                        height: 0,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRepet = newValue!;
                        });
                      },
                      items: repeatList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Color",
                      style: textStyle3,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 3,
                      children: List<Widget>.generate(3, (int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedColor = index;
                            });
                          },
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: index == 0
                                ? Colors.green
                                : index == 1
                                    ? Colors.blue
                                    : Colors.red,
                            child: _selectedColor == index
                                ? const Icon(
                                    Icons.done,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                : Container(),
                          ),
                        );
                      }),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    MyButton(buttonText: "Save", onTap: () => _validateDate())
                  ],
                )
              ],
            )
          ],
        )),
      ),
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: const Icon(
            Icons.error_outline_rounded,
            color: Colors.white,
          ));
    }
  }

  _addTaskToDb() async {
    int value = await _taskController.addTask(
        task: Task(
            note: _noteController.text,
            title: _titleController.text,
            date: DateFormat.yMd().format(_currentDate),
            startTime: _startTime,
            endTime: _endTime,
            remind: _selectedRemind,
            repeat: _selectedRepet,
            isCompleted: 0));

    print("Inserted id is $value");
  }

  _appBar() {
    return AppBar(
      backgroundColor: bgColor,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: const Icon(
          Icons.arrow_back_ios_new,
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

  _getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: _currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2121));

    if (pickerDate != null) {
      setState(() {
        _currentDate = pickerDate;
      });
    }
  }

  _getStartTimeFromUser() async {
    TimeOfDay? pickertime = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.dial,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])));

    if (pickertime != null) {
      setState(() {
        _startTime = pickertime.format(context);
      });
    }
  }

  _getEndTimeFromUser() async {
    TimeOfDay? pickertime = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.dial,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_endTime.split(":")[0]),
            minute: int.parse(_endTime.split(":")[1].split(" ")[0])));

    if (pickertime != null) {
      setState(() {
        _endTime = pickertime.format(context);
      });
    }
  }
}
