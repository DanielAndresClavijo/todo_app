import 'dart:convert';
import 'package:hive_ce/hive.dart';
import 'package:todo_app/features/tasks/data/models/task_model.dart';

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 0;

  @override
  TaskModel read(BinaryReader reader) {
    final jsonString = reader.readString();
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return TaskModel.fromJson(json);
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    final jsonString = jsonEncode(obj.toJson());
    writer.writeString(jsonString);
  }
}
