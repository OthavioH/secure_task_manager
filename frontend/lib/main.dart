import 'package:flutter/material.dart';
import 'package:simple_rpg_system/core/config/environment_config.dart';
import 'package:simple_rpg_system/routes/app_router.dart';
import 'package:simple_rpg_system/shared/providers/providers_initializer.dart';
import 'package:simple_rpg_system/shared/providers/theme_controller.dart';
import 'package:simple_rpg_system/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvironmentConfig.instance.initialize();
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initializerValue = ref.watch(providersInitializedProvider);
    return MaterialApp.router(
      title: 'Secure Task Manager',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      builder: (context, child) {
        return initializerValue.when(
          data: (data) => Consumer(
            builder: (context, themeRef, _) {
              final themeMode = ref.watch(themeProvider);
              return Theme(
                data: themeMode == ThemeMode.dark
                    ? AppTheme.darkTheme
                    : AppTheme.lightTheme,
                child: child!,
              );
            },
          ),
          error: (error, stackTrace) => Scaffold(
            body: Center(
              child: Text('Error: $error'),
            ),
          ),
          loading: () => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
