import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:demo_shared_preferences/model/Todo.dart';

String boxName = "To Do Box";

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<ToDoModel>(ToDoModelAdapter());
  await Hive.openBox<ToDoModel>(boxName);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyLoginPage(),
    );
  }
}
