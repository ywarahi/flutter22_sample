import 'package:algolia/algolia.dart';
import 'package:flutter22_sample/app_todo/model/todo_item.dart';
import 'package:flutter22_sample/app_todo/repository/algolia_search_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

// TagList-StateProvider
final queryStateProvider = StateProvider<String>((_) => '');

// Searched-List-Provider
final searchedListProvider =
    StateNotifierProvider<SearchedStateNotifier, List<TodoItem>>(
        (ref) {
  final queryString = ref.watch(queryStateProvider).state;
  final searchAV = ref.watch(algoliaSearchProvider);
  return SearchedStateNotifier(queryString, searchAV);
});

class SearchedStateNotifier extends StateNotifier<List<TodoItem>> {
  SearchedStateNotifier(this._queryString, this._searchAV)
      : super(<TodoItem>[]) {
    query();
  }

  final String _queryString;
  final AsyncValue<Algolia> _searchAV;

  void query() {
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

// Searched-List-Provider
final searchedListProvider2 =
StateNotifierProvider<SearchedStateNotifier2, List<AlgoliaObjectSnapshot>>(
        (ref) {
      final queryString = ref.watch(queryStateProvider).state;
      final searchAV = ref.watch(algoliaSearchProvider);
      return SearchedStateNotifier2(queryString, searchAV);
    });

class SearchedStateNotifier2 extends StateNotifier<List<AlgoliaObjectSnapshot>> {
  SearchedStateNotifier2(this._queryString, this._searchAV)
      : super(<AlgoliaObjectSnapshot>[]) {
    query();
  }

  final String _queryString;
  final AsyncValue<Algolia> _searchAV;

  void query() {
    _searchAV.when(data: (search) async {
      var query = search.instance.index('TodoItem').query(_queryString);
      var snap = await query.getObjects();
      state = snap.hits;
      final items = state.map<TodoItem>((e) => TodoItem.fromAlgolia(e.data)).toList();
      print(items.toString());
    }, loading: () {
      state = <AlgoliaObjectSnapshot>[];
    }, error: (_, __) {
      state = <AlgoliaObjectSnapshot>[];
    });
  }
}
