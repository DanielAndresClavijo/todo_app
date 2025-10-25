import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/tasks/domain/entities/task.dart';
import 'package:todo_app/features/tasks/presentation/providers/task_provider.dart';

/// Widget reutilizable del formulario de tareas
class TaskFormContent extends ConsumerStatefulWidget {
  final Task? task;
  final Function(Task)? onSaved;

  const TaskFormContent({
    super.key,
    this.task,
    this.onSaved,
  });

  @override
  ConsumerState<TaskFormContent> createState() => _TaskFormContentState();
}

class _TaskFormContentState extends ConsumerState<TaskFormContent> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late bool _completed;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _completed = widget.task?.completed ?? false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _saveTask() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      Task? savedTask;
      
      if (widget.task != null) {
        // Editar tarea existente
        final updatedTask = widget.task!.copyWith(
          title: _titleController.text.trim(),
          completed: _completed,
        );
        await ref.read(taskNotifierProvider.notifier).updateExistingTask(updatedTask);
        savedTask = updatedTask;
      } else {
        // Crear nueva tarea
        final title = _titleController.text.trim();
        await ref.read(taskNotifierProvider.notifier).createNewTask(title);
        
        // Esperar un frame para que el estado se actualice
        await Future.delayed(Duration.zero);
        
        // Obtener la tarea recién creada del estado (está al inicio de la lista)
        final taskState = ref.read(taskNotifierProvider);
        // Buscar por título ya que es la tarea recién creada
        savedTask = taskState.tasks.firstWhere(
          (task) => task.title == title,
          orElse: () => taskState.tasks.first,
        );
      }

      if (mounted) {
        widget.onSaved?.call(savedTask);
        Navigator.pop(context, savedTask);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Título',
              hintText: 'Ingresa el título de la tarea',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.title),
            ),
            maxLines: 3,
            autofocus: true,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'El título es requerido';
              }
              if (value.trim().length < 3) {
                return 'El título debe tener al menos 3 caracteres';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          SwitchListTile(
            title: const Text('Estado'),
            subtitle: Text(_completed ? 'Completada' : 'Pendiente'),
            value: _completed,
            onChanged: (value) {
              setState(() {
                _completed = value;
              });
            },
            secondary: Icon(
              _completed ? Icons.check_circle : Icons.radio_button_unchecked,
              color: _completed ? Colors.green : Colors.grey,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _isLoading ? null : () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _saveTask,
                icon: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save),
                label: Text(isEditing ? 'Actualizar' : 'Crear'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
