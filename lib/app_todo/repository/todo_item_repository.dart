import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter22_sample/app_todo/custom_exception.dart';
import 'package:flutter22_sample/app_todo/model/todo_item.dart';
import 'package:flutter22_sample/app_todo/repository/firebase_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

const collectionName = 'todo_item'; //'todo'

final todoItemRepositoryProvider =
    Provider<TodoItemRepository>((ref) => TodoItemRepository(ref.read));

// FirestoreからのTODOデータ取得・更新
abstract class TodoItemRepositoryIF {
  Future<List<TodoItem>> retrieveItems();

  Future<TodoItem> createItem({required TodoItem item});

  Future<void> updateItem({required TodoItem item});

  Future<void> deleteItem({required TodoItem item});
}

// FirestoreからのTODOデータ取得・更新
class TodoItemRepository implements TodoItemRepositoryIF {
  const TodoItemRepository(this._read);

  final Reader _read;

  @override
  Future<List<TodoItem>> retrieveItems() async {
    try {
      final snap = await _read(firebaseFirestoreProvider)
          .collection(collectionName)
          //.where('tags', arrayContains: 'toREAD')
          .orderBy('createdAt', descending: true)
          //.limit(1)
          .get();
      return snap.docs.map((doc) => TodoItem.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<TodoItem> createItem({required TodoItem item}) async {
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .collection(collectionName)
          .add(item.toDocument());
      return item.copyWith(id: docRef.id);
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> updateItem({required TodoItem item}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .collection(collectionName)
          .doc(item.id)
          .update(item.toDocument());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> deleteItem({required TodoItem item}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .collection(collectionName)
          .doc(item.id)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
