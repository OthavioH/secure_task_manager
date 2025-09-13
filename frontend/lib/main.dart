import 'package:flutter/material.dart';
import 'package:simple_rpg_system/core/config/environment_config.dart';
import 'package:simple_rpg_system/routes/app_router.dart';
import 'package:simple_rpg_system/shared/providers/providers_initializer.dart';
import 'package:simple_rpg_system/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Secure Task Manager',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ),
  );
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
    return initializerValue.when(
      data: (data) => MaterialApp.router(
        title: 'Secure Task Manager',
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
      ),
      error: (error, stackTrace) => MaterialApp(
        title: 'Secure Task Manager',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      loading: () => MaterialApp(
        title: 'Secure Task Manager',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
