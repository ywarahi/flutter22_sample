import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

// DateTime? _dateFromTimeStamp(dynamic value) => (value as Timestamp)?.toDate();
//
// Timestamp? _timestampFromDate(dynamic value) =>
//     value is DateTime ? Timestamp.fromDate(value) : null;
// const timestampKey =
//     JsonKey(fromJson: _dateFromTimeStamp, toJson: _timestampFromDate);
// const listKey =
// JsonKey(fromJson: _dateFromTimeStamp, toJson: _timestampFromDate);
//
// @timestampKey DateTime? createdAt,
// @timestampKey DateTime? updatedAt,
// @timestampKey DateTime? finishedAt,

class TagsConverter implements JsonConverter<List<String>?, List<dynamic>?> {
  const TagsConverter();

  @override
  List<String>? fromJson(List<dynamic>? listDynamic) {
    //return listDynamic != null ? listDynamic.map((dynamic e) => e as String).toList() : <String>[];
    return listDynamic != null ? listDynamic.cast<String>() : <String>[];
  }

  @override
  List<dynamic>? toJson(List<String>? listString) {
    return listString != null ? List<dynamic>.from(listString) : <dynamic>[];
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
abstract class TodoModel with _$TodoModel {
  const TodoModel._();
  const factory TodoModel({
    String? id,
    String? title,
    String? description,
    @TagsConverter() List<String>? tags,
    @DateTimeConverter() DateTime? createdAt,
    @DateTimeConverter() DateTime? updatedAt,
    @DateTimeConverter() DateTime? finishedAt,
  }) = _TodoModel;

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  // DocumentSnapshotをTodoModelに変換
  factory TodoModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    // copyWithにてdoc.idをidにコピー
    return TodoModel.fromJson(data).copyWith(id: doc.id);
  }

  // TodoModelをMap<String, dynamic>に変換
  Map<String, dynamic> toDocument() => toJson()..remove('id');
}
