// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SyncStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String? message) syncing,
    required TResult Function(DateTime lastSyncedAt, int? eventsSynced) synced,
    required TResult Function(
            String message, DateTime? lastSyncedAt, int? retryCount)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String? message)? syncing,
    TResult? Function(DateTime lastSyncedAt, int? eventsSynced)? synced,
    TResult? Function(String message, DateTime? lastSyncedAt, int? retryCount)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String? message)? syncing,
    TResult Function(DateTime lastSyncedAt, int? eventsSynced)? synced,
    TResult Function(String message, DateTime? lastSyncedAt, int? retryCount)?
        error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Syncing value) syncing,
    required TResult Function(_Synced value) synced,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Syncing value)? syncing,
    TResult? Function(_Synced value)? synced,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Syncing value)? syncing,
    TResult Function(_Synced value)? synced,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncStatusCopyWith<$Res> {
  factory $SyncStatusCopyWith(
          SyncStatus value, $Res Function(SyncStatus) then) =
      _$SyncStatusCopyWithImpl<$Res, SyncStatus>;
}

/// @nodoc
class _$SyncStatusCopyWithImpl<$Res, $Val extends SyncStatus>
    implements $SyncStatusCopyWith<$Res> {
  _$SyncStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$IdleImplCopyWith<$Res> {
  factory _$$IdleImplCopyWith(
          _$IdleImpl value, $Res Function(_$IdleImpl) then) =
      __$$IdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$IdleImplCopyWithImpl<$Res>
    extends _$SyncStatusCopyWithImpl<$Res, _$IdleImpl>
    implements _$$IdleImplCopyWith<$Res> {
  __$$IdleImplCopyWithImpl(_$IdleImpl _value, $Res Function(_$IdleImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$IdleImpl implements _Idle {
  const _$IdleImpl();

  @override
  String toString() {
    return 'SyncStatus.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$IdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String? message) syncing,
    required TResult Function(DateTime lastSyncedAt, int? eventsSynced) synced,
    required TResult Function(
            String message, DateTime? lastSyncedAt, int? retryCount)
        error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String? message)? syncing,
    TResult? Function(DateTime lastSyncedAt, int? eventsSynced)? synced,
    TResult? Function(String message, DateTime? lastSyncedAt, int? retryCount)?
        error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String? message)? syncing,
    TResult Function(DateTime lastSyncedAt, int? eventsSynced)? synced,
    TResult Function(String message, DateTime? lastSyncedAt, int? retryCount)?
        error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Syncing value) syncing,
    required TResult Function(_Synced value) synced,
    required TResult Function(_Error value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Syncing value)? syncing,
    TResult? Function(_Synced value)? synced,
    TResult? Function(_Error value)? error,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Syncing value)? syncing,
    TResult Function(_Synced value)? synced,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class _Idle implements SyncStatus {
  const factory _Idle() = _$IdleImpl;
}

/// @nodoc
abstract class _$$SyncingImplCopyWith<$Res> {
  factory _$$SyncingImplCopyWith(
          _$SyncingImpl value, $Res Function(_$SyncingImpl) then) =
      __$$SyncingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$SyncingImplCopyWithImpl<$Res>
    extends _$SyncStatusCopyWithImpl<$Res, _$SyncingImpl>
    implements _$$SyncingImplCopyWith<$Res> {
  __$$SyncingImplCopyWithImpl(
      _$SyncingImpl _value, $Res Function(_$SyncingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$SyncingImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SyncingImpl implements _Syncing {
  const _$SyncingImpl({this.message});

  @override
  final String? message;

  @override
  String toString() {
    return 'SyncStatus.syncing(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncingImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncingImplCopyWith<_$SyncingImpl> get copyWith =>
      __$$SyncingImplCopyWithImpl<_$SyncingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String? message) syncing,
    required TResult Function(DateTime lastSyncedAt, int? eventsSynced) synced,
    required TResult Function(
            String message, DateTime? lastSyncedAt, int? retryCount)
        error,
  }) {
    return syncing(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String? message)? syncing,
    TResult? Function(DateTime lastSyncedAt, int? eventsSynced)? synced,
    TResult? Function(String message, DateTime? lastSyncedAt, int? retryCount)?
        error,
  }) {
    return syncing?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String? message)? syncing,
    TResult Function(DateTime lastSyncedAt, int? eventsSynced)? synced,
    TResult Function(String message, DateTime? lastSyncedAt, int? retryCount)?
        error,
    required TResult orElse(),
  }) {
    if (syncing != null) {
      return syncing(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Syncing value) syncing,
    required TResult Function(_Synced value) synced,
    required TResult Function(_Error value) error,
  }) {
    return syncing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Syncing value)? syncing,
    TResult? Function(_Synced value)? synced,
    TResult? Function(_Error value)? error,
  }) {
    return syncing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Syncing value)? syncing,
    TResult Function(_Synced value)? synced,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (syncing != null) {
      return syncing(this);
    }
    return orElse();
  }
}

abstract class _Syncing implements SyncStatus {
  const factory _Syncing({final String? message}) = _$SyncingImpl;

  String? get message;
  @JsonKey(ignore: true)
  _$$SyncingImplCopyWith<_$SyncingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SyncedImplCopyWith<$Res> {
  factory _$$SyncedImplCopyWith(
          _$SyncedImpl value, $Res Function(_$SyncedImpl) then) =
      __$$SyncedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime lastSyncedAt, int? eventsSynced});
}

/// @nodoc
class __$$SyncedImplCopyWithImpl<$Res>
    extends _$SyncStatusCopyWithImpl<$Res, _$SyncedImpl>
    implements _$$SyncedImplCopyWith<$Res> {
  __$$SyncedImplCopyWithImpl(
      _$SyncedImpl _value, $Res Function(_$SyncedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastSyncedAt = null,
    Object? eventsSynced = freezed,
  }) {
    return _then(_$SyncedImpl(
      lastSyncedAt: null == lastSyncedAt
          ? _value.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      eventsSynced: freezed == eventsSynced
          ? _value.eventsSynced
          : eventsSynced // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$SyncedImpl implements _Synced {
  const _$SyncedImpl({required this.lastSyncedAt, this.eventsSynced});

  @override
  final DateTime lastSyncedAt;
  @override
  final int? eventsSynced;

  @override
  String toString() {
    return 'SyncStatus.synced(lastSyncedAt: $lastSyncedAt, eventsSynced: $eventsSynced)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncedImpl &&
            (identical(other.lastSyncedAt, lastSyncedAt) ||
                other.lastSyncedAt == lastSyncedAt) &&
            (identical(other.eventsSynced, eventsSynced) ||
                other.eventsSynced == eventsSynced));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lastSyncedAt, eventsSynced);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncedImplCopyWith<_$SyncedImpl> get copyWith =>
      __$$SyncedImplCopyWithImpl<_$SyncedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String? message) syncing,
    required TResult Function(DateTime lastSyncedAt, int? eventsSynced) synced,
    required TResult Function(
            String message, DateTime? lastSyncedAt, int? retryCount)
        error,
  }) {
    return synced(lastSyncedAt, eventsSynced);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String? message)? syncing,
    TResult? Function(DateTime lastSyncedAt, int? eventsSynced)? synced,
    TResult? Function(String message, DateTime? lastSyncedAt, int? retryCount)?
        error,
  }) {
    return synced?.call(lastSyncedAt, eventsSynced);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String? message)? syncing,
    TResult Function(DateTime lastSyncedAt, int? eventsSynced)? synced,
    TResult Function(String message, DateTime? lastSyncedAt, int? retryCount)?
        error,
    required TResult orElse(),
  }) {
    if (synced != null) {
      return synced(lastSyncedAt, eventsSynced);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Syncing value) syncing,
    required TResult Function(_Synced value) synced,
    required TResult Function(_Error value) error,
  }) {
    return synced(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Syncing value)? syncing,
    TResult? Function(_Synced value)? synced,
    TResult? Function(_Error value)? error,
  }) {
    return synced?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Syncing value)? syncing,
    TResult Function(_Synced value)? synced,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (synced != null) {
      return synced(this);
    }
    return orElse();
  }
}

abstract class _Synced implements SyncStatus {
  const factory _Synced(
      {required final DateTime lastSyncedAt,
      final int? eventsSynced}) = _$SyncedImpl;

  DateTime get lastSyncedAt;
  int? get eventsSynced;
  @JsonKey(ignore: true)
  _$$SyncedImplCopyWith<_$SyncedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, DateTime? lastSyncedAt, int? retryCount});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$SyncStatusCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? lastSyncedAt = freezed,
    Object? retryCount = freezed,
  }) {
    return _then(_$ErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      lastSyncedAt: freezed == lastSyncedAt
          ? _value.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      retryCount: freezed == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(
      {required this.message, this.lastSyncedAt, this.retryCount});

  @override
  final String message;
  @override
  final DateTime? lastSyncedAt;
  @override
  final int? retryCount;

  @override
  String toString() {
    return 'SyncStatus.error(message: $message, lastSyncedAt: $lastSyncedAt, retryCount: $retryCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.lastSyncedAt, lastSyncedAt) ||
                other.lastSyncedAt == lastSyncedAt) &&
            (identical(other.retryCount, retryCount) ||
                other.retryCount == retryCount));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, message, lastSyncedAt, retryCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(String? message) syncing,
    required TResult Function(DateTime lastSyncedAt, int? eventsSynced) synced,
    required TResult Function(
            String message, DateTime? lastSyncedAt, int? retryCount)
        error,
  }) {
    return error(message, lastSyncedAt, retryCount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String? message)? syncing,
    TResult? Function(DateTime lastSyncedAt, int? eventsSynced)? synced,
    TResult? Function(String message, DateTime? lastSyncedAt, int? retryCount)?
        error,
  }) {
    return error?.call(message, lastSyncedAt, retryCount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String? message)? syncing,
    TResult Function(DateTime lastSyncedAt, int? eventsSynced)? synced,
    TResult Function(String message, DateTime? lastSyncedAt, int? retryCount)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, lastSyncedAt, retryCount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_Syncing value) syncing,
    required TResult Function(_Synced value) synced,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_Syncing value)? syncing,
    TResult? Function(_Synced value)? synced,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_Syncing value)? syncing,
    TResult Function(_Synced value)? synced,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements SyncStatus {
  const factory _Error(
      {required final String message,
      final DateTime? lastSyncedAt,
      final int? retryCount}) = _$ErrorImpl;

  String get message;
  DateTime? get lastSyncedAt;
  int? get retryCount;
  @JsonKey(ignore: true)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
