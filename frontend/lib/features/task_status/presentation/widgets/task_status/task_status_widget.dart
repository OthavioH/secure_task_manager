import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/task_status/domain/models/task_status.dart';
import 'package:simple_rpg_system/features/task_status/presentation/views/edit_task_status/edit_task_status_scren.dart';
import 'package:simple_rpg_system/features/task_status/presentation/widgets/task_status/controllers/delete_task_controller.dart';
import 'package:simple_rpg_system/features/task_status/presentation/widgets/task_status/controllers/delete_task_state.dart';

class TaskStatusWidget extends ConsumerWidget {
  final TaskStatus status;
  final void Function(TaskStatus) onUpdate;
  final void Function(String) onDelete;
  const TaskStatusWidget({
    super.key,
    required this.status,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      deleteTaskControllerProvider,
      (_, state) {
        if (state is DeleteTaskSuccessState) {
          onDelete(status.id);
        } else if (state is DeleteTaskErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error deleting status: ${state.errorMessage}'),
            ),
          );
        }
      },
    );
    return GestureDetector(
      onTap: () async {
        final updatesStatus = await showModalBottomSheet(
          context: context,
          builder: (context) => BottomSheet(
            onClosing: () {},
            enableDrag: false,
            builder: (context) => EditTaskStatusScreen(
              status: status,
            ),
          ),
        );

        if (updatesStatus == null) return;

        onUpdate(updatesStatus);
      },
      child: Chip(
        label: Text(status.name),
        onDeleted: () async {
          ref.read(deleteTaskControllerProvider.notifier).deleteTask(status.id);
        },
      ),
    );
  }
}
