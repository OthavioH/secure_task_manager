import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_rpg_system/core/utils/size_utils.dart';
import 'package:simple_rpg_system/features/task/domain/models/task_model.dart';
import 'package:simple_rpg_system/features/task/presentation/views/create_task_modal/create_task_modal.dart';
import 'package:simple_rpg_system/features/task/presentation/views/user_tasks_screen/controllers/tasks_status_controller.dart';
import 'package:simple_rpg_system/features/task/presentation/views/user_tasks_screen/controllers/user_tasks_controller.dart';
import 'package:simple_rpg_system/features/task/presentation/widgets/task_item.dart';
import 'package:simple_rpg_system/features/task/presentation/widgets/task_status_filter_all.dart';
import 'package:simple_rpg_system/features/task/presentation/widgets/task_status_filter_item.dart';
import 'package:simple_rpg_system/shared/widgets/gradient_background.dart';

class UserTasksScreen extends ConsumerStatefulWidget {
  const UserTasksScreen({super.key});

  @override
  ConsumerState<UserTasksScreen> createState() => _UserTasksScreenState();
}

class _UserTasksScreenState extends ConsumerState<UserTasksScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen(
      userTasksControllerProvider,
      (previous, next) {
        if (next.hasError) {
          final error = next.error;
          log(
            "Error while trying to load user tasks",
            error: error,
            stackTrace: next.stackTrace,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                "There was an error while trying to load your tasks. Please, try again later.",
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
          return;
        }
      },
    );

    final userTaskState = ref.watch(userTasksControllerProvider);
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () async {
                await context.push('/settings');
                ref.invalidate(userTasksControllerProvider);
              },
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton.small(
              heroTag: 'refresh',
              onPressed: () async {
                final _ = ref.refresh(userTasksControllerProvider);
              },
              child: const Icon(Icons.refresh),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              heroTag: 'add',
              onPressed: () async {
                final createdTask = await showModalBottomSheet(
                  context: context,
                  builder: (context) => BottomSheet(
                    enableDrag: false,
                    onClosing: () {},
                    builder: (context) => const CreateTaskModal(),
                  ),
                );

                if (createdTask == null || createdTask is! TaskModel) return;

                ref
                    .read(userTasksControllerProvider.notifier)
                    .addTask(createdTask);
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SizeUtils.kHorizontalPadding,
            vertical: SizeUtils.kVerticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Tasks',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),

              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 16,
                children: [
                  Text(
                    'Filter by status:',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(width: 16),
                  Wrap(
                    runSpacing: 8,
                    spacing: 8,
                    children: [
                      TaskStatusFilterAll(
                        isSelected:
                            ref
                                .watch(tasksStatusControllerProvider)
                                .selectedStatus ==
                            null,
                        onSelect: ref
                            .read(tasksStatusControllerProvider.notifier)
                            .selectAllStatuses,
                      ),
                      ...ref
                          .watch(tasksStatusControllerProvider)
                          .statuses
                          .map(
                            (status) => TaskStatusFilterItem(
                              status: status,
                              isSelected:
                                  ref
                                      .watch(tasksStatusControllerProvider)
                                      .selectedStatus ==
                                  status,
                              onTap: ref
                                  .read(tasksStatusControllerProvider.notifier)
                                  .toggleStatus,
                            ),
                          ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              userTaskState.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                data: (data) {
                  if (data.isEmpty) {
                    return const Center(
                      child: Text('There are no tasks yet'),
                    );
                  }
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: data
                        .map(
                          (task) => TaskItem(
                            task: task,
                            onDelete: ref
                                .read(userTasksControllerProvider.notifier)
                                .deleteTask,
                            onUpdate: ref
                                .read(userTasksControllerProvider.notifier)
                                .updateTask,
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
