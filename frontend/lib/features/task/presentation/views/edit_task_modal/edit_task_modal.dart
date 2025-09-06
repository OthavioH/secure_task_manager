import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/core/utils/size_utils.dart';
import 'package:simple_rpg_system/features/task/domain/models/task_model.dart';
import 'package:simple_rpg_system/features/task/presentation/views/create_task_modal/controllers/task_status_provider.dart';
import 'package:simple_rpg_system/features/task/presentation/views/edit_task_modal/controllers/edit_task_controller.dart';
import 'package:simple_rpg_system/features/task/presentation/views/edit_task_modal/controllers/edit_task_state.dart';
import 'package:simple_rpg_system/features/task_status/domain/models/task_status.dart';

class EditTaskModal extends ConsumerStatefulWidget {
  final TaskModel task;
  const EditTaskModal({
    required this.task,
    super.key,
  });

  @override
  ConsumerState<EditTaskModal> createState() => _EditTaskModalState();
}

class _EditTaskModalState extends ConsumerState<EditTaskModal> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  TaskStatus? _selectedStatus;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(
      text: widget.task.description,
    );
    _selectedStatus = widget.task.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(editTaskControllerProvider, (_, state) {
      if (state is EditTaskSuccess) {
        Navigator.of(context).pop(state.task);
      }
      if (state is EditTaskError) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(state.message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    });

    final isLoading = ref.watch(editTaskControllerProvider).isLoading;

    final taskStatusState = ref.watch(taskStatusProvider);

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUnfocus,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SizeUtils.kHorizontalPadding,
          vertical: SizeUtils.kVerticalPadding,
        ),
        child: ListView(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            Builder(
              builder: (context) {
                if(taskStatusState.valueOrNull == null){
                  return const Center(child: CircularProgressIndicator());
                }
                if(taskStatusState.valueOrNull!.isEmpty){
                  return const Text('No status available. Please create one first.');
                }
                return DropdownButtonFormField<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                  ),
                  initialValue: _selectedStatus?.id,
                  items: taskStatusState.value!
                        .map(
                          (status) => DropdownMenuItem<String>(
                            value: status.id,
                            child: Text(status.name),
                          ),
                        )
                        .toList(),
                  onChanged: (value) {

                    if(value == null) {
                      _selectedStatus = null;
                      return;
                    }
                    
                    _selectedStatus = taskStatusState.value!.firstWhere((status) => status.id == value);
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a status';
                    }
                    return null;
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: isLoading
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(editTaskControllerProvider.notifier)
                            .editTask(
                              title: _titleController.text,
                              description: _descriptionController.text,
                              taskId: widget.task.id,
                              userId: widget.task.userId,
                              status: _selectedStatus!,
                            );
                      }
                    },
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(60), // altura mínima
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2.5),
                      ),
                    )
                  : const Text('Edit Task'),
            ),
          ],
        ),
      ),
    );
  }
}
