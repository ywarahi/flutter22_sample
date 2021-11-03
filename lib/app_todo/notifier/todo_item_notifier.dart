import 'package:flutter22_sample/app_todo/model/todo_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

// TodoItem for update
final todoItemProvider = StateProvider<TodoItem>((ref) => const TodoItem());
