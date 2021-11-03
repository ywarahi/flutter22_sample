import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_item.freezed.dart';
part 'todo_item.g.dart';

class TagsConverter implements JsonConverter<List<String>?, List<dynamic>?> {
  const TagsConverter();

  @override
  List<String>? fromJson(List<dynamic>? listDynamic) {
    return listDynamic != null ? listDynamic.cast<String>() : <String>[];
    //return listDynamic != null ? listDynamic.map((dynamic e) => e as String).toList() : <String>[];
  }

  @override
  List<dynamic>? toJson(List<String>? listString) {
    return listString != null ? listString.cast<dynamic>() : <dynamic>[];
    //return listString != null ? List<dynamic>.from(listString) : <dynamic>[];
  }
}

class DateTimeConverter implements JsonConverter<DateTime?, Timestamp?> {
  const DateTimeConverter();

  @override
  DateTime? fromJson(Timestamp? timestamp) {
    return timestamp?.toDate();
  }

  @override
  Timestamp? toJson(DateTime? date) => date != null ? Timestamp.fromDate(date) : null;
}

@freezed
abstract class TodoItem with _$TodoItem {
  const TodoItem._();
  const factory TodoItem({
    String? id,
    String? title,
    String? description,
    @TagsConverter() List<String>? tags,
    @DateTimeConverter() DateTime? createdAt,
    @DateTimeConverter() DateTime? updatedAt,
    @DateTimeConverter() DateTime? finishedAt,
  }) = _TodoItem;

 factory TodoItem.fromJson(Map<String, dynamic> json) => _$TodoItemFromJson(json);

  // DocumentSnapshotをTodoItemに変換
  factory TodoItem.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    // copyWithにてdoc.idをidにコピー
    return TodoItem.fromJson(data).copyWith(id: doc.id);
  }

  // TodoItemをMap<String, dynamic>に変換
  Map<String, dynamic> toDocument() => toJson()..remove('id');
}