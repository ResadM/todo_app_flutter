import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:todo_app/db/db_helper.dart';
import 'package:todo_app/ui/home_screen.dart';
import 'package:todo_app/ui/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo',
      theme: Themes.light,
      home: const HomaScreen(),
    );
  }
}
