import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final countProvider =
    StateNotifierProvider<CountStateNotifier, AsyncValue<int>>(
  (ref) => CountStateNotifier(),
);

class CountStateNotifier extends StateNotifier<AsyncValue<int>> {
  CountStateNotifier() : super(const AsyncValue.loading()) {
    Future<void>.delayed(const Duration(seconds: 5), () {
      state = const AsyncValue.data(0);
    });
  }

  Future<void> add() async {
    final current = state.maybeWhen(
      data: (value) => value,
      orElse: () => -1,
    );

    // dummy loading
    state = const AsyncValue.loading();
    await Future<void>.delayed(const Duration(seconds: 3));

    state = AsyncValue.data(current + 1);
  }
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final counter = context.read(countProvider.notifier);
    final count = watch(countProvider);

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod x AsyncValue'),
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: count.when(data: (data) {
                return counter.add;
              }, loading: () {
                return null;
              }, error: (_, __) {
                return null;
              }),
              child: count.when(data: (data) {
                return Text('Count: $data');
              }, loading: () {
                return const Text('Count: loading... ');
              }, error: (_, __) {
                return const Text('Error!!');
              }))),
    ));
  }
}
