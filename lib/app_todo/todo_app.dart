import 'package:flutter/material.dart';
import 'package:flutter22_sample/app_todo/todo_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

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
    state = const AsyncValue.loading();
    await Future<void>.delayed(const Duration(seconds: 3));

    state = AsyncValue.data(List.of(current)..add(todo));
  }
}

final currentIndex = ScopedProvider<int>((watch) => throw UnimplementedError());

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Riverpod x AsyncValue'),
          ),
          body: TodoListView(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ));
  }
}

class TodoListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final notifier = context.read(todoListNotifierProvider.notifier);
    final todoListAV = watch(todoListNotifierProvider);
    // todoList.when(
    //     data: (data) {},
    //     loading: () {},
    //     error: (_,__) {}
    //     );
    return ListView.builder(
      itemCount: todoListAV?.data?.value?.length,
      itemBuilder: (context, index) {
        return ProviderScope(
          overrides: [currentIndex.overrideWithValue(index)],
          child: const TodoItemView(),
        );
      },
    );
  }
}

class TodoItemView extends ConsumerWidget {
  const TodoItemView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final todoListAV = watch(todoListNotifierProvider);
    final index = watch(currentIndex);
    final titleStr = todoListAV?.data?.value?[index].title;
    return ListTile(title: Text(titleStr!));
  }

  // @override
  // Widget build(BuildContext context, ScopedReader watch) {
  //   // アイテムのIndexを取得
  //   final index = watch(currentIndex);
  //   return ListTile(title: Text('$index番目のLIST'));
  // }
}
