// flutter_riverpod

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'sample.dart';
//import 'riverpod/a00_stateful_widget.dart';
//import 'riverpod/a01_riverpod_provider.dart';
//import 'riverpod/a02_riverpod_provider.dart';
//import 'riverpod/a03_riverpod_state_provider.dart';
//import 'riverpod/a04_riverppd_state_notifier_provider.dart';
//import 'riverpod/a05_riverpod_change_notifier_provider.dart';
//import 'riverpod/a06_riverpod_future_provider.dart';
//import 'riverpod/a07_riverpod_stream_provider.dart';
//import 'riverpod/a08_riverpod_provider_listner.dart';
//import 'riverpod/a09_riverpod_scoped_provider.dart';
//import 'riverpod/a10_reverpod_refresh.dart';
import 'widget/a01_bottom_navigation_bar.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

// import 'riverpod/a11_riverpod_provider_scope_overrides.dart';
// void main() {
//   sub();
// }
