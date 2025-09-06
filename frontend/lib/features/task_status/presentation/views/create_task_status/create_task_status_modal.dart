
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/core/utils/size_utils.dart';
import 'package:simple_rpg_system/features/task_status/presentation/views/create_task_status/controllers/create_task_status_controller.dart';

class CreateTaskStatusModal extends ConsumerStatefulWidget {
  const CreateTaskStatusModal({super.key});

  @override
  ConsumerState<CreateTaskStatusModal> createState() => _CreateTaskStatusModalState();
}

class _CreateTaskStatusModalState extends ConsumerState<CreateTaskStatusModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(createTaskStatusControllerProvider, (_, state) {
      if (state is CreateTaskStatusSuccess) {
        Navigator.of(context).pop(state.status);
      }
      if (state is CreateTaskStatusError) {
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

    final isLoading = ref.watch(createTaskStatusControllerProvider).isLoading;

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
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: isLoading
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(createTaskStatusControllerProvider.notifier)
                            .createTaskStatus(
                              _nameController.text,
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
                  : const Text('Create Status'),
            ),
          ],
        ),
      ),
    );
  }
}
