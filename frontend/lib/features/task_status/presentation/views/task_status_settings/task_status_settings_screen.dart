import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_rpg_system/core/utils/size_utils.dart';
import 'package:simple_rpg_system/features/auth/routes/auth_routes.dart';
import 'package:simple_rpg_system/features/task_status/presentation/widgets/create_task_status/create_task_status_view.dart';
import 'package:simple_rpg_system/features/task_status/presentation/views/task_status_settings/controllers/sign_out_controller.dart';
import 'package:simple_rpg_system/features/task_status/presentation/views/task_status_settings/controllers/sign_out_state.dart';
import 'package:simple_rpg_system/features/task_status/presentation/views/task_status_settings/controllers/task_status_settings_controller.dart';
import 'package:simple_rpg_system/features/task_status/presentation/widgets/task_status/task_status_widget.dart';
import 'package:simple_rpg_system/shared/providers/theme_controller.dart';
import 'package:simple_rpg_system/shared/widgets/gradient_background.dart';

class TaskStatusSettingsScreen extends ConsumerWidget {
  const TaskStatusSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStatuses = ref.watch(taskStatusSettingsControllerProvider);
    final controller = ref.watch(taskStatusSettingsControllerProvider.notifier);

    ref.listen<SignOutState>(signOutControllerProvider, (previous, next) {
      if (next is SignOutSuccess && previous is! SignOutSuccess) {
        context.pop();
        context.go(AuthRoutes.loginRoute);
      }
    });

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Settings'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.pop();
                },
              ),
              actions: [
                if (kDebugMode)
                  Switch(
                    value: ref.watch(themeProvider) == ThemeMode.dark,
                    onChanged: (bool isDarkMode) {
                      ref
                          .read(themeProvider.notifier)
                          .setTheme(
                            isDarkMode ? ThemeMode.dark : ThemeMode.light,
                          );
                    },
                  ),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  label: const Text('Logout'),
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    ref.read(signOutControllerProvider.notifier).signOut();
                  },
                ),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: SizeUtils.kHorizontalPadding,
                vertical: SizeUtils.kVerticalPadding,
              ),
              sliver: SliverList.list(
                children: [
                  Text(
                    'Task Statuses',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 16),
                  CreateTaskStatusView(
                    onStatusCreated: ref.read(taskStatusSettingsControllerProvider.notifier).addStatus,
                  ),
                  const SizedBox(height: 24),
                  asyncStatuses.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, _) => Center(child: Text('Erro: $error')),
                    data: (statuses) {
                      if (statuses.isEmpty) {
                        return const Center(
                          child: Text(
                            'No statuses found. Please add a status.',
                          ),
                        );
                      }
                      return Wrap(
                        spacing: 8.0,
                        runSpacing: 8,
                        children: statuses
                            .map(
                              (status) => TaskStatusWidget(
                                status: status,
                                onDelete: controller.deleteStatus,
                                onUpdate: controller.updateStatus,
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
