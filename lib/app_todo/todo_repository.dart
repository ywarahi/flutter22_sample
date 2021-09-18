import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter22_sample/app_todo/model/todo_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import 'custom_exception.dart';

// FirebaseFirestor-Provider
final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

abstract class TodoRepositoryIF {
  Future<List<TodoModel>> retrieveItems();
  Future<TodoModel> createItem({required TodoModel item});
  Future<void> updateItem({required TodoModel item});
  Future<void> deleteItem({required TodoModel item});
}

final todoRepositoryProvider =
    Provider<TodoRepository>((ref) => TodoRepository(ref.read));

// FirestoreからのTODOデータ取得・更新
class TodoRepository implements TodoRepositoryIF {
  const TodoRepository(this._read);

  final Reader _read;

  @override
  Future<List<TodoModel>> retrieveItems() async {
    try {
      final snap = await _read(firebaseFirestoreProvider)
          .collection('todo')
          //.where('tags', arrayContains: 'toREAD')
          .orderBy('createdAt', descending: true)
          //.limit(1)
          .get();
      return snap.docs.map((doc) => TodoModel.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<TodoModel> createItem({required TodoModel item}) async {
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .collection('todo')
          .add(item.toDocument());
      return item.copyWith(id: docRef.id);
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> updateItem({required TodoModel item}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .collection('todo')
          .doc(item.id)
          .update(item.toDocument());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> deleteItem({required TodoModel item}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .collection('todo')
          .doc(item.id)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
