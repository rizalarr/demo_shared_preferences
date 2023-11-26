import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:demo_shared_preferences/model/Todo.dart';
import 'package:demo_shared_preferences/main.dart';

class addTodo extends StatefulWidget {
  const addTodo({super.key});

  @override
  State<addTodo> createState() => _addTodoState();
}

class _addTodoState extends State<addTodo> {
  final TextEditingController _TitleController = TextEditingController();
  final TextEditingController _DescController = TextEditingController();

  late Box<ToDoModel> _myBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myBox = Hive.box(boxName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add ToDo"),
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: _TitleController,
              decoration: InputDecoration(label: Text("Title")),
            ),
            TextFormField(
              controller: _DescController,
              decoration: InputDecoration(label: Text("Description")),
            ),
            SizedBox(
              height: 30,
            ),
            OutlinedButton(
              onPressed: () {
                _myBox.add(
                  ToDoModel(
                    Title: _TitleController.text,
                    Desc: _DescController.text,
                  ),
                );
                Navigator.pop(context);
              },
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
