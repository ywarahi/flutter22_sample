// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'todo_property.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TodoProperty _$TodoPropertyFromJson(Map<String, dynamic> json) {
  return _TodoProperty.fromJson(json);
}

/// @nodoc
class _$TodoPropertyTearOff {
  const _$TodoPropertyTearOff();

  _TodoProperty call(
      {String? id,
      String? name,
      @MapStrConverter() Map<String, String>? mapStr}) {
    return _TodoProperty(
      id: id,
      name: name,
      mapStr: mapStr,
    );
  }

  TodoProperty fromJson(Map<String, Object> json) {
    return TodoProperty.fromJson(json);
  }
}

/// @nodoc
const $TodoProperty = _$TodoPropertyTearOff();

/// @nodoc
mixin _$TodoProperty {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @MapStrConverter()
  Map<String, String>? get mapStr => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoPropertyCopyWith<TodoProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoPropertyCopyWith<$Res> {
  factory $TodoPropertyCopyWith(
          TodoProperty value, $Res Function(TodoProperty) then) =
      _$TodoPropertyCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? name,
      @MapStrConverter() Map<String, String>? mapStr});
}

/// @nodoc
class _$TodoPropertyCopyWithImpl<$Res> implements $TodoPropertyCopyWith<$Res> {
  _$TodoPropertyCopyWithImpl(this._value, this._then);

  final TodoProperty _value;
  // ignore: unused_field
  final $Res Function(TodoProperty) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? mapStr = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      mapStr: mapStr == freezed
          ? _value.mapStr
          : mapStr // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc
abstract class _$TodoPropertyCopyWith<$Res>
    implements $TodoPropertyCopyWith<$Res> {
  factory _$TodoPropertyCopyWith(
          _TodoProperty value, $Res Function(_TodoProperty) then) =
      __$TodoPropertyCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? name,
      @MapStrConverter() Map<String, String>? mapStr});
}

/// @nodoc
class __$TodoPropertyCopyWithImpl<$Res> extends _$TodoPropertyCopyWithImpl<$Res>
    implements _$TodoPropertyCopyWith<$Res> {
  __$TodoPropertyCopyWithImpl(
      _TodoProperty _value, $Res Function(_TodoProperty) _then)
      : super(_value, (v) => _then(v as _TodoProperty));

  @override
  _TodoProperty get _value => super._value as _TodoProperty;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? mapStr = freezed,
  }) {
    return _then(_TodoProperty(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      mapStr: mapStr == freezed
          ? _value.mapStr
          : mapStr // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TodoProperty extends _TodoProperty with DiagnosticableTreeMixin {
  const _$_TodoProperty({this.id, this.name, @MapStrConverter() this.mapStr})
      : super._();

  factory _$_TodoProperty.fromJson(Map<String, dynamic> json) =>
      _$_$_TodoPropertyFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  @MapStrConverter()
  final Map<String, String>? mapStr;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TodoProperty(id: $id, name: $name, mapStr: $mapStr)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TodoProperty'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('mapStr', mapStr));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TodoProperty &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.mapStr, mapStr) ||
                const DeepCollectionEquality().equals(other.mapStr, mapStr)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(mapStr);

  @JsonKey(ignore: true)
  @override
  _$TodoPropertyCopyWith<_TodoProperty> get copyWith =>
      __$TodoPropertyCopyWithImpl<_TodoProperty>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_TodoPropertyToJson(this);
  }
}

abstract class _TodoProperty extends TodoProperty {
  const factory _TodoProperty(
      {String? id,
      String? name,
      @MapStrConverter() Map<String, String>? mapStr}) = _$_TodoProperty;
  const _TodoProperty._() : super._();

  factory _TodoProperty.fromJson(Map<String, dynamic> json) =
      _$_TodoProperty.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  String? get name => throw _privateConstructorUsedError;
  @override
  @MapStrConverter()
  Map<String, String>? get mapStr => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TodoPropertyCopyWith<_TodoProperty> get copyWith =>
      throw _privateConstructorUsedError;
}
