import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/core/utils/size_utils.dart';
import 'package:simple_rpg_system/features/task/presentation/views/create_task_modal/controllers/create_task_controller.dart';
import 'package:simple_rpg_system/features/task/presentation/views/create_task_modal/controllers/create_task_state.dart';
import 'package:simple_rpg_system/features/task/presentation/views/create_task_modal/controllers/task_status_provider.dart';

class CreateTaskModal extends ConsumerStatefulWidget {
  const CreateTaskModal({super.key});

  @override
  ConsumerState<CreateTaskModal> createState() => _CreateTaskModalState();
}

class _CreateTaskModalState extends ConsumerState<CreateTaskModal> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedStatusId;

  @override
  Widget build(BuildContext context) {
    ref.listen(createTaskControllerProvider, (_, state) {
      if (state is CreateTaskSuccess) {
        Navigator.of(context).pop(state.task);
      }
      if (state is CreateTaskError) {
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

    final isLoading = ref.watch(createTaskControllerProvider).isLoading;

    final taskStatusState = ref.watch(taskStatusProvider);

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SizeUtils.kHorizontalPadding,
          vertical: SizeUtils.kVerticalPadding,
        ),
        child: ListView(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUnfocus,
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
              autovalidateMode: AutovalidateMode.onUnfocus,
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
                if (taskStatusState.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (taskStatusState.valueOrNull == null ||
                    taskStatusState.value!.isEmpty) {
                  return Text(
                    'No statuses available. Please add a status first.',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  );
                }
                return DropdownButtonFormField<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                  ),
                  items: taskStatusState.when(
                    loading: () => [],
                    error: (error, _) => [],
                    data: (statuses) => statuses
                        .map(
                          (status) => DropdownMenuItem<String>(
                            value: status.id,
                            child: Text(status.name),
                          ),
                        )
                        .toList(),
                  ),
                  onChanged: (value) {
                    _selectedStatusId = value;
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
                      if (_formKey.currentState!.validate() &&
                          _selectedStatusId != null) {
                        ref
                            .read(createTaskControllerProvider.notifier)
                            .createTask(
                              _titleController.text,
                              _descriptionController.text,
                              _selectedStatusId!,
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
                  : const Text('Create Task'),
            ),
          ],
        ),
      ),
    );
  }
}
