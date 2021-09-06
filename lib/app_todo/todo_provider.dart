import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'custom_exception.dart';
import 'model/todo_model.dart';
import 'todo_repository.dart';

final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final todoListExceptionProvider = StateProvider<CustomException?>((_) => null);

final todoListNotifierProvider =
    StateNotifierProvider<TodoListStateNotifier, AsyncValue<List<TodoModel>>>(
  (ref) => TodoListStateNotifier(ref.read),
);

class TodoListStateNotifier extends StateNotifier<AsyncValue<List<TodoModel>>> {
  final Reader _read;

  TodoListStateNotifier(this._read) : super(const AsyncValue.loading()) {
    retrieveItems();
    // Future<void>.delayed(const Duration(seconds: 5), () {
    //   state = const AsyncValue.data(<TodoModel>[
    //     TodoModel(id: 'id', title: 'title-1'),
    //     TodoModel(id: 'id', title: 'title-2'),
    //     TodoModel(id: 'id', title: 'title-3'),
    //   ]);
    // });
  }

  Future<void> retrieveItems({bool isRefreshing = false}) async {
    if (isRefreshing) state = const AsyncValue.loading();
    try {
      final items = await _read(todoRepositoryProvider).retrieveItems();
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> add(String title) async {
    try {
      final dtoItem = TodoModel(
          title: title, createdAt: DateTime.now(), updatedAt: DateTime.now());
      final newItem =
          await _read(todoRepositoryProvider).createItem(item: dtoItem);
      state.whenData((items) => state = AsyncValue.data(items..add(newItem)));
    } on CustomException catch (e) {
      _read(todoListExceptionProvider).state = e;
    }
    // final current = state.maybeWhen(
    //   data: (value) => value,
    //   orElse: () => <TodoModel>[],
    // );
    //
    // // dummy loading
    // // state = const AsyncValue.loading();
    // // await Future<void>.delayed(const Duration(seconds: 3));
    //
    // state = AsyncValue.data(List.of(current)..add(todo));
  }
}
