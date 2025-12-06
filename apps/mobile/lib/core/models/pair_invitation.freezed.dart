// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pair_invitation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PairInvitation _$PairInvitationFromJson(Map<String, dynamic> json) {
  return _PairInvitation.fromJson(json);
}

/// @nodoc
mixin _$PairInvitation {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'from_user_id')
  String get fromUserId => throw _privateConstructorUsedError;
  @JsonKey(name: 'to_user_email')
  String get toUserEmail => throw _privateConstructorUsedError;
  @JsonKey(name: 'to_user_id')
  String? get toUserId => throw _privateConstructorUsedError;
  InvitationStatus get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt =>
      throw _privateConstructorUsedError; // Sender profile info (populated via join)
  @JsonKey(name: 'from_user_name')
  String? get fromUserName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PairInvitationCopyWith<PairInvitation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PairInvitationCopyWith<$Res> {
  factory $PairInvitationCopyWith(
          PairInvitation value, $Res Function(PairInvitation) then) =
      _$PairInvitationCopyWithImpl<$Res, PairInvitation>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'from_user_id') String fromUserId,
      @JsonKey(name: 'to_user_email') String toUserEmail,
      @JsonKey(name: 'to_user_id') String? toUserId,
      InvitationStatus status,
      String? message,
      @JsonKey(name: 'expires_at') DateTime? expiresAt,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'from_user_name') String? fromUserName});
}

/// @nodoc
class _$PairInvitationCopyWithImpl<$Res, $Val extends PairInvitation>
    implements $PairInvitationCopyWith<$Res> {
  _$PairInvitationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fromUserId = null,
    Object? toUserEmail = null,
    Object? toUserId = freezed,
    Object? status = null,
    Object? message = freezed,
    Object? expiresAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? fromUserName = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fromUserId: null == fromUserId
          ? _value.fromUserId
          : fromUserId // ignore: cast_nullable_to_non_nullable
              as String,
      toUserEmail: null == toUserEmail
          ? _value.toUserEmail
          : toUserEmail // ignore: cast_nullable_to_non_nullable
              as String,
      toUserId: freezed == toUserId
          ? _value.toUserId
          : toUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as InvitationStatus,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fromUserName: freezed == fromUserName
          ? _value.fromUserName
          : fromUserName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PairInvitationImplCopyWith<$Res>
    implements $PairInvitationCopyWith<$Res> {
  factory _$$PairInvitationImplCopyWith(_$PairInvitationImpl value,
          $Res Function(_$PairInvitationImpl) then) =
      __$$PairInvitationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'from_user_id') String fromUserId,
      @JsonKey(name: 'to_user_email') String toUserEmail,
      @JsonKey(name: 'to_user_id') String? toUserId,
      InvitationStatus status,
      String? message,
      @JsonKey(name: 'expires_at') DateTime? expiresAt,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'from_user_name') String? fromUserName});
}

/// @nodoc
class __$$PairInvitationImplCopyWithImpl<$Res>
    extends _$PairInvitationCopyWithImpl<$Res, _$PairInvitationImpl>
    implements _$$PairInvitationImplCopyWith<$Res> {
  __$$PairInvitationImplCopyWithImpl(
      _$PairInvitationImpl _value, $Res Function(_$PairInvitationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fromUserId = null,
    Object? toUserEmail = null,
    Object? toUserId = freezed,
    Object? status = null,
    Object? message = freezed,
    Object? expiresAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? fromUserName = freezed,
  }) {
    return _then(_$PairInvitationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fromUserId: null == fromUserId
          ? _value.fromUserId
          : fromUserId // ignore: cast_nullable_to_non_nullable
              as String,
      toUserEmail: null == toUserEmail
          ? _value.toUserEmail
          : toUserEmail // ignore: cast_nullable_to_non_nullable
              as String,
      toUserId: freezed == toUserId
          ? _value.toUserId
          : toUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as InvitationStatus,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fromUserName: freezed == fromUserName
          ? _value.fromUserName
          : fromUserName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PairInvitationImpl implements _PairInvitation {
  const _$PairInvitationImpl(
      {required this.id,
      @JsonKey(name: 'from_user_id') required this.fromUserId,
      @JsonKey(name: 'to_user_email') required this.toUserEmail,
      @JsonKey(name: 'to_user_id') this.toUserId,
      required this.status,
      this.message,
      @JsonKey(name: 'expires_at') this.expiresAt,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt,
      @JsonKey(name: 'from_user_name') this.fromUserName});

  factory _$PairInvitationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PairInvitationImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'from_user_id')
  final String fromUserId;
  @override
  @JsonKey(name: 'to_user_email')
  final String toUserEmail;
  @override
  @JsonKey(name: 'to_user_id')
  final String? toUserId;
  @override
  final InvitationStatus status;
  @override
  final String? message;
  @override
  @JsonKey(name: 'expires_at')
  final DateTime? expiresAt;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
// Sender profile info (populated via join)
  @override
  @JsonKey(name: 'from_user_name')
  final String? fromUserName;

  @override
  String toString() {
    return 'PairInvitation(id: $id, fromUserId: $fromUserId, toUserEmail: $toUserEmail, toUserId: $toUserId, status: $status, message: $message, expiresAt: $expiresAt, createdAt: $createdAt, updatedAt: $updatedAt, fromUserName: $fromUserName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PairInvitationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fromUserId, fromUserId) ||
                other.fromUserId == fromUserId) &&
            (identical(other.toUserEmail, toUserEmail) ||
                other.toUserEmail == toUserEmail) &&
            (identical(other.toUserId, toUserId) ||
                other.toUserId == toUserId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.fromUserName, fromUserName) ||
                other.fromUserName == fromUserName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, fromUserId, toUserEmail,
      toUserId, status, message, expiresAt, createdAt, updatedAt, fromUserName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PairInvitationImplCopyWith<_$PairInvitationImpl> get copyWith =>
      __$$PairInvitationImplCopyWithImpl<_$PairInvitationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PairInvitationImplToJson(
      this,
    );
  }
}

abstract class _PairInvitation implements PairInvitation {
  const factory _PairInvitation(
          {required final String id,
          @JsonKey(name: 'from_user_id') required final String fromUserId,
          @JsonKey(name: 'to_user_email') required final String toUserEmail,
          @JsonKey(name: 'to_user_id') final String? toUserId,
          required final InvitationStatus status,
          final String? message,
          @JsonKey(name: 'expires_at') final DateTime? expiresAt,
          @JsonKey(name: 'created_at') required final DateTime createdAt,
          @JsonKey(name: 'updated_at') required final DateTime updatedAt,
          @JsonKey(name: 'from_user_name') final String? fromUserName}) =
      _$PairInvitationImpl;

  factory _PairInvitation.fromJson(Map<String, dynamic> json) =
      _$PairInvitationImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'from_user_id')
  String get fromUserId;
  @override
  @JsonKey(name: 'to_user_email')
  String get toUserEmail;
  @override
  @JsonKey(name: 'to_user_id')
  String? get toUserId;
  @override
  InvitationStatus get status;
  @override
  String? get message;
  @override
  @JsonKey(name: 'expires_at')
  DateTime? get expiresAt;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @override // Sender profile info (populated via join)
  @JsonKey(name: 'from_user_name')
  String? get fromUserName;
  @override
  @JsonKey(ignore: true)
  _$$PairInvitationImplCopyWith<_$PairInvitationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
