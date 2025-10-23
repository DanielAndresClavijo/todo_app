import 'package:fpdart/fpdart.dart' hide Task;
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/tasks/domain/entities/task.dart';
import 'package:todo_app/features/tasks/domain/repositories/task_repository.dart';
import 'package:todo_app/features/tasks/data/datasources/task_local_datasource.dart';
import 'package:todo_app/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:todo_app/features/tasks/data/models/task_model.dart';

/// Implementación del repositorio de tareas
class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Task>>> getTasks() async {
    try {
      // Intentar obtener de la base de datos local primero
      final localTasks = await localDataSource.getTasks();
      
      // Si no hay tareas locales, sincronizar desde la API
      if (localTasks.isEmpty) {
        return await syncTasksFromApi();
      }
      
      return Right(localTasks.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(Failure.database(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Task>>> getTasksByStatus(bool completed) async {
    try {
      final tasks = await localDataSource.getTasksByStatus(completed);
      return Right(tasks.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(Failure.database(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> getTaskById(int id) async {
    try {
      final task = await localDataSource.getTaskById(id);
      return Right(task.toEntity());
    } catch (e) {
      return Left(Failure.database(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> createTask(Task task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);
      final createdTask = await localDataSource.insertTask(taskModel);
      return Right(createdTask.toEntity());
    } catch (e) {
      return Left(Failure.database(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> updateTask(Task task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);
      final updatedTask = await localDataSource.updateTask(taskModel);
      return Right(updatedTask.toEntity());
    } catch (e) {
      return Left(Failure.database(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(int id) async {
    try {
      await localDataSource.deleteTask(id);
      return const Right(null);
    } catch (e) {
      return Left(Failure.database(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Task>>> syncTasksFromApi() async {
    try {
      final remoteTasks = await remoteDataSource.getTasks();
      
      // Guardar en la base de datos local
      await localDataSource.insertTasks(remoteTasks);
      
      return Right(remoteTasks.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(Failure.network(e.toString()));
    }
  }
}
