import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_rpg_system/core/utils/size_utils.dart';
import 'package:simple_rpg_system/features/auth/routes/auth_routes.dart';
import 'package:simple_rpg_system/features/task_status/presentation/views/create_task_status/create_task_status_modal.dart';
import 'package:simple_rpg_system/features/task_status/presentation/views/task_status_settings/controllers/sign_out_controller.dart';
import 'package:simple_rpg_system/features/task_status/presentation/views/task_status_settings/controllers/sign_out_state.dart';
import 'package:simple_rpg_system/features/task_status/presentation/views/task_status_settings/controllers/task_status_settings_controller.dart';
import 'package:simple_rpg_system/features/task_status/presentation/widgets/task_status/task_status_widget.dart';

class TaskStatusSettingsScreen extends ConsumerWidget {
  const TaskStatusSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStatuses = ref.watch(taskStatusSettingsControllerProvider);
    final controller = ref.watch(taskStatusSettingsControllerProvider.notifier);

    ref.listen(signOutControllerProvider, (previous, next) {
      if (next is SignOutSuccess) {
        context.pop();
        context.go(AuthRoutes.loginRoute);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
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
                if (statuses.isEmpty) {
                  return const Center(
                    child: Text('No statuses found. Please add a status.'),
                  );
                }
                return Wrap(
                  spacing: 8.0,
                  children: statuses.map((status) {
                    return TaskStatusWidget(
                      status: status,
                      onUpdate: controller.updateStatus,
                      onDelete: controller.deleteStatus,
                    );
                  }).toList(),
                );
              },
            ),
            const Divider(
              height: 32,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                  side: BorderSide(color: Theme.of(context).colorScheme.error),
                ),
                label: Text('Logout'),
                icon: Icon(Icons.logout),
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
