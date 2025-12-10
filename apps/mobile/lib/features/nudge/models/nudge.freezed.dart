// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nudge.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Nudge _$NudgeFromJson(Map<String, dynamic> json) {
  return _Nudge.fromJson(json);
}

/// @nodoc
mixin _$Nudge {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'pair_id')
  String get pairId => throw _privateConstructorUsedError;
  @JsonKey(name: 'sender_id')
  String get senderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'receiver_id')
  String get receiverId => throw _privateConstructorUsedError;
  String get nudgeType => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'viewed_at')
  DateTime? get viewedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  DateTime get expiresAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NudgeCopyWith<Nudge> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NudgeCopyWith<$Res> {
  factory $NudgeCopyWith(Nudge value, $Res Function(Nudge) then) =
      _$NudgeCopyWithImpl<$Res, Nudge>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'pair_id') String pairId,
      @JsonKey(name: 'sender_id') String senderId,
      @JsonKey(name: 'receiver_id') String receiverId,
      String nudgeType,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'viewed_at') DateTime? viewedAt,
      @JsonKey(name: 'expires_at') DateTime expiresAt});
}

/// @nodoc
class _$NudgeCopyWithImpl<$Res, $Val extends Nudge>
    implements $NudgeCopyWith<$Res> {
  _$NudgeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pairId = null,
    Object? senderId = null,
    Object? receiverId = null,
    Object? nudgeType = null,
    Object? createdAt = null,
    Object? viewedAt = freezed,
    Object? expiresAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pairId: null == pairId
          ? _value.pairId
          : pairId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      receiverId: null == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String,
      nudgeType: null == nudgeType
          ? _value.nudgeType
          : nudgeType // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      viewedAt: freezed == viewedAt
          ? _value.viewedAt
          : viewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NudgeImplCopyWith<$Res> implements $NudgeCopyWith<$Res> {
  factory _$$NudgeImplCopyWith(
          _$NudgeImpl value, $Res Function(_$NudgeImpl) then) =
      __$$NudgeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'pair_id') String pairId,
      @JsonKey(name: 'sender_id') String senderId,
      @JsonKey(name: 'receiver_id') String receiverId,
      String nudgeType,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'viewed_at') DateTime? viewedAt,
      @JsonKey(name: 'expires_at') DateTime expiresAt});
}

/// @nodoc
class __$$NudgeImplCopyWithImpl<$Res>
    extends _$NudgeCopyWithImpl<$Res, _$NudgeImpl>
    implements _$$NudgeImplCopyWith<$Res> {
  __$$NudgeImplCopyWithImpl(
      _$NudgeImpl _value, $Res Function(_$NudgeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pairId = null,
    Object? senderId = null,
    Object? receiverId = null,
    Object? nudgeType = null,
    Object? createdAt = null,
    Object? viewedAt = freezed,
    Object? expiresAt = null,
  }) {
    return _then(_$NudgeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pairId: null == pairId
          ? _value.pairId
          : pairId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      receiverId: null == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String,
      nudgeType: null == nudgeType
          ? _value.nudgeType
          : nudgeType // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      viewedAt: freezed == viewedAt
          ? _value.viewedAt
          : viewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NudgeImpl implements _Nudge {
  const _$NudgeImpl(
      {required this.id,
      @JsonKey(name: 'pair_id') required this.pairId,
      @JsonKey(name: 'sender_id') required this.senderId,
      @JsonKey(name: 'receiver_id') required this.receiverId,
      this.nudgeType = 'thinking_of_you',
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'viewed_at') this.viewedAt,
      @JsonKey(name: 'expires_at') required this.expiresAt});

  factory _$NudgeImpl.fromJson(Map<String, dynamic> json) =>
      _$$NudgeImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'pair_id')
  final String pairId;
  @override
  @JsonKey(name: 'sender_id')
  final String senderId;
  @override
  @JsonKey(name: 'receiver_id')
  final String receiverId;
  @override
  @JsonKey()
  final String nudgeType;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'viewed_at')
  final DateTime? viewedAt;
  @override
  @JsonKey(name: 'expires_at')
  final DateTime expiresAt;

  @override
  String toString() {
    return 'Nudge(id: $id, pairId: $pairId, senderId: $senderId, receiverId: $receiverId, nudgeType: $nudgeType, createdAt: $createdAt, viewedAt: $viewedAt, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NudgeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pairId, pairId) || other.pairId == pairId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.nudgeType, nudgeType) ||
                other.nudgeType == nudgeType) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.viewedAt, viewedAt) ||
                other.viewedAt == viewedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, pairId, senderId, receiverId,
      nudgeType, createdAt, viewedAt, expiresAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NudgeImplCopyWith<_$NudgeImpl> get copyWith =>
      __$$NudgeImplCopyWithImpl<_$NudgeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NudgeImplToJson(
      this,
    );
  }
}

abstract class _Nudge implements Nudge {
  const factory _Nudge(
          {required final String id,
          @JsonKey(name: 'pair_id') required final String pairId,
          @JsonKey(name: 'sender_id') required final String senderId,
          @JsonKey(name: 'receiver_id') required final String receiverId,
          final String nudgeType,
          @JsonKey(name: 'created_at') required final DateTime createdAt,
          @JsonKey(name: 'viewed_at') final DateTime? viewedAt,
          @JsonKey(name: 'expires_at') required final DateTime expiresAt}) =
      _$NudgeImpl;

  factory _Nudge.fromJson(Map<String, dynamic> json) = _$NudgeImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'pair_id')
  String get pairId;
  @override
  @JsonKey(name: 'sender_id')
  String get senderId;
  @override
  @JsonKey(name: 'receiver_id')
  String get receiverId;
  @override
  String get nudgeType;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'viewed_at')
  DateTime? get viewedAt;
  @override
  @JsonKey(name: 'expires_at')
  DateTime get expiresAt;
  @override
  @JsonKey(ignore: true)
  _$$NudgeImplCopyWith<_$NudgeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
