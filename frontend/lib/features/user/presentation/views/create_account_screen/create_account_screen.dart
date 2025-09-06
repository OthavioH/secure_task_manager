import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_rpg_system/core/utils/size_utils.dart';
import 'package:simple_rpg_system/features/auth/routes/auth_routes.dart';
import 'package:simple_rpg_system/features/user/presentation/views/create_account_screen/controller/create_account_controller.dart';
import 'package:simple_rpg_system/features/user/presentation/views/create_account_screen/controller/create_account_state.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
        title: Text('Error'),
        content: Text(error.error),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void onSuccess() {
    context.go(AuthRoutes.loginRoute);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
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
  Widget build(BuildContext context) {
    ref.listen(
      createAccountControllerProvider,
      (_, state) {
        if (state is CreateAccountSuccess) {
          return onSuccess();
        } else if (state is CreateAccountFailure) {
          return onError(state);
        }
      },
    );

    final isLoading = ref.watch(createAccountControllerProvider).isLoading;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SizeUtils.kHorizontalPadding,
          vertical: SizeUtils.kVerticalPadding,
        ),
        child: Form(
          autovalidateMode: AutovalidateMode.onUnfocus,
          key: _formKey,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
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
                      ? const CircularProgressIndicator()
                      : const Text('Create account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
