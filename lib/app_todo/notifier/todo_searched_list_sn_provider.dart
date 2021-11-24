import 'package:algolia/algolia.dart';
import 'package:flutter22_sample/app_todo/model/todo_item.dart';
import 'package:flutter22_sample/app_todo/repository/algolia_av_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

// TagList-StateProvider
final queryStateProvider = StateProvider<String>((_) => '1');

// Searched-List-Provider
final todoSearchedListSNProvider =
    StateNotifierProvider<TodoSearchedListStateNotifier, List<TodoItem>>(
        (ref) {
  final queryString = ref.watch(queryStateProvider).state;
  final algoliaAV = ref.watch(algoliaAVProvider);
  return TodoSearchedListStateNotifier(queryString, algoliaAV, <TodoItem>[]);
});

class TodoSearchedListStateNotifier extends StateNotifier<List<TodoItem>> {
  TodoSearchedListStateNotifier(this._queryString, this._searchAV, this._initData)
      : super(_initData) {
    query();
  }

  final List<TodoItem> _initData;
  final String _queryString;
  final AsyncValue<Algolia> _searchAV;

  void query() {
    if (_queryString.isEmpty) {return;}

    _searchAV.when(data: (search) async {
      var query = search.instance.index('TodoItem').query(_queryString);
      var snap = await query.getObjects();
      state = snap.hits.map<TodoItem>((e) => TodoItem.fromAlgolia(e.data)).toList();
    }, loading: () {
      state = <TodoItem>[];
    }, error: (_, __) {
      state = <TodoItem>[];
    });
  }
}
