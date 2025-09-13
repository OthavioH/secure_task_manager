import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/core/utils/size_utils.dart';
import 'package:simple_rpg_system/features/task_status/domain/models/task_status.dart';
import 'package:simple_rpg_system/features/task_status/presentation/widgets/edit_task_status_field/edit_task_status_field.dart';
import 'package:simple_rpg_system/features/task_status/presentation/widgets/task_status/controllers/delete_task_controller.dart';
import 'package:simple_rpg_system/features/task_status/presentation/widgets/task_status/controllers/delete_task_state.dart';
import 'package:simple_rpg_system/features/task_status/presentation/widgets/task_status/controllers/task_edit_state_controller.dart';
import 'package:simple_rpg_system/features/task_status/presentation/widgets/task_status/controllers/task_status_edit_state.dart';

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
      deleteTaskControllerProvider(status.id),
      (_, state) {
        if (state is DeleteTaskSuccessState) {
          onDelete(status.id);
          return;
        } else if (state is DeleteTaskErrorState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: Text(state.errorMessage),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          return;
        }
      },
    );

    bool isLoading =
        ref.watch(deleteTaskControllerProvider(status.id))
            is DeleteTaskLoadingState;
    if (isLoading) {
      return const SizedBox.shrink();
    }

    return Container(
      constraints: BoxConstraints(
        maxWidth: min(
          500,
          MediaQuery.of(context).size.width - SizeUtils.kHorizontalPadding * 2,
        ),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Builder(
        builder: (context) {
          final isEditing =
              ref.watch(taskStatusEditStateProvider(status.id))
                  is TaskStatusEditStateEditing;
          if (isEditing) {
            return EditTaskStatusField(
              statusId: status.id,
              initialValue: status.name,
              onSave: (newValue) {
                onUpdate(
                  TaskStatus(id: status.id, name: newValue),
                );
                ref
                    .read(taskStatusEditStateProvider(status.id).notifier)
                    .stopEditing();
              },
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Builder(
                  builder: (context) => SelectableText(
                    status.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              Row(
                spacing: 8,
                children: [
                  IconButton(
                    onPressed: () {
                      ref
                          .read(taskStatusEditStateProvider(status.id).notifier)
                          .startEditing();
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ref
                          .read(
                            deleteTaskControllerProvider(status.id).notifier,
                          )
                          .deleteTask();
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
