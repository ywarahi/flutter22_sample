import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import 'model/todo_model.dart';

final todoListNotifierProvider =
    StateNotifierProvider<TodoListStateNotifier, AsyncValue<List<TodoModel>>>(
  (ref) => TodoListStateNotifier(),
);

class TodoListStateNotifier extends StateNotifier<AsyncValue<List<TodoModel>>> {
  TodoListStateNotifier() : super(const AsyncValue.loading()) {
    Future<void>.delayed(const Duration(seconds: 5), () {
      state = const AsyncValue.data(<TodoModel>[
        TodoModel(id: 'id', title: 'title-1'),
        TodoModel(id: 'id', title: 'title-2'),
        TodoModel(id: 'id', title: 'title-3'),
      ]);
    });
  }

  Future<void> add(TodoModel todo) async {
    final current = state.maybeWhen(
      data: (value) => value,
      orElse: () => <TodoModel>[],
    );

    // dummy loading
    // state = const AsyncValue.loading();
    // await Future<void>.delayed(const Duration(seconds: 3));

    state = AsyncValue.data(List.of(current)..add(todo));
  }
}
