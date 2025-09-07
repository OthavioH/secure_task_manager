import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_rpg_system/core/utils/size_utils.dart';
import 'package:simple_rpg_system/features/auth/routes/auth_routes.dart';
import 'package:simple_rpg_system/features/task_status/presentation/views/create_task_status/create_task_status_modal.dart';
import 'package:simple_rpg_system/features/task_status/presentation/views/edit_task_status/edit_task_status_scren.dart';
import 'package:simple_rpg_system/features/task_status/presentation/views/task_status_settings/controllers/sign_out_controller.dart';
import 'package:simple_rpg_system/features/task_status/presentation/views/task_status_settings/controllers/sign_out_state.dart';
import 'package:simple_rpg_system/features/task_status/presentation/views/task_status_settings/controllers/task_status_settings_controller.dart';

class TaskStatusSettingsScreen extends ConsumerWidget {
  const TaskStatusSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStatuses = ref.watch(taskStatusSettingsControllerProvider);
    final controller = ref.watch(taskStatusSettingsControllerProvider.notifier);

    ref.listen(signOutControllerProvider, (previous, next) {
      if(next is SignOutSuccess) {
        context.pop();
        context.go(AuthRoutes.loginRoute);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Status Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () async {
              final status = await showModalBottomSheet(
                context: context,
                builder: (context) => BottomSheet(
                  onClosing: () {},
                  enableDrag: false,
                  builder: (context) => CreateTaskStatusModal(),
                ),
              );

              if (status == null) return;

              controller.addStatus(status);
            },
            icon: Icon(Icons.add),
            label: Text('Add Status'),
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
            asyncStatuses.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Erro: $error')),
              data: (statuses) {
                return Wrap(
                  spacing: 8.0,
                  children: statuses.map((status) {
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

                        controller.updateStatus(updatesStatus);
                      },
                      child: Chip(
                        label: Text(status.name),
                        onDeleted: () {
                          controller.deleteStatus(status.id);
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            const Divider(
              height: 32,
            ),
            Center(
              child: FilledButton.tonalIcon(
                label: Text('Logout'),
                onPressed: () {
                  ref.read(signOutControllerProvider.notifier).signOut();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
