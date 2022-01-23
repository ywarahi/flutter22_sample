import 'package:flutter22_sample/app_todo/custom_exception.dart';
import 'package:flutter22_sample/app_todo/model/todo_tag.dart';
import 'package:flutter22_sample/app_todo/repository/todo_tag_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final todoListExceptionProvider = StateProvider<CustomException?>((_) => null);

// TagList-NotifierProvider
final todoTagListSNProvider =
  StateNotifierProvider<TagListStateNotifier, List<TodoTag>>(
      (ref) => TagListStateNotifier(ref.read),
);

// TagListの状態管理
class TagListStateNotifier extends StateNotifier<List<TodoTag>> {
  TagListStateNotifier(this._read) : super(const <TodoTag>[]) {
    retrieveItems();
  }

  final Reader _read;

  Future<void> retrieveItems({bool isRefreshing = false}) async {
    if (isRefreshing) {
      state = const <TodoTag>[];
    }
    try {
      final items = await _read(todoTagRepositoryProvider).retrieveItems();
      if (mounted) {
        state = items;
      }
    } on CustomException catch (e, st) {
      _read(todoListExceptionProvider).state = e;
    }
  }
}

// class TagListStateNotifier extends StateNotifier<AsyncValue<List<TodoTag>>> {
//   TagListStateNotifier(this._read) : super(const AsyncValue.loading()) {
//     retrieveItems();
//   }
//
//   final Reader _read;
//
//   Future<void> retrieveItems({bool isRefreshing = false}) async {
//     if (isRefreshing) {
//       state = const AsyncValue.loading();
//     }
//     try {
//       final items = await _read(todoTagRepositoryProvider).retrieveItems();
//       if (mounted) {
//         state = AsyncValue.data(items);
//       }
//     } on CustomException catch (e, st) {
//       state = AsyncValue.error(e, st);
//     }
//   }
// }
