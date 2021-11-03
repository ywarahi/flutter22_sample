import 'package:flutter22_sample/app_todo/model/todo_property.dart';
import 'package:flutter22_sample/app_todo/repository/todo_property_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

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
