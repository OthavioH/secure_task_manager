import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_rpg_system/core/utils/size_utils.dart';
import 'package:simple_rpg_system/features/user/presentation/views/create_account_screen/controller/create_account_controller.dart';
import 'package:simple_rpg_system/features/user/presentation/views/create_account_screen/controller/create_account_state.dart';
import 'package:simple_rpg_system/shared/widgets/gradient_background.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  ConsumerState<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  void onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      ref
          .read(createAccountControllerProvider.notifier)
          .createAccount(
            username: _usernameController.text,
            password: _passwordController.text,
          );
    }
  }

  void onError(CreateAccountFailure error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(error.error),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void onSuccess() {
    context.pop(true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Account created! Sign in to check your tasks!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    ref.listenManual(createAccountControllerProvider, (previous, next) {
      if (next is CreateAccountSuccess) {
        onSuccess();
      } else if (next is CreateAccountFailure) {
        onError(next);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(createAccountControllerProvider).isLoading;

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Create Account'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SizeUtils.kHorizontalPadding,
            vertical: SizeUtils.kVerticalPadding,
          ),
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: _formKey,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a valid username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            hidePassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                        ),
                      ),
                      obscureText: hidePassword,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a valid password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _confirmPasswordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: 'Confirm password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            hideConfirmPassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              hideConfirmPassword = !hideConfirmPassword;
                            });
                          },
                        ),
                      ),
                      obscureText: hideConfirmPassword,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a valid password';
                        }
      
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
      
                        if (value != _passwordController.text) {
                          return 'Passwords are not equal';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: isLoading ? null : () => onSubmit(),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              padding: EdgeInsets.all(8),
                            )
                          : const Text('Create account'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
