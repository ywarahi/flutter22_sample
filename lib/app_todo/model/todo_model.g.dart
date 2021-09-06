// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TodoModel _$_$_TodoModelFromJson(Map<String, dynamic> json) {
  return _$_TodoModel(
    id: json['id'] as String?,
    title: json['title'] as String? ?? 'NO TITLE',
    description: json['description'] as String?,
    createdAt: _dateFromTimeStamp(json['createdAt']),
    updatedAt: _dateFromTimeStamp(json['updatedAt']),
    finishedAt: _dateFromTimeStamp(json['finishedAt']),
  );
}

Map<String, dynamic> _$_$_TodoModelToJson(_$_TodoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'createdAt': _timestampFromDate(instance.createdAt),
      'updatedAt': _timestampFromDate(instance.updatedAt),
      'finishedAt': _timestampFromDate(instance.finishedAt),
    };
