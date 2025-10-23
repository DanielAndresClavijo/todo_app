import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';

/// Entidad de tarea
@freezed
class Task with _$Task {
  const factory Task({
    required int id,
    required int userId,
    required String title,
    required bool completed,
  }) = _Task;
}
