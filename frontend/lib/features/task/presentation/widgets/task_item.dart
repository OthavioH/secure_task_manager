import 'package:flutter/material.dart';
import 'package:simple_rpg_system/features/task/domain/models/task_model.dart';
import 'package:simple_rpg_system/features/task/presentation/views/edit_task_modal/edit_task_modal.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  final void Function(TaskModel task) onUpdate;
  final void Function(String taskId) onDelete;
  const TaskItem({
    super.key,
    required this.task,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        final updatedTask = await showModalBottomSheet(
          context: context,
          builder: (context) => BottomSheet(
            enableDrag: false,
            onClosing: () {},
            builder: (context) => EditTaskModal(task: task),
          ),
        );

        if (updatedTask == null || updatedTask is! TaskModel) return;

        onUpdate(updatedTask);
      },
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Chip(
            label: Text(task.status.name),
          ),
          const SizedBox(width: 20),
          IconButton.outlined(
            onPressed: () {
              onDelete(task.id);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
