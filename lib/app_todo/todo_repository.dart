import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter22_sample/app_todo/model/todo_model.dart';
import 'package:flutter22_sample/app_todo/model/todo_property.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import 'custom_exception.dart';

// FirebaseFirestor-Provider
final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final todoRepositoryProvider =
    Provider<TodoRepository>((ref) => TodoRepository(ref.read));

final todoPropertyRepositoryProvider =
    Provider<TodoPropertyRepository>((ref) => TodoPropertyRepository(ref.read));

// FirestoreからのTODOデータ取得・更新
abstract class TodoRepositoryIF {
  Future<List<TodoModel>> retrieveItems();

  Future<TodoModel> createItem({required TodoModel item});

  Future<void> updateItem({required TodoModel item});

  Future<void> deleteItem({required TodoModel item});
}

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

// FirestoreからのProperty取得
abstract class TodoPropertyRepositoryIF {
  Future<TodoProperty> getTodoProperty();
}

// FirestoreからのProperty取得
class TodoPropertyRepository implements TodoPropertyRepositoryIF {
  const TodoPropertyRepository(this._read);

  final Reader _read;

  @override
  Future<TodoProperty> getTodoProperty() async {
    try {
      final snap = await _read(firebaseFirestoreProvider)
          .collection('todo_property')
          .where('name', isEqualTo: 'map_str')
          //.orderBy('createdAt', descending: true)
          .limit(1)
          .get();
      final props =
          snap.docs.map((doc) => TodoProperty.fromDocument(doc)).toList();
      return props[0];
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
