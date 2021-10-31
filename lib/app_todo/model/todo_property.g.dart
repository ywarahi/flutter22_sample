// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TodoProperty _$_$_TodoPropertyFromJson(Map<String, dynamic> json) {
  return _$_TodoProperty(
    id: json['id'] as String?,
    name: json['name'] as String?,
    tags: const TagsConverter().fromJson(json['tags'] as List?),
    mapStr: const MapStrConverter().fromJson(json['mapStr'] as Map?),
  );
}

Map<String, dynamic> _$_$_TodoPropertyToJson(_$_TodoProperty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tags': const TagsConverter().toJson(instance.tags),
      'mapStr': const MapStrConverter().toJson(instance.mapStr),
    };
