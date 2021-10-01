import 'package:riverpod/riverpod.dart';

import 'model/todo_property.dart';
import 'todo_repository.dart';

final todoPropertyStateNotifierProvider = StateNotifierProvider<
    TodoPropertyStateNotifier, AsyncValue<TodoProperty>>((ref) {
      return TodoPropertyStateNotifier(ref.read);
});

class TodoPropertyStateNotifier
    extends StateNotifier<AsyncValue<TodoProperty>> {
  TodoPropertyStateNotifier(this._read)
      : super(const AsyncValue.loading()) {
    readProperty();
  }

  final Reader _read;

  Future<void> readProperty() async {
    final repository = _read(todoPropertyRepositoryProvider);
    final property = await repository.getTodoProperty();
    state = AsyncData(property);
  }
}
