// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TodoProperty _$_$_TodoPropertyFromJson(Map<String, dynamic> json) {
  // print(json['mapStr'].runtimeType);
  // print(json['mapStr'] as Map<String, dynamic>);
  // print(json['mapStr'] as Map<dynamic, dynamic>);
  // print(json['mapStr'] as Map<String, dynamic>?);
  // print(json['mapStr'] as Map<dynamic, dynamic>?);

  return _$_TodoProperty(
    id: json['id'] as String?,
    name: json['name'] as String?,
    mapStr: const MapStrConverter().fromJson(json['mapStr'] as Map?),
  );
}

Map<String, dynamic> _$_$_TodoPropertyToJson(_$_TodoProperty instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mapStr': const MapStrConverter().toJson(instance.mapStr),
    };
