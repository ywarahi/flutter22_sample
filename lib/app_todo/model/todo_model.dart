import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_model.freezed.dart';

part 'todo_model.g.dart';

DateTime? _dateFromTimeStamp(dynamic value) => (value as Timestamp)?.toDate();

Timestamp? _timestampFromDate(dynamic value) =>
    value is DateTime ? Timestamp.fromDate(value) : null;
const timestampKey =
    JsonKey(fromJson: _dateFromTimeStamp, toJson: _timestampFromDate);

@freezed
abstract class TodoModel with _$TodoModel {
  const TodoModel._();
  const factory TodoModel({
    String? id,
    @Default('NO TITLE') String title,
    String? description,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? finishedAt,
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
