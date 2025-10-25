import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/tasks/presentation/providers/task_provider.dart';
import 'package:todo_app/features/countries/presentation/screens/country_list_screen.dart';

/// Barra lateral izquierda con filtros y navegación
class SidebarNavigation extends ConsumerWidget {
  final VoidCallback? onCreateTask;
  final VoidCallback? onFilterChanged;

  const SidebarNavigation({
    super.key,
    this.onCreateTask,
    this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(taskNotifierProvider);
    final taskNotifier = ref.read(taskNotifierProvider.notifier);
    
    final allTasksCount = taskState.tasks.length;
    final pendingCount = taskState.tasks.where((t) => !t.completed).length;
    final completedCount = taskState.tasks.where((t) => t.completed).length;

    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Image.asset(
                  'assets/ic_launcher.png',
                  width: 28,
                  height: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'TODO APP',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // Filtros
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _FilterItem(
                  icon: Icons.inbox,
                  label: 'Todas',
                  count: allTasksCount,
                  isSelected: taskState.filter == TaskFilter.all,
                  onTap: () {
                    taskNotifier.changeFilter(TaskFilter.all);
                    onFilterChanged?.call();
                  },
                ),
                _FilterItem(
                  icon: Icons.radio_button_unchecked,
                  label: 'Pendientes',
                  count: pendingCount,
                  isSelected: taskState.filter == TaskFilter.pending,
                  onTap: () {
                    taskNotifier.changeFilter(TaskFilter.pending);
                    onFilterChanged?.call();
                  },
                ),
                _FilterItem(
                  icon: Icons.check_circle_outline,
                  label: 'Completadas',
                  count: completedCount,
                  isSelected: taskState.filter == TaskFilter.completed,
                  onTap: () {
                    taskNotifier.changeFilter(TaskFilter.completed);
                    onFilterChanged?.call();
                  },
                ),
                const Divider(height: 24),
                _FilterItem(
                  icon: Icons.flag_outlined,
                  label: 'Países',
                  isSelected: false,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CountryListScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          
          // Botón Nueva Tarea
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onCreateTask,
                icon: const Icon(Icons.add),
                label: const Text('Nueva Tarea'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int? count;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterItem({
    required this.icon,
    required this.label,
    this.count,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected 
            ? Theme.of(context).colorScheme.primary 
            : Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface,
        ),
      ),
      trailing: count != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
                    : Theme.of(context).colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            )
          : null,
      selected: isSelected,
      selectedTileColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
      onTap: onTap,
    );
  }
}
