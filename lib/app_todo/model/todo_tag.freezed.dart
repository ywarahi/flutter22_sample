// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'todo_tag.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TodoTag _$TodoTagFromJson(Map<String, dynamic> json) {
  return _TodoTag.fromJson(json);
}

/// @nodoc
class _$TodoTagTearOff {
  const _$TodoTagTearOff();

  _TodoTag call({String? id, String? name}) {
    return _TodoTag(
      id: id,
      name: name,
    );
  }

  TodoTag fromJson(Map<String, Object> json) {
    return TodoTag.fromJson(json);
  }
}

/// @nodoc
const $TodoTag = _$TodoTagTearOff();

/// @nodoc
mixin _$TodoTag {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoTagCopyWith<TodoTag> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoTagCopyWith<$Res> {
  factory $TodoTagCopyWith(TodoTag value, $Res Function(TodoTag) then) =
      _$TodoTagCopyWithImpl<$Res>;
  $Res call({String? id, String? name});
}

/// @nodoc
class _$TodoTagCopyWithImpl<$Res> implements $TodoTagCopyWith<$Res> {
  _$TodoTagCopyWithImpl(this._value, this._then);

  final TodoTag _value;
  // ignore: unused_field
  final $Res Function(TodoTag) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
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
    ));
  }
}

/// @nodoc
abstract class _$TodoTagCopyWith<$Res> implements $TodoTagCopyWith<$Res> {
  factory _$TodoTagCopyWith(_TodoTag value, $Res Function(_TodoTag) then) =
      __$TodoTagCopyWithImpl<$Res>;
  @override
  $Res call({String? id, String? name});
}

/// @nodoc
class __$TodoTagCopyWithImpl<$Res> extends _$TodoTagCopyWithImpl<$Res>
    implements _$TodoTagCopyWith<$Res> {
  __$TodoTagCopyWithImpl(_TodoTag _value, $Res Function(_TodoTag) _then)
      : super(_value, (v) => _then(v as _TodoTag));

  @override
  _TodoTag get _value => super._value as _TodoTag;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_TodoTag(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TodoTag extends _TodoTag with DiagnosticableTreeMixin {
  const _$_TodoTag({this.id, this.name}) : super._();

  factory _$_TodoTag.fromJson(Map<String, dynamic> json) =>
      _$_$_TodoTagFromJson(json);

  @override
  final String? id;
  @override
  final String? name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TodoTag(id: $id, name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TodoTag'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TodoTag &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name);

  @JsonKey(ignore: true)
  @override
  _$TodoTagCopyWith<_TodoTag> get copyWith =>
      __$TodoTagCopyWithImpl<_TodoTag>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_TodoTagToJson(this);
  }
}

abstract class _TodoTag extends TodoTag {
  const factory _TodoTag({String? id, String? name}) = _$_TodoTag;
  const _TodoTag._() : super._();

  factory _TodoTag.fromJson(Map<String, dynamic> json) = _$_TodoTag.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  String? get name => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TodoTagCopyWith<_TodoTag> get copyWith =>
      throw _privateConstructorUsedError;
}
