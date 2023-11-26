import 'package:demo_shared_preferences/model/Todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginPage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
//import 'package:demo_shared_preferences/Models/Todo.dart';
import 'package:demo_shared_preferences/addTodo.dart';
import 'package:demo_shared_preferences/main.dart';



class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});

  @override
  _MyDashboardState createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  late SharedPreferences logindata;
  late String username;
  late Box<ToDoModel> _myBox;
  @override
  void initState() {
// TODO: implement initState
    super.initState();
     _myBox = Hive.box(boxName);
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(automaticallyImplyLeading: false,
        title: Text("Shared Preference Example"),
        actions: [
          IconButton(
            onPressed: () {
              logindata.setBool('login', true);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyLoginPage()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: 
      ValueListenableBuilder(
        valueListenable: _myBox.listenable(),
        builder: (BuildContext, value, child) {
          if (_myBox.values.isEmpty) {
            return Center(
              child: Text("File Empty"),
            );
          }
          return ListView.builder(
              itemCount: _myBox.values.length,
              itemBuilder: (context, index) {
                ToDoModel? res = _myBox.getAt(index);
                return Dismissible(
                    onDismissed: (direction) {
                      _myBox.deleteAt(index);
                    },
                    key: UniqueKey(),
                    child: ListTile(
                      title: Text("Title: ${res!.Title}"),
                      subtitle: Text("description: ${res.Desc}"),
                    ));
              });
        },
        //  child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     OutlinedButton(
        //       onPressed: () {
        //         logindata.setBool('login', true);
        //         Navigator.pushReplacement(context,
        //             new MaterialPageRoute(builder: (context) => MyLoginPage()));
        //       },
        //       child: Text('LogOut'),
        //     )
        //   ],
        // ),  
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return addTodo();
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}



