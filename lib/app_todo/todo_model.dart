import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
abstract class TodoModel with _$TodoModel {
  const factory TodoModel({
    required String id,
    @Default('NO TITLE') String title,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? finishedAt,
}) = _TodoModel;

 factory TodoModel.fromJson(Map<String, dynamic> json) => _$TodoModelFromJson(json);
}