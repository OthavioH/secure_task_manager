import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_rpg_system/features/auth/routes/auth_routes.dart';
import 'package:simple_rpg_system/features/task/presentation/views/user_tasks_screen/controllers/user_tasks_controller.dart';
import 'package:simple_rpg_system/shared/controllers/auth_guard_controller.dart';
import 'package:simple_rpg_system/shared/controllers/auth_guard_state.dart';
import 'package:simple_rpg_system/features/task/presentation/widgets/session_expired_snack_bar.dart';

class UserTasksScreen extends ConsumerStatefulWidget {
  const UserTasksScreen({super.key});

  @override
  ConsumerState<UserTasksScreen> createState() => _UserTasksScreenState();
}

class _UserTasksScreenState extends ConsumerState<UserTasksScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen(
      authGuardControllerProvider,
      (_, state) {
        if (state.valueOrNull is AuthGuardNotAuthorizedState) {
          context.go(AuthRoutes.loginRoute);
          showSessionExpiredSnackBar(context);
        }
      },
    );

    final userTaskState = ref.watch(userTasksControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
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
            itemCount: 10,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return ListTile();
            },
          );
        },
      ),
    );
  }
}
