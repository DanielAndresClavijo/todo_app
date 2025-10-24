import 'package:fpdart/fpdart.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/tasks/domain/repositories/task_repository.dart';

/// Caso de uso para eliminar una tarea
class DeleteTask implements UseCase<void, int> {
  final TaskRepository repository;

  DeleteTask(this.repository);

  @override
  Future<Either<Failure, void>> call(int taskId) async {
    return await repository.deleteTask(taskId);
  }
}
