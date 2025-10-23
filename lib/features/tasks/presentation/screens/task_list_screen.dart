import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/tasks/presentation/providers/task_provider.dart';
import 'package:todo_app/features/tasks/domain/entities/task.dart';
import 'task_form_screen.dart';
import 'task_detail_screen.dart';

/// Pantalla principal de tareas
class TaskListScreen extends ConsumerStatefulWidget {
  const TaskListScreen({super.key});

  @override
  ConsumerState<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<TaskListScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar tareas al inicializar
    Future.microtask(() => ref.read(taskNotifierProvider.notifier).loadTasks());
  }

  @override
  Widget build(BuildContext context) {
    final taskState = ref.watch(taskNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Tareas'),
        elevation: 2,
        actions: [
          PopupMenuButton<TaskFilter>(
            icon: const Icon(Icons.filter_list),
            onSelected: (filter) {
              ref.read(taskNotifierProvider.notifier).changeFilter(filter);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: TaskFilter.all,
                child: Text('Todas'),
              ),
              const PopupMenuItem(
                value: TaskFilter.pending,
                child: Text('Pendientes'),
              ),
              const PopupMenuItem(
                value: TaskFilter.completed,
                child: Text('Completadas'),
              ),
            ],
          ),
        ],
      ),
      body: _buildBody(taskState),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaskFormScreen(),
            ),
          );
          if (result == true) {
            ref.read(taskNotifierProvider.notifier).loadTasks();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(TaskState state) {
    switch (state.status) {
      case TaskStatus.loading:
        return const Center(child: CircularProgressIndicator());
      
      case TaskStatus.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(state.errorMessage ?? 'Error desconocido'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(taskNotifierProvider.notifier).loadTasks();
                },
                child: const Text('Reintentar'),
              ),
            ],
          ),
        );
      
      case TaskStatus.loaded:
        final tasks = state.filteredTasks;
        
        if (tasks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.task_outlined, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'No hay tareas',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }
        
        return RefreshIndicator(
          onRefresh: () async {
            await ref.read(taskNotifierProvider.notifier).loadTasks();
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return _TaskCard(task: task);
            },
          ),
        );
      
      case TaskStatus.initial:
        return const Center(child: CircularProgressIndicator());
    }
  }
}

/// Widget de tarjeta de tarea
class _TaskCard extends ConsumerWidget {
  final Task task;

  const _TaskCard({required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: Checkbox(
          value: task.completed,
          onChanged: (_) {
            ref.read(taskNotifierProvider.notifier).toggleTaskCompletion(task);
          },
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.completed ? TextDecoration.lineThrough : null,
            color: task.completed ? Colors.grey : null,
          ),
        ),
        subtitle: Text('ID: ${task.id} | Usuario: ${task.userId}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailScreen(task: task),
            ),
          );
        },
      ),
    );
  }
}
