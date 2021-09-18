// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TodoModel _$_$_TodoModelFromJson(Map<String, dynamic> json) {
  return _$_TodoModel(
    id: json['id'] as String?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    tags: const TagsConverter().fromJson(json['tags'] as List?),
    createdAt:
        const DateTimeConverter().fromJson(json['createdAt'] as Timestamp?),
    updatedAt:
        const DateTimeConverter().fromJson(json['updatedAt'] as Timestamp?),
    finishedAt:
        const DateTimeConverter().fromJson(json['finishedAt'] as Timestamp?),
  );
}

Map<String, dynamic> _$_$_TodoModelToJson(_$_TodoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'tags': const TagsConverter().toJson(instance.tags),
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'updatedAt': const DateTimeConverter().toJson(instance.updatedAt),
      'finishedAt': const DateTimeConverter().toJson(instance.finishedAt),
    };
