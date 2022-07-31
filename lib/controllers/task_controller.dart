import 'package:get/get.dart';
import 'package:todo_app/db/db_helper.dart';
import 'package:todo_app/models/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  var taskList = <Task>[].obs;

//insert data to tale
  Future<int> addTask({Task? task}) async {
    return await DbHelper.insert(task);
  }

//get all data from table
  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DbHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void delete(Task task) async {
    await DbHelper.delete(task);
  }

  void updateRecord(int id) async {
    await DbHelper.update(id);
  }
}
