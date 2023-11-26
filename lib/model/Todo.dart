import 'package:hive/hive.dart';

part 'Todo.g.dart';

@HiveType(typeId: 0)
class ToDoModel extends HiveObject {
  @HiveField(0)
  final String Title;

  @HiveField(1)
  final String Desc;

  ToDoModel({required this.Title, required this.Desc});
}