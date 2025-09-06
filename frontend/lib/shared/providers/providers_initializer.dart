
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_rpg_system/shared/providers/shared_preferences_provider.dart';

final providersInitializedProvider = FutureProvider<void>((ref) async {
  await ref.watch(sharedPreferencesProvider.future);
});