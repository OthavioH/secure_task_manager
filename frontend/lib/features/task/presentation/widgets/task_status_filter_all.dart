import 'package:flutter/material.dart';

class TaskStatusFilterAll extends StatelessWidget {
  final bool isSelected;
  final VoidCallback? onSelect;

  const TaskStatusFilterAll({
    required this.isSelected,
    this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return FilledButton(
        onPressed: onSelect,
        child: Text("All"),
      );
    }
    return OutlinedButton(
      onPressed: onSelect,
      child: Text("All"),
    );
  }
}
