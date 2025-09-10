import 'package:simple_rpg_system/features/task_status/domain/models/task_status.dart';

class TaskStatusState {
  final List<TaskStatus> statuses;
  final TaskStatus? selectedStatus;

  TaskStatusState({
    required this.statuses,
    this.selectedStatus,
  });

  factory TaskStatusState.initial() {
    return TaskStatusState(
      statuses: [],
      selectedStatus: null,
    );
  }

  TaskStatusState resetSelectedStatus() {
    return TaskStatusState(
      statuses: statuses,
      selectedStatus: null,
    );
  }

  TaskStatusState copyWith({
    List<TaskStatus>? statuses,
    TaskStatus? selectedStatus,
  }) {
    return TaskStatusState(
      statuses: statuses ?? this.statuses,
      selectedStatus: selectedStatus ?? this.selectedStatus,
    );
  }
}
