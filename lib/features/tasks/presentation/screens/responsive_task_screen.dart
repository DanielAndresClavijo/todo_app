import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/tasks/domain/entities/task.dart';
import 'package:todo_app/features/tasks/presentation/providers/task_provider.dart';
import 'package:todo_app/features/tasks/presentation/screens/task_form_screen.dart';
import 'package:todo_app/features/tasks/presentation/widgets/sidebar_navigation.dart';
import 'package:todo_app/features/tasks/presentation/widgets/task_list_content.dart';
import 'package:todo_app/features/tasks/presentation/widgets/task_detail_panel.dart';
import 'package:todo_app/features/tasks/presentation/widgets/task_form_content.dart';

/// Breakpoints para diseño responsive
class AppBreakpoints {
  static const double mobile = 720;
  static const double tablet = 1080;
  static const double desktop = 1080;
}

/// Pantalla principal responsive con 3 secciones adaptativas
class ResponsiveTaskScreen extends ConsumerStatefulWidget {
  const ResponsiveTaskScreen({super.key});

  @override
  ConsumerState<ResponsiveTaskScreen> createState() =>
      _ResponsiveTaskScreenState();
}

class _ResponsiveTaskScreenState extends ConsumerState<ResponsiveTaskScreen> {
  Task? _selectedTask;
  bool _isSidebarOpen = false;

  @override
  void initState() {
    super.initState();
    // Cargar tareas al iniciar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(taskNotifierProvider.notifier).loadTasks();
    });
  }

  void _selectTask(Task task) {
    final screenType = _getScreenType();
    setState(() {
      _selectedTask = task;
      // En mobileo o tablet, cerrar sidebar al seleccionar tarea
      if (screenType == ScreenType.tablet || screenType == ScreenType.mobile) {
        _isSidebarOpen = false;
      }
    });
  }

  void _closeDetail() {
    setState(() {
      _selectedTask = null;
    });
  }

  void _toggleSidebar() {
    if (mounted) setState(() => _isSidebarOpen = !_isSidebarOpen);
  }

  void _onFilterChanged() {
    final screenType = _getScreenType();
    // En mobile, cerrar el sidebar al cambiar filtro
    if (screenType == ScreenType.mobile && _isSidebarOpen) {
      setState(() {
        _isSidebarOpen = false;
      });
    }
  }

  void _createTask() async {
    final screenType = _getScreenType();

    if (screenType == ScreenType.desktop) {
      // Desktop: Mostrar diálogo
      final result = await showDialog<Task>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Nueva Tarea'),
          content: SizedBox(
            width: 500,
            child: TaskFormContent(
              onSaved: (task) {
                // Actualizar y seleccionar la nueva tarea
                setState(() {
                  _selectedTask = task;
                });
              },
            ),
          ),
        ),
      );

      if (result != null && mounted) {
        ref.read(taskNotifierProvider.notifier).loadTasks();
        setState(() {
          _selectedTask = result;
        });
      }
    } else {
      // Mobile/Tablet: Pantalla completa
      final result = await Navigator.push<Task>(
        context,
        MaterialPageRoute(builder: (context) => const TaskFormScreen()),
      );

      if (result != null && mounted) {
        ref.read(taskNotifierProvider.notifier).loadTasks();
        // En mobile, seleccionar la tarea creada
        if (screenType == ScreenType.mobile) {
          setState(() {
            _selectedTask = result;
          });
        }
      }
    }
  }

  void _toggleTaskCompletion() {
    if (_selectedTask != null) {
      ref
          .read(taskNotifierProvider.notifier)
          .toggleTaskCompletion(_selectedTask!);
      setState(() {
        _selectedTask = _selectedTask!.copyWith(
          completed: !_selectedTask!.completed,
        );
      });
    }
  }

  void _editTask() async {
    if (_selectedTask == null) return;

    final screenType = _getScreenType();

    if (screenType == ScreenType.desktop) {
      // Desktop: Mostrar diálogo
      final result = await showDialog<Task>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Editar Tarea'),
          content: SizedBox(
            width: 500,
            child: TaskFormContent(
              task: _selectedTask,
              onSaved: (task) {
                // Actualizar la tarea seleccionada
                setState(() {
                  _selectedTask = task;
                });
              },
            ),
          ),
        ),
      );

      if (result != null && mounted) {
        ref.read(taskNotifierProvider.notifier).loadTasks();
        setState(() {
          _selectedTask = result;
        });
      }
    } else {
      // Mobile/Tablet: Pantalla completa
      final result = await Navigator.push<Task>(
        context,
        MaterialPageRoute(
          builder: (context) => TaskFormScreen(task: _selectedTask),
        ),
      );

      if (result != null && mounted) {
        ref.read(taskNotifierProvider.notifier).loadTasks();
        setState(() {
          _selectedTask = result;
        });
      }
    }
  }

  void _deleteTask() async {
    if (_selectedTask != null) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Eliminar tarea'),
          content: const Text(
            '¿Estás seguro de que deseas eliminar esta tarea?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text('Eliminar'),
            ),
          ],
        ),
      );

      if (confirmed == true && mounted) {
        await ref
            .read(taskNotifierProvider.notifier)
            .deleteTask(_selectedTask!.id);
        _closeDetail();
      }
    }
  }

  ScreenType _getScreenType() {
    final width = MediaQuery.of(context).size.width;
    if (width < AppBreakpoints.mobile) {
      return ScreenType.mobile;
    } else if (width < AppBreakpoints.desktop) {
      return ScreenType.tablet;
    } else {
      return ScreenType.desktop;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenType = _getScreenType();

    return Scaffold(
      appBar: _buildAppBar(screenType),
      body: _buildBody(screenType),
    );
  }

  PreferredSizeWidget? _buildAppBar(ScreenType screenType) {
    // Solo mostrar AppBar en mobile y tablet
    if (screenType == ScreenType.desktop) {
      return null;
    }

    return AppBar(
      leading: !_isSidebarOpen && (_selectedTask != null && screenType == ScreenType.mobile)
          ? null
          : IconButton(
              icon: Icon(_isSidebarOpen ? Icons.close : Icons.menu),
              onPressed: _toggleSidebar,
            ),
      title: const Text('Mis Tareas'),
      actions: [
        if (!_isSidebarOpen && screenType == ScreenType.mobile && _selectedTask != null)
          IconButton(icon: const Icon(Icons.close), onPressed: _closeDetail),
      ],
    );
  }

  Widget _buildBody(ScreenType screenType) {
    switch (screenType) {
      case ScreenType.desktop:
        return _buildDesktopLayout();
      case ScreenType.tablet:
        return _buildTabletLayout();
      case ScreenType.mobile:
        return _buildMobileLayout();
    }
  }

  // Desktop: 3 columnas siempre visibles
  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // Sidebar izquierda (280px)
        SizedBox(
          width: 280,
          child: SidebarNavigation(
            onCreateTask: _createTask,
            onFilterChanged: _onFilterChanged,
          ),
        ),

        // Lista central (flexible)
        Expanded(
          flex: 2,
          child: TaskListContent(
            selectedTask: _selectedTask,
            onTaskTap: _selectTask,
          ),
        ),

        // Panel de detalles (380px)
        if (_selectedTask != null)
          SizedBox(
            width: 380,
            child: TaskDetailPanel(
              task: _selectedTask!,
              onEdit: _editTask,
              onDelete: _deleteTask,
              onToggleComplete: _toggleTaskCompletion,
              onClose: _closeDetail,
            ),
          )
        else
          SizedBox(
            width: 380,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                border: Border(
                  left: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.description_outlined,
                      size: 64,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Selecciona una tarea',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Los detalles aparecerán aquí',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  // Tablet: 2 columnas, sidebar toggleable
  Widget _buildTabletLayout() {
    return Row(
      children: [
        // Sidebar izquierda (toggleable, 280px)
        if (_isSidebarOpen)
          SizedBox(
            width: 280,
            child: SidebarNavigation(
              onCreateTask: _createTask,
              onFilterChanged: _onFilterChanged,
            ),
          ),

        // Contenido principal
        Expanded(
          child: _selectedTask != null && !_isSidebarOpen
              ? Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TaskListContent(
                        selectedTask: _selectedTask,
                        onTaskTap: _selectTask,
                      ),
                    ),
                    SizedBox(
                      width: 380,
                      child: TaskDetailPanel(
                        task: _selectedTask!,
                        onEdit: _editTask,
                        onDelete: _deleteTask,
                        onToggleComplete: _toggleTaskCompletion,
                        onClose: _closeDetail,
                      ),
                    ),
                  ],
                )
              : TaskListContent(
                  selectedTask: _selectedTask,
                  onTaskTap: _selectTask,
                ),
        ),
      ],
    );
  }

  // Mobile: 1 columna, navegación por stack
  Widget _buildMobileLayout() {
    if (_selectedTask != null && !_isSidebarOpen) {
      // Mostrar detalles en pantalla completa
      return TaskDetailPanel(
        task: _selectedTask!,
        onEdit: _editTask,
        onDelete: _deleteTask,
        onToggleComplete: _toggleTaskCompletion,
      );
    }

    if (_isSidebarOpen) {
      // Mostrar sidebar en pantalla completa
      return SidebarNavigation(
        onCreateTask: _createTask,
        onFilterChanged: _onFilterChanged,
      );
    }

    // Mostrar lista por defecto
    return TaskListContent(selectedTask: _selectedTask, onTaskTap: _selectTask);
  }
}

enum ScreenType { mobile, tablet, desktop }
