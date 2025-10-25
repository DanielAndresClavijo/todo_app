import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/features/tasks/domain/entities/task.dart';
import 'package:todo_app/features/tasks/domain/usecases/get_tasks.dart';
import 'package:todo_app/features/tasks/domain/usecases/create_task.dart';
import 'package:todo_app/features/tasks/domain/usecases/update_task.dart';
import 'package:todo_app/features/tasks/domain/usecases/delete_task.dart';
import 'package:todo_app/config/providers.dart';

/// Estados posibles para las tareas
enum TaskStatus { initial, loading, loaded, error }

/// Estado de las tareas
class TaskState {
  final TaskStatus status;
  final List<Task> tasks;
  final String? errorMessage;
  final TaskFilter filter;

  TaskState({
    required this.status,
    required this.tasks,
    this.errorMessage,
    this.filter = TaskFilter.all,
  });

  TaskState copyWith({
    TaskStatus? status,
    List<Task>? tasks,
    String? errorMessage,
    TaskFilter? filter,
  }) {
    return TaskState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      errorMessage: errorMessage ?? this.errorMessage,
      filter: filter ?? this.filter,
    );
  }

  List<Task> get filteredTasks {
    switch (filter) {
      case TaskFilter.completed:
        return tasks.where((task) => task.completed).toList();
      case TaskFilter.pending:
        return tasks.where((task) => !task.completed).toList();
      case TaskFilter.all:
        return tasks;
    }
  }
}

/// Filtros disponibles para las tareas
enum TaskFilter { 
  all,
  completed,
  pending;

  String get displayName {
    switch (this) {
      case TaskFilter.all:
        return 'Todas';
      case TaskFilter.completed:
        return 'Completadas';
      case TaskFilter.pending:
        return 'Pendientes';
    }
  }
}

/// Notifier para gestionar el estado de las tareas
class TaskNotifier extends StateNotifier<TaskState> {
  final GetTasks _getTasks;
  final CreateTask _createTask;
  final UpdateTask _updateTask;
  final DeleteTask _deleteTask;

  TaskNotifier({
    required GetTasks getTasks,
    required CreateTask createTask,
    required UpdateTask updateTask,
    required DeleteTask deleteTask,
  })  : _getTasks = getTasks,
        _createTask = createTask,
        _updateTask = updateTask,
        _deleteTask = deleteTask,
        super(TaskState(status: TaskStatus.initial, tasks: []));

  /// Carga todas las tareas
  Future<void> loadTasks() async {
    state = state.copyWith(status: TaskStatus.loading);

    final result = await _getTasks(const NoParams());

    result.fold(
      (failure) => state = state.copyWith(
        status: TaskStatus.error,
        errorMessage: failure.when(
          server: (msg) => msg,
          cache: (msg) => msg,
          network: (msg) => msg,
          database: (msg) => msg,
        ),
      ),
      (tasks) {
        // Ordenar tareas por fecha de actualización (más reciente primero)
        final sortedTasks = [...tasks];
        sortedTasks.sort((a, b) {
          final aDate = a.updatedAt ?? a.createdAt ?? DateTime(0);
          final bDate = b.updatedAt ?? b.createdAt ?? DateTime(0);
          return bDate.compareTo(aDate);
        });
        
        state = state.copyWith(
          status: TaskStatus.loaded,
          tasks: sortedTasks,
        );
      },
    );
  }

  /// Cambia el filtro de tareas
  void changeFilter(TaskFilter filter) {
    state = state.copyWith(filter: filter);
  }

  /// Marca una tarea como completada/pendiente
  Future<void> toggleTaskCompletion(Task task) async {
    final updatedTask = task.copyWith(
      completed: !task.completed,
      updatedAt: DateTime.now(),
    );
    
    final result = await _updateTask(updatedTask);

    result.fold(
      (failure) => state = state.copyWith(
        status: TaskStatus.error,
        errorMessage: failure.when(
          server: (msg) => msg,
          cache: (msg) => msg,
          network: (msg) => msg,
          database: (msg) => msg,
        ),
      ),
      (task) {
        // Remover la tarea de su posición actual
        final otherTasks = state.tasks.where((t) => t.id != task.id).toList();
        
        // Agregar la tarea actualizada al inicio
        state = state.copyWith(
          status: TaskStatus.loaded,
          tasks: [task, ...otherTasks],
        );
      },
    );
  }

  /// Crea una nueva tarea
  Future<void> createNewTask(String title) async {
    // Generar un ID único (en producción usarías un UUID o el generado por el servidor)
    final newId = state.tasks.isEmpty ? 1 : state.tasks.map((t) => t.id).reduce((a, b) => a > b ? a : b) + 1;
    
    final now = DateTime.now();
    final newTask = Task(
      id: newId,
      userId: 1,
      title: title,
      completed: false,
      createdAt: now,
      updatedAt: now,
    );

    final result = await _createTask(newTask);

    result.fold(
      (failure) => state = state.copyWith(
        status: TaskStatus.error,
        errorMessage: failure.when(
          server: (msg) => msg,
          cache: (msg) => msg,
          network: (msg) => msg,
          database: (msg) => msg,
        ),
      ),
      (task) {
        // Agregar la nueva tarea al inicio de la lista
        state = state.copyWith(
          status: TaskStatus.loaded,
          tasks: [task, ...state.tasks],
        );
      },
    );
  }

  /// Actualiza una tarea existente
  Future<void> updateExistingTask(Task task) async {
    // Actualizar la fecha de modificación
    final updatedTask = task.copyWith(updatedAt: DateTime.now());
    
    final result = await _updateTask(updatedTask);

    result.fold(
      (failure) => state = state.copyWith(
        status: TaskStatus.error,
        errorMessage: failure.when(
          server: (msg) => msg,
          cache: (msg) => msg,
          network: (msg) => msg,
          database: (msg) => msg,
        ),
      ),
      (updatedTask) {
        // Remover la tarea actualizada de su posición actual
        final otherTasks = state.tasks.where((t) => t.id != updatedTask.id).toList();
        
        // Agregar la tarea actualizada al inicio
        state = state.copyWith(
          status: TaskStatus.loaded,
          tasks: [updatedTask, ...otherTasks],
        );
      },
    );
  }

  /// Elimina una tarea
  Future<void> deleteTask(int taskId) async {
    final result = await _deleteTask(taskId);

    result.fold(
      (failure) => state = state.copyWith(
        status: TaskStatus.error,
        errorMessage: failure.when(
          server: (msg) => msg,
          cache: (msg) => msg,
          network: (msg) => msg,
          database: (msg) => msg,
        ),
      ),
      (_) {
        final updatedTasks = state.tasks.where((t) => t.id != taskId).toList();
        
        state = state.copyWith(
          status: TaskStatus.loaded,
          tasks: updatedTasks,
        );
      },
    );
  }
}

/// Provider del TaskNotifier
final taskNotifierProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  final getTasks = ref.watch(getTasksUseCaseProvider);
  final createTask = ref.watch(createTaskUseCaseProvider);
  final updateTask = ref.watch(updateTaskUseCaseProvider);
  final deleteTask = ref.watch(deleteTaskUseCaseProvider);

  return TaskNotifier(
    getTasks: getTasks,
    createTask: createTask,
    updateTask: updateTask,
    deleteTask: deleteTask,
  );
});
