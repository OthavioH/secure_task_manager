

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/task_status/domain/models/task_status.dart';
import 'package:simple_rpg_system/features/task_status/providers/task_status_providers.dart';

final taskStatusProvider = FutureProvider.autoDispose<List<TaskStatus>>((ref) async {
  final service = ref.watch(taskStatusServiceProvider);
  return await service.getAllStatuses();
});