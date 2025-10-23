import 'package:fpdart/fpdart.dart' hide Task;
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/tasks/domain/entities/task.dart';
import 'package:todo_app/features/tasks/domain/repositories/task_repository.dart';

/// Caso de uso para obtener tareas filtradas por estado
class GetTasksByStatus implements UseCase<List<Task>, TaskFilterParams> {
  final TaskRepository repository;

  GetTasksByStatus(this.repository);

  @override
  Future<Either<Failure, List<Task>>> call(TaskFilterParams params) async {
    return await repository.getTasksByStatus(params.completed);
  }
}

class TaskFilterParams {
  final bool completed;

  const TaskFilterParams({required this.completed});
}
