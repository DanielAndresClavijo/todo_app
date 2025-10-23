import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:todo_app/features/tasks/data/models/task_model.dart';

/// Helper para gestionar la base de datos Hive (cross-platform)
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static const String _tasksBoxName = 'tasks';

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  /// Inicializa Hive
  Future<void> init() async {
    await Hive.initFlutter();
    // El adapter se genera automáticamente con build_runner
  }

  /// Obtiene la caja de tareas
  Future<Box<TaskModel>> getTasksBox() async {
    if (!Hive.isBoxOpen(_tasksBoxName)) {
      return await Hive.openBox<TaskModel>(_tasksBoxName);
    }
    return Hive.box<TaskModel>(_tasksBoxName);
  }

  /// Cierra todas las cajas
  Future<void> close() async {
    await Hive.close();
  }
}
