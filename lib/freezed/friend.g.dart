// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Friend _$_$_FriendFromJson(Map<String, dynamic> json) {
  return _$_Friend(
    json['id'] as String,
    name: json['name'] as String,
    age: json['age'] as int?,
    hasChild: json['hasChild'] as bool? ?? false,
  );
}

Map<String, dynamic> _$_$_FriendToJson(_$_Friend instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'age': instance.age,
      'hasChild': instance.hasChild,
    };
