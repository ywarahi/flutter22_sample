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
  Timestamp? toJson(DateTime? date) =>
      date != null ? Timestamp.fromDate(date) : null;
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

  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);

  // DocumentSnapshotをTodoItemに変換
  factory TodoItem.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;

    //print(data.toString());
    //{finishedAt: null, tags: [DEFAULT], title: 1st, description: 1111, updatedAt: Timestamp(seconds=1637643176, nanoseconds=650709000), createdAt: Timestamp(seconds=1636528992, nanoseconds=456566000)}

    // copyWithにてdoc.idをidにコピー
    return TodoItem.fromJson(data).copyWith(id: doc.id);
  }

  factory TodoItem.fromAlgolia(Map<String, dynamic> data) {
    //print(data.toString());
    //{createdAt: 1636528992457, description: 1111, tags: [DEFAULT], title: 1st, updatedAt: 1637643176651, path: todo_item/b8tBqTXuHNseMKlJacP1, lastmodified: 1637643177206, objectID: b8tBqTXuHNseMKlJacP1}

    data['createdAt'] = Timestamp.fromMillisecondsSinceEpoch(data['createdAt'] as int);
    data['updatedAt'] = Timestamp.fromMillisecondsSinceEpoch(data['updatedAt'] as int);

    //print(data.toString());
    //{createdAt: Timestamp(seconds=1636528992, nanoseconds=457000000), description: 1111, tags: [DEFAULT], title: 1st, updatedAt: Timestamp(seconds=1637643176, nanoseconds=651000000), path: todo_item/b8tBqTXuHNseMKlJacP1, lastmodified: 1637643177206, objectID: b8tBqTXuHNseMKlJacP1}

    return TodoItem.fromJson(data).copyWith(id: data['objectID'] as String);
  }

  // TodoItemをMap<String, dynamic>に変換
  Map<String, dynamic> toDocument() => toJson()..remove('id');
}
