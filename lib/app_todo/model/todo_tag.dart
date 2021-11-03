import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'todo_tag.freezed.dart';
part 'todo_tag.g.dart';

@freezed
abstract class TodoTag with _$TodoTag {
  const factory TodoTag({
    String? id,
    String? name,
  }) = _TodoTag;

 factory TodoTag.fromJson(Map<String, dynamic> json) => _$TodoTagFromJson(json);
  const TodoTag._();

  // DocumentSnapshotをTodoTagに変換
  factory TodoTag.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    // copyWithにてdoc.idをidにコピー
    return TodoTag.fromJson(data).copyWith(id: doc.id);
  }

  // TodoModelをMap<String, dynamic>に変換
  Map<String, dynamic> toDocument() => toJson()..remove('id');
}