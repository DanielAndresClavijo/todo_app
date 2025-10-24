import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/tasks/domain/entities/task.dart';
import 'package:todo_app/features/tasks/presentation/widgets/task_form_content.dart';

/// Pantalla de formulario para crear/editar tareas (pantalla completa)
class TaskFormScreen extends ConsumerWidget {
  final Task? task;

  const TaskFormScreen({super.key, this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditing = task != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Tarea' : 'Nueva Tarea'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: TaskFormContent(task: task),
      ),
    );
  }
}
