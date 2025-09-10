import 'package:flutter/material.dart';
import 'package:simple_rpg_system/features/task_status/domain/models/task_status.dart';

class TaskStatusFilterItem extends StatelessWidget {
  final TaskStatus status;
  final bool isSelected;
  final Function(TaskStatus status)? onTap;

  const TaskStatusFilterItem({
    required this.status,
    required this.isSelected,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return FilledButton(
        onPressed: onTap != null ? () => onTap!(status) : null,
        child: Text(status.name),
      );
    }
    return OutlinedButton(
      onPressed: onTap != null ? () => onTap!(status) : null,
      child: Text(status.name),
    );
  }
}
