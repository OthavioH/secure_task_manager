import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_rpg_system/features/task/domain/models/task_model.dart';
import 'package:simple_rpg_system/features/task/presentation/views/create_task_modal/create_task_modal.dart';
import 'package:simple_rpg_system/features/task/presentation/views/user_tasks_screen/controllers/user_tasks_controller.dart';
import 'package:simple_rpg_system/features/task/presentation/widgets/task_item.dart';

class UserTasksScreen extends ConsumerStatefulWidget {
  const UserTasksScreen({super.key});

  @override
  ConsumerState<UserTasksScreen> createState() => _UserTasksScreenState();
}

class _UserTasksScreenState extends ConsumerState<UserTasksScreen> {
  @override
  Widget build(BuildContext context) {
    final userTaskState = ref.watch(userTasksControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              context.push('/settings');
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
            child: Icon(Icons.refresh),
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
                  builder: (context) => CreateTaskModal(),
                ),
              );
              
              if(createdTask == null || createdTask is! TaskModel) return;
              
              ref.read(userTasksControllerProvider.notifier).addTask(createdTask);
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
      body: userTaskState.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          log("Error getting tasks", error: error, stackTrace: stackTrace);
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        data: (data) {
          if (data.isEmpty) {
            return Center(
              child: Text('There are no tasks yet'),
            );
          }
          return ListView.separated(
            itemCount: data.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final task = data[index];
              return TaskItem(
                task: task,
                onDelete: (taskId) {
                  ref.read(userTasksControllerProvider.notifier).deleteTask(taskId);
                },
                onUpdate: (updatedTask) {
                  ref.read(userTasksControllerProvider.notifier).updateTask(updatedTask);
                },
              );
            },
          );
        },
      ),
    );
  }
}
