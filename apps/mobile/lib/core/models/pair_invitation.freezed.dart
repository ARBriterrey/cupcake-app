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
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PairInvitation _$PairInvitationFromJson(Map<String, dynamic> json) {
  return _PairInvitation.fromJson(json);
}

/// @nodoc
mixin _$PairInvitation {
  String get id => throw _privateConstructorUsedError;
  String get fromUserId => throw _privateConstructorUsedError;
  String get toUserEmail => throw _privateConstructorUsedError;
  String? get toUserId => throw _privateConstructorUsedError;
  InvitationStatus get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this PairInvitation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PairInvitation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PairInvitationCopyWith<PairInvitation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PairInvitationCopyWith<$Res> {
  factory $PairInvitationCopyWith(
    PairInvitation value,
    $Res Function(PairInvitation) then,
  ) = _$PairInvitationCopyWithImpl<$Res, PairInvitation>;
  @useResult
  $Res call({
    String id,
    String fromUserId,
    String toUserEmail,
    String? toUserId,
    InvitationStatus status,
    String? message,
    DateTime? expiresAt,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$PairInvitationCopyWithImpl<$Res, $Val extends PairInvitation>
    implements $PairInvitationCopyWith<$Res> {
  _$PairInvitationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PairInvitation
  /// with the given fields replaced by the non-null parameter values.
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
  }) {
    return _then(
      _value.copyWith(
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PairInvitationImplCopyWith<$Res>
    implements $PairInvitationCopyWith<$Res> {
  factory _$$PairInvitationImplCopyWith(
    _$PairInvitationImpl value,
    $Res Function(_$PairInvitationImpl) then,
  ) = __$$PairInvitationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String fromUserId,
    String toUserEmail,
    String? toUserId,
    InvitationStatus status,
    String? message,
    DateTime? expiresAt,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$PairInvitationImplCopyWithImpl<$Res>
    extends _$PairInvitationCopyWithImpl<$Res, _$PairInvitationImpl>
    implements _$$PairInvitationImplCopyWith<$Res> {
  __$$PairInvitationImplCopyWithImpl(
    _$PairInvitationImpl _value,
    $Res Function(_$PairInvitationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PairInvitation
  /// with the given fields replaced by the non-null parameter values.
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
  }) {
    return _then(
      _$PairInvitationImpl(
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PairInvitationImpl implements _PairInvitation {
  const _$PairInvitationImpl({
    required this.id,
    required this.fromUserId,
    required this.toUserEmail,
    this.toUserId,
    required this.status,
    this.message,
    this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory _$PairInvitationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PairInvitationImplFromJson(json);

  @override
  final String id;
  @override
  final String fromUserId;
  @override
  final String toUserEmail;
  @override
  final String? toUserId;
  @override
  final InvitationStatus status;
  @override
  final String? message;
  @override
  final DateTime? expiresAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'PairInvitation(id: $id, fromUserId: $fromUserId, toUserEmail: $toUserEmail, toUserId: $toUserId, status: $status, message: $message, expiresAt: $expiresAt, createdAt: $createdAt, updatedAt: $updatedAt)';
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
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fromUserId,
    toUserEmail,
    toUserId,
    status,
    message,
    expiresAt,
    createdAt,
    updatedAt,
  );

  /// Create a copy of PairInvitation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PairInvitationImplCopyWith<_$PairInvitationImpl> get copyWith =>
      __$$PairInvitationImplCopyWithImpl<_$PairInvitationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PairInvitationImplToJson(this);
  }
}

abstract class _PairInvitation implements PairInvitation {
  const factory _PairInvitation({
    required final String id,
    required final String fromUserId,
    required final String toUserEmail,
    final String? toUserId,
    required final InvitationStatus status,
    final String? message,
    final DateTime? expiresAt,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$PairInvitationImpl;

  factory _PairInvitation.fromJson(Map<String, dynamic> json) =
      _$PairInvitationImpl.fromJson;

  @override
  String get id;
  @override
  String get fromUserId;
  @override
  String get toUserEmail;
  @override
  String? get toUserId;
  @override
  InvitationStatus get status;
  @override
  String? get message;
  @override
  DateTime? get expiresAt;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of PairInvitation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PairInvitationImplCopyWith<_$PairInvitationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
