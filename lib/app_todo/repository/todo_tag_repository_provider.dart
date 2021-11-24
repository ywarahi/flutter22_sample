import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter22_sample/app_todo/custom_exception.dart';
import 'package:flutter22_sample/app_todo/model/todo_tag.dart';
import 'package:flutter22_sample/app_todo/repository/firebase_firestore_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final todoTagRepositoryProvider =
    Provider<TodoTagRepository>((ref) => TodoTagRepository(ref.read));

// FirestoreからのTagデータ取得・更新
abstract class TodoTagIF {
  Future<List<TodoTag>> retrieveItems();

  Future<TodoTag> createItem({required TodoTag item});

  Future<void> updateItem({required TodoTag item});

  Future<void> deleteItem({required TodoTag item});
}

// FirestoreからのTagデータ取得・更新
class TodoTagRepository implements TodoTagIF {
  const TodoTagRepository(this._read);

  final Reader _read;

  @override
  Future<List<TodoTag>> retrieveItems() async {
    try {
      final snap = await _read(firebaseFirestoreProvider)
          .collection('todo_tag')
          .orderBy('name', descending: false)
          .get();
      return snap.docs.map((doc) => TodoTag.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<TodoTag> createItem({required TodoTag item}) async {
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .collection('todo_tag')
          .add(item.toDocument());
      return item.copyWith(id: docRef.id);
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> updateItem({required TodoTag item}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .collection('todo_tag')
          .doc(item.id)
          .update(item.toDocument());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> deleteItem({required TodoTag item}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .collection('todo_tag')
          .doc(item.id)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
