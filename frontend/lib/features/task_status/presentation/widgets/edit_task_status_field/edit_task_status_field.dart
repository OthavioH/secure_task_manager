import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/task_status/presentation/widgets/edit_task_status_field/controllers/edit_task_status_controller.dart';
import 'package:simple_rpg_system/features/task_status/presentation/widgets/edit_task_status_field/controllers/edit_task_status_state.dart';

class EditTaskStatusField extends ConsumerStatefulWidget {
  final String statusId;
  final String? initialValue;
  final void Function(String newValue)? onSave;
  const EditTaskStatusField({
    required this.statusId,
    this.initialValue,
    this.onSave,
    super.key,
  });

  @override
  ConsumerState<EditTaskStatusField> createState() => _EditTaskStatusFieldState();
}

class _EditTaskStatusFieldState extends ConsumerState<EditTaskStatusField> {
  late final TextEditingController _controller;
  final _fieldKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    _controller = TextEditingController(text: widget.initialValue ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(editTaskStatusControllerProvider, (_, state) {
			if (state is EditTaskStatusSuccess) {
				widget.onSave?.call(state.status.name);
			}
			if (state is EditTaskStatusError) {
				showDialog(
					context: context,
					builder: (context) => AlertDialog(
						title: const Text('Error'),
						content: Text(state.message),
						actions: [
							TextButton(
								onPressed: () => Navigator.of(context).pop(),
								child: const Text('OK'),
							),
						],
					),
				);
			}
		});

    final isLoading = ref.watch(editTaskStatusControllerProvider).isLoading;

    return Row(
      children: [
        Expanded(
          child: TextFormField(
            key: _fieldKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _controller,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Task Status Name',
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please type a status name';
              }
              return null;
            },
          ),
        ),
        IconButton(
          onPressed: isLoading ? null : () {
            if (_fieldKey.currentState?.validate() ?? false) {
              ref.read(editTaskStatusControllerProvider.notifier).editTaskStatus(
                    id: widget.statusId,
                    name: _controller.text.trim(),
                  );
            }
          },
          icon: Builder(
            builder: (context) {
              if (isLoading) {
                return const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              }
              return const Icon(Icons.check);
            }
          ),
        ),
      ],
    );
  }
}
