import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/features/task_status/presentation/widgets/create_task_status/controllers/create_task_status_controller.dart';
import 'package:simple_rpg_system/features/task_status/presentation/views/task_status_settings/controllers/task_status_settings_controller.dart';
import 'package:simple_rpg_system/theme/app_input_decorations.dart';

class CreateTaskStatusView extends ConsumerStatefulWidget {
  const CreateTaskStatusView({super.key});

  @override
  ConsumerState<CreateTaskStatusView> createState() =>
      _CreateTaskStatusViewState();
}

class _CreateTaskStatusViewState extends ConsumerState<CreateTaskStatusView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(createTaskStatusControllerProvider, (_, state) {
      if (state is CreateTaskStatusSuccess) {
        ref.read(taskStatusSettingsControllerProvider.notifier).addStatus(state.status);
        return;
      }
      if (state is CreateTaskStatusError) {
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

    final isLoading = ref.watch(createTaskStatusControllerProvider).isLoading;

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: FormField(
        validator: (_) {
          if (_nameController.text.trim().isEmpty) {
            return 'Please enter a status name';
          }
          return null;
        },
        builder: (field) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 32,
                runSpacing: 16,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: AppInputDecorations().filledTheme(Theme.of(context).colorScheme).copyWith(
                      hintText: 'Type a new status name',
                      constraints: const BoxConstraints(
                        maxWidth: 500,
                      ),
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              ref
                                  .read(
                                    createTaskStatusControllerProvider.notifier,
                                  )
                                  .createTaskStatus(
                                    _nameController.text,
                                  );
                            }
                          },
                    icon: const Icon(Icons.add),
                    label: isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                              ),
                            ),
                          )
                        : const Text('Add Status'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (field.hasError)
                Text(
                  field.errorText!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
