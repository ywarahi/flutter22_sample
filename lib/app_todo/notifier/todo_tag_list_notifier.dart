import 'package:flutter22_sample/app_todo/custom_exception.dart';
import 'package:flutter22_sample/app_todo/model/todo_tag.dart';
import 'package:flutter22_sample/app_todo/repository/todo_tag_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

// TagList-NotifierProvider
final tagListNotifierProvider =
  StateNotifierProvider<TagListStateNotifier, AsyncValue<List<TodoTag>>>(
      (ref) => TagListStateNotifier(ref.read),
);

// TodoListの状態管理
class TagListStateNotifier extends StateNotifier<AsyncValue<List<TodoTag>>> {
  TagListStateNotifier(this._read) : super(const AsyncValue.loading()) {
    retrieveItems();
  }

  final Reader _read;

  Future<void> retrieveItems({bool isRefreshing = false}) async {
    if (isRefreshing) {
      state = const AsyncValue.loading();
    }
    try {
      final items = await _read(todoTagRepositoryProvider).retrieveItems();
      if (mounted) {
        state = AsyncValue.data(items);
      }
    } on CustomException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
