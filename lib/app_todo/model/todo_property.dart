import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_property.freezed.dart';
part 'todo_property.g.dart';

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

class MapStrConverter implements JsonConverter<Map<String,String>?, Map<dynamic, dynamic>?> {
  const MapStrConverter();

  @override
  Map<String,String>? fromJson(Map<dynamic, dynamic>? mapDynamic) {
    return mapDynamic != null ? mapDynamic.cast<String,String>() : <String,String>{};
    //return mapDynamic != null ? mapDynamic.cast<String,String>() : <String,String>{};
  }

  @override
  Map<dynamic, dynamic>? toJson(Map<String,String>? mapString) {
    return mapString != null ? mapString.cast<dynamic, dynamic>() : <dynamic,dynamic>{};
  }
}

@freezed
abstract class TodoProperty with _$TodoProperty {
  const TodoProperty._();
  const factory TodoProperty({
    String? id,
    String? name,
    @TagsConverter() List<String>? tags,
    @MapStrConverter() Map<String, String>? mapStr
}) = _TodoProperty;

 factory TodoProperty.fromJson(Map<String, dynamic> json) => _$TodoPropertyFromJson(json);

  // DocumentSnapshotをTodoModelに変換
  factory TodoProperty.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    // copyWithにてdoc.idをidにコピー
    return TodoProperty.fromJson(data).copyWith(id: doc.id);
  }

  // TodoModelをMap<String, dynamic>に変換
  Map<String, dynamic> toDocument() => toJson()..remove('id');
}