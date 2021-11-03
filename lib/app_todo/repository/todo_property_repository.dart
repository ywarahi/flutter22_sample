import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter22_sample/app_todo/custom_exception.dart';
import 'package:flutter22_sample/app_todo/model/todo_property.dart';
import 'package:flutter22_sample/app_todo/repository/todo_firebase_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final todoPropertyRepositoryProvider =
    Provider<TodoPropertyRepository>((ref) => TodoPropertyRepository(ref.read));

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
