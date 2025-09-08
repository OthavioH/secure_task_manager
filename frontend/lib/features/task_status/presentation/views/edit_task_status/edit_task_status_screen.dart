import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/core/utils/size_utils.dart';
import 'package:simple_rpg_system/features/task_status/domain/models/task_status.dart';
import 'package:simple_rpg_system/features/task_status/presentation/views/edit_task_status/controllers/edit_task_status_controller.dart';
import 'package:simple_rpg_system/features/task_status/presentation/views/edit_task_status/controllers/edit_task_status_state.dart';

class EditTaskStatusScreen extends ConsumerStatefulWidget {
	final TaskStatus status;
	const EditTaskStatusScreen({super.key, required this.status});

	@override
	ConsumerState<EditTaskStatusScreen> createState() => _EditTaskStatusScreenState();
}

class _EditTaskStatusScreenState extends ConsumerState<EditTaskStatusScreen> {
	final _formKey = GlobalKey<FormState>();
	late final TextEditingController _nameController;

	@override
	void initState() {
		super.initState();
		_nameController = TextEditingController(text: widget.status.name);
	}

	@override
	Widget build(BuildContext context) {
		ref.listen(editTaskStatusControllerProvider, (_, state) {
			if (state is EditTaskStatusSuccess) {
				Navigator.of(context).pop(state.status);
			}
			if (state is EditTaskStatusError) {
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

		final isLoading = ref.watch(editTaskStatusControllerProvider).isLoading;

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
														.read(editTaskStatusControllerProvider.notifier)
														.editTaskStatus(
															id: widget.status.id,
															name: _nameController.text,
														);
											}
										},
							style: FilledButton.styleFrom(
								minimumSize: const Size.fromHeight(60),
							),
							child: isLoading
									? const SizedBox(
											height: 24,
											width: 24,
											child: Center(
												child: CircularProgressIndicator(strokeWidth: 2.5),
											),
										)
									: const Text('Save Changes'),
						),
					],
				),
			),
		);
	}
}
