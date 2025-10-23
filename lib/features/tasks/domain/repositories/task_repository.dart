import 'package:fpdart/fpdart.dart' hide Task;
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/tasks/domain/entities/task.dart';

/// Repositorio de tareas
abstract class TaskRepository {
  /// Obtiene todas las tareas (desde API o local)
  Future<Either<Failure, List<Task>>> getTasks();

  /// Obtiene tareas filtradas por estado
  Future<Either<Failure, List<Task>>> getTasksByStatus(bool completed);

  /// Obtiene una tarea por ID
  Future<Either<Failure, Task>> getTaskById(int id);

  /// Crea una nueva tarea
  Future<Either<Failure, Task>> createTask(Task task);

  /// Actualiza una tarea existente
  Future<Either<Failure, Task>> updateTask(Task task);

  /// Elimina una tarea
  Future<Either<Failure, void>> deleteTask(int id);

  /// Sincroniza tareas desde la API
  Future<Either<Failure, List<Task>>> syncTasksFromApi();
}
