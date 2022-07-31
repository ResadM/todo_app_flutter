import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/task.dart';

class DbHelper {
  static Database? _database;
  static const int _version = 1;
  static const String _tableName = "tasks";
  static Future<void> initDb() async {
    if (_database != null) {
      return;
    }
    try {
      String path = "${await getDatabasesPath()}tasks.db";
      _database =
          await openDatabase(path, version: _version, onCreate: ((db, version) {
        print("Creating a new database");
        return db.execute("create table $_tableName ("
            "id integer primary key autoincrement, "
            "title string, note text, date string, startTime string, endTime string, "
            "remind integer, repeat string, "
            "color integer, "
            "isCompleted integer) ");
      }));
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task? task) async {
    print("insert function callled");
    return await _database?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("select function called");
    return await _database!.query(_tableName);
  }

  static delete(Task task) async {
    print("data deleted");
    await _database?.delete(_tableName, where: "id=?", whereArgs: [task.id]);
  }

  static update(int id) async {
    print("selected record updated");
    await _database?.rawUpdate(
        'UPDATE $_tableName SET isCompleted = ? WHERE id = ?', [1, id]);
  }
}
