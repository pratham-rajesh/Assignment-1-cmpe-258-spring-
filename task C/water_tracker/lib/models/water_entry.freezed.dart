// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'water_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WaterEntry _$WaterEntryFromJson(Map<String, dynamic> json) {
  return _WaterEntry.fromJson(json);
}

/// @nodoc
mixin _$WaterEntry {
  String get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  int get amountMl => throw _privateConstructorUsedError;

  /// Serializes this WaterEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WaterEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WaterEntryCopyWith<WaterEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WaterEntryCopyWith<$Res> {
  factory $WaterEntryCopyWith(
          WaterEntry value, $Res Function(WaterEntry) then) =
      _$WaterEntryCopyWithImpl<$Res, WaterEntry>;
  @useResult
  $Res call({String id, DateTime date, int amountMl});
}

/// @nodoc
class _$WaterEntryCopyWithImpl<$Res, $Val extends WaterEntry>
    implements $WaterEntryCopyWith<$Res> {
  _$WaterEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WaterEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? amountMl = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      amountMl: null == amountMl
          ? _value.amountMl
          : amountMl // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WaterEntryImplCopyWith<$Res>
    implements $WaterEntryCopyWith<$Res> {
  factory _$$WaterEntryImplCopyWith(
          _$WaterEntryImpl value, $Res Function(_$WaterEntryImpl) then) =
      __$$WaterEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, DateTime date, int amountMl});
}

/// @nodoc
class __$$WaterEntryImplCopyWithImpl<$Res>
    extends _$WaterEntryCopyWithImpl<$Res, _$WaterEntryImpl>
    implements _$$WaterEntryImplCopyWith<$Res> {
  __$$WaterEntryImplCopyWithImpl(
      _$WaterEntryImpl _value, $Res Function(_$WaterEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of WaterEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? amountMl = null,
  }) {
    return _then(_$WaterEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      amountMl: null == amountMl
          ? _value.amountMl
          : amountMl // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WaterEntryImpl implements _WaterEntry {
  const _$WaterEntryImpl(
      {required this.id, required this.date, required this.amountMl});

  factory _$WaterEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$WaterEntryImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime date;
  @override
  final int amountMl;

  @override
  String toString() {
    return 'WaterEntry(id: $id, date: $date, amountMl: $amountMl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WaterEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.amountMl, amountMl) ||
                other.amountMl == amountMl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, date, amountMl);

  /// Create a copy of WaterEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WaterEntryImplCopyWith<_$WaterEntryImpl> get copyWith =>
      __$$WaterEntryImplCopyWithImpl<_$WaterEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WaterEntryImplToJson(
      this,
    );
  }
}

abstract class _WaterEntry implements WaterEntry {
  const factory _WaterEntry(
      {required final String id,
      required final DateTime date,
      required final int amountMl}) = _$WaterEntryImpl;

  factory _WaterEntry.fromJson(Map<String, dynamic> json) =
      _$WaterEntryImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get date;
  @override
  int get amountMl;

  /// Create a copy of WaterEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WaterEntryImplCopyWith<_$WaterEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
