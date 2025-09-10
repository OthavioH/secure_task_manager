import 'package:flutter/material.dart';
import 'package:simple_rpg_system/features/task/domain/models/task_model.dart';
import 'package:simple_rpg_system/features/task/presentation/views/edit_task_modal/edit_task_modal.dart';
import 'package:simple_rpg_system/theme/app_icon_button_styles.dart';

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
    return SizedBox(
      width: 300,
      child: Card(
        margin: EdgeInsets.zero,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      task.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Chip(
                      label: Text(task.status.name),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  task.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    style: AppIconButtonStyles().negativeActionStyle(context),
                    onPressed: () {
                      onDelete(task.id);
                    },
                    icon: Icon(Icons.delete),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
