import 'package:algolia/algolia.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import 'json_file_state_notifier.dart';

final _algoliaSettingProvider = StateNotifierProvider<JsonFileStateNotifier,
    AsyncValue<Map<String, dynamic>>>(
  (ref) => JsonFileStateNotifier('assets/algolia.json'),
);

final algoliaSearchProvider = Provider<AsyncValue<Algolia>>((ref) {
  var result = const AsyncValue<Algolia>.loading();
  final algoliaSettingAV = ref.watch(_algoliaSettingProvider)
    ..when(data: (map) {
      result = AsyncData(Algolia.init(
          applicationId: map['applicationId'] as String,
          apiKey: map['apiKey'] as String));
    }, loading: () {
      result = const AsyncValue<Algolia>.loading();
    }, error: (_, __) {
      result = const AsyncValue<Algolia>.loading();
    });
  return result;
});
