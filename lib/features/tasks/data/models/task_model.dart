import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/features/tasks/domain/entities/task.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

/// Modelo de datos para tareas con Freezed
@freezed
class TaskModel with _$TaskModel {
  const TaskModel._();

  const factory TaskModel({
    required int id,
    required int userId,
    required String title,
    required bool completed,
  }) = _TaskModel;

  /// Constructor desde JSON
  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  /// Constructor desde entidad
  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      userId: task.userId,
      title: task.title,
      completed: task.completed,
    );
  }

  /// Convertir a entidad
  Task toEntity() {
    return Task(
      id: id,
      userId: userId,
      title: title,
      completed: completed,
    );
  }
}
