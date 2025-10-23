import 'package:todo_app/core/database/hive_helper.dart';
import 'package:todo_app/features/tasks/data/models/task_model.dart';

/// Interfaz para el datasource local de tareas
abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getTasks();
  Future<List<TaskModel>> getTasksByStatus(bool completed);
  Future<TaskModel> getTaskById(int id);
  Future<TaskModel> insertTask(TaskModel task);
  Future<TaskModel> updateTask(TaskModel task);
  Future<void> deleteTask(int id);
  Future<void> insertTasks(List<TaskModel> tasks);
}

/// Implementación del datasource local usando Hive
class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final DatabaseHelper databaseHelper;

  TaskLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<TaskModel>> getTasks() async {
    final box = await databaseHelper.getTasksBox();
    return box.values.toList();
  }

  @override
  Future<List<TaskModel>> getTasksByStatus(bool completed) async {
    final box = await databaseHelper.getTasksBox();
    return box.values.where((task) => task.completed == completed).toList();
  }

  @override
  Future<TaskModel> getTaskById(int id) async {
    final box = await databaseHelper.getTasksBox();
    final task = box.get(id);
    
    if (task == null) {
      throw Exception('Task not found');
    }
    
    return task;
  }

  @override
  Future<TaskModel> insertTask(TaskModel task) async {
    final box = await databaseHelper.getTasksBox();
    await box.put(task.id, task);
    return task;
  }

  @override
  Future<TaskModel> updateTask(TaskModel task) async {
    final box = await databaseHelper.getTasksBox();
    await box.put(task.id, task);
    return task;
  }

  @override
  Future<void> deleteTask(int id) async {
    final box = await databaseHelper.getTasksBox();
    await box.delete(id);
  }

  @override
  Future<void> insertTasks(List<TaskModel> tasks) async {
    final box = await databaseHelper.getTasksBox();
    final map = {for (var task in tasks) task.id: task};
    await box.putAll(map);
  }
}
