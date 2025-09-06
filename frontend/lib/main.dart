import 'package:flutter/material.dart';
import 'package:simple_rpg_system/core/config/environment_config.dart';
import 'package:simple_rpg_system/routes/app_router.dart';
import 'package:simple_rpg_system/shared/providers/providers_initializer.dart';
import 'package:simple_rpg_system/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await EnvironmentConfig.instance.initialize();
  runApp(
    ProviderScope(
      child: const MainApp(),
    ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initializerValue = ref.watch(providersInitializedProvider);
    return initializerValue.when(
      data: (data) => MaterialApp.router(
        key: navigatorKey,
        routerConfig: AppRouter.router,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
      ),
      error: (error, stackTrace) => MaterialApp(
        home: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      loading: () => MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        home: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
