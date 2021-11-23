import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

class JsonFileStateNotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  JsonFileStateNotifier(this.assetsPath) : super(const AsyncValue.loading()) {
    Future<void>(() async {
      final text = await rootBundle.loadString(assetsPath);
      final map = json.decode(text) as Map<String, dynamic>;
      state = AsyncValue.data(map);
    });
  }

  String assetsPath;
}
