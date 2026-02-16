// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) {
  return _AppSettings.fromJson(json);
}

/// @nodoc
mixin _$AppSettings {
  int get dailyGoalMl => throw _privateConstructorUsedError;
  Unit get unit => throw _privateConstructorUsedError;
  bool get remindersEnabled => throw _privateConstructorUsedError;
  int get reminderStartHour => throw _privateConstructorUsedError;
  int get reminderEndHour => throw _privateConstructorUsedError;
  int get reminderIntervalHours => throw _privateConstructorUsedError;

  /// Serializes this AppSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppSettingsCopyWith<AppSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppSettingsCopyWith<$Res> {
  factory $AppSettingsCopyWith(
          AppSettings value, $Res Function(AppSettings) then) =
      _$AppSettingsCopyWithImpl<$Res, AppSettings>;
  @useResult
  $Res call(
      {int dailyGoalMl,
      Unit unit,
      bool remindersEnabled,
      int reminderStartHour,
      int reminderEndHour,
      int reminderIntervalHours});
}

/// @nodoc
class _$AppSettingsCopyWithImpl<$Res, $Val extends AppSettings>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyGoalMl = null,
    Object? unit = null,
    Object? remindersEnabled = null,
    Object? reminderStartHour = null,
    Object? reminderEndHour = null,
    Object? reminderIntervalHours = null,
  }) {
    return _then(_value.copyWith(
      dailyGoalMl: null == dailyGoalMl
          ? _value.dailyGoalMl
          : dailyGoalMl // ignore: cast_nullable_to_non_nullable
              as int,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as Unit,
      remindersEnabled: null == remindersEnabled
          ? _value.remindersEnabled
          : remindersEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      reminderStartHour: null == reminderStartHour
          ? _value.reminderStartHour
          : reminderStartHour // ignore: cast_nullable_to_non_nullable
              as int,
      reminderEndHour: null == reminderEndHour
          ? _value.reminderEndHour
          : reminderEndHour // ignore: cast_nullable_to_non_nullable
              as int,
      reminderIntervalHours: null == reminderIntervalHours
          ? _value.reminderIntervalHours
          : reminderIntervalHours // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppSettingsImplCopyWith<$Res>
    implements $AppSettingsCopyWith<$Res> {
  factory _$$AppSettingsImplCopyWith(
          _$AppSettingsImpl value, $Res Function(_$AppSettingsImpl) then) =
      __$$AppSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int dailyGoalMl,
      Unit unit,
      bool remindersEnabled,
      int reminderStartHour,
      int reminderEndHour,
      int reminderIntervalHours});
}

/// @nodoc
class __$$AppSettingsImplCopyWithImpl<$Res>
    extends _$AppSettingsCopyWithImpl<$Res, _$AppSettingsImpl>
    implements _$$AppSettingsImplCopyWith<$Res> {
  __$$AppSettingsImplCopyWithImpl(
      _$AppSettingsImpl _value, $Res Function(_$AppSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyGoalMl = null,
    Object? unit = null,
    Object? remindersEnabled = null,
    Object? reminderStartHour = null,
    Object? reminderEndHour = null,
    Object? reminderIntervalHours = null,
  }) {
    return _then(_$AppSettingsImpl(
      dailyGoalMl: null == dailyGoalMl
          ? _value.dailyGoalMl
          : dailyGoalMl // ignore: cast_nullable_to_non_nullable
              as int,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as Unit,
      remindersEnabled: null == remindersEnabled
          ? _value.remindersEnabled
          : remindersEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      reminderStartHour: null == reminderStartHour
          ? _value.reminderStartHour
          : reminderStartHour // ignore: cast_nullable_to_non_nullable
              as int,
      reminderEndHour: null == reminderEndHour
          ? _value.reminderEndHour
          : reminderEndHour // ignore: cast_nullable_to_non_nullable
              as int,
      reminderIntervalHours: null == reminderIntervalHours
          ? _value.reminderIntervalHours
          : reminderIntervalHours // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppSettingsImpl implements _AppSettings {
  const _$AppSettingsImpl(
      {this.dailyGoalMl = 2000,
      this.unit = Unit.ml,
      this.remindersEnabled = false,
      this.reminderStartHour = 8,
      this.reminderEndHour = 22,
      this.reminderIntervalHours = 2});

  factory _$AppSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppSettingsImplFromJson(json);

  @override
  @JsonKey()
  final int dailyGoalMl;
  @override
  @JsonKey()
  final Unit unit;
  @override
  @JsonKey()
  final bool remindersEnabled;
  @override
  @JsonKey()
  final int reminderStartHour;
  @override
  @JsonKey()
  final int reminderEndHour;
  @override
  @JsonKey()
  final int reminderIntervalHours;

  @override
  String toString() {
    return 'AppSettings(dailyGoalMl: $dailyGoalMl, unit: $unit, remindersEnabled: $remindersEnabled, reminderStartHour: $reminderStartHour, reminderEndHour: $reminderEndHour, reminderIntervalHours: $reminderIntervalHours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSettingsImpl &&
            (identical(other.dailyGoalMl, dailyGoalMl) ||
                other.dailyGoalMl == dailyGoalMl) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.remindersEnabled, remindersEnabled) ||
                other.remindersEnabled == remindersEnabled) &&
            (identical(other.reminderStartHour, reminderStartHour) ||
                other.reminderStartHour == reminderStartHour) &&
            (identical(other.reminderEndHour, reminderEndHour) ||
                other.reminderEndHour == reminderEndHour) &&
            (identical(other.reminderIntervalHours, reminderIntervalHours) ||
                other.reminderIntervalHours == reminderIntervalHours));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      dailyGoalMl,
      unit,
      remindersEnabled,
      reminderStartHour,
      reminderEndHour,
      reminderIntervalHours);

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      __$$AppSettingsImplCopyWithImpl<_$AppSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppSettingsImplToJson(
      this,
    );
  }
}

abstract class _AppSettings implements AppSettings {
  const factory _AppSettings(
      {final int dailyGoalMl,
      final Unit unit,
      final bool remindersEnabled,
      final int reminderStartHour,
      final int reminderEndHour,
      final int reminderIntervalHours}) = _$AppSettingsImpl;

  factory _AppSettings.fromJson(Map<String, dynamic> json) =
      _$AppSettingsImpl.fromJson;

  @override
  int get dailyGoalMl;
  @override
  Unit get unit;
  @override
  bool get remindersEnabled;
  @override
  int get reminderStartHour;
  @override
  int get reminderEndHour;
  @override
  int get reminderIntervalHours;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
