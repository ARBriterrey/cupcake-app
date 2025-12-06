// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pair_entitlement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PairEntitlement _$PairEntitlementFromJson(Map<String, dynamic> json) {
  return _PairEntitlement.fromJson(json);
}

/// @nodoc
mixin _$PairEntitlement {
  String get id => throw _privateConstructorUsedError;
  String get pairId => throw _privateConstructorUsedError;
  String get sprinkleId => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PairEntitlementCopyWith<PairEntitlement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PairEntitlementCopyWith<$Res> {
  factory $PairEntitlementCopyWith(
          PairEntitlement value, $Res Function(PairEntitlement) then) =
      _$PairEntitlementCopyWithImpl<$Res, PairEntitlement>;
  @useResult
  $Res call(
      {String id,
      String pairId,
      String sprinkleId,
      bool isActive,
      DateTime? expiresAt,
      Map<String, dynamic> metadata,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$PairEntitlementCopyWithImpl<$Res, $Val extends PairEntitlement>
    implements $PairEntitlementCopyWith<$Res> {
  _$PairEntitlementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pairId = null,
    Object? sprinkleId = null,
    Object? isActive = null,
    Object? expiresAt = freezed,
    Object? metadata = null,
    Object? createdAt = null,
    Object? updatedAt = null,
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
      sprinkleId: null == sprinkleId
          ? _value.sprinkleId
          : sprinkleId // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PairEntitlementImplCopyWith<$Res>
    implements $PairEntitlementCopyWith<$Res> {
  factory _$$PairEntitlementImplCopyWith(_$PairEntitlementImpl value,
          $Res Function(_$PairEntitlementImpl) then) =
      __$$PairEntitlementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String pairId,
      String sprinkleId,
      bool isActive,
      DateTime? expiresAt,
      Map<String, dynamic> metadata,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$PairEntitlementImplCopyWithImpl<$Res>
    extends _$PairEntitlementCopyWithImpl<$Res, _$PairEntitlementImpl>
    implements _$$PairEntitlementImplCopyWith<$Res> {
  __$$PairEntitlementImplCopyWithImpl(
      _$PairEntitlementImpl _value, $Res Function(_$PairEntitlementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pairId = null,
    Object? sprinkleId = null,
    Object? isActive = null,
    Object? expiresAt = freezed,
    Object? metadata = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$PairEntitlementImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pairId: null == pairId
          ? _value.pairId
          : pairId // ignore: cast_nullable_to_non_nullable
              as String,
      sprinkleId: null == sprinkleId
          ? _value.sprinkleId
          : sprinkleId // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PairEntitlementImpl implements _PairEntitlement {
  const _$PairEntitlementImpl(
      {required this.id,
      required this.pairId,
      required this.sprinkleId,
      required this.isActive,
      this.expiresAt,
      final Map<String, dynamic> metadata = const {},
      required this.createdAt,
      required this.updatedAt})
      : _metadata = metadata;

  factory _$PairEntitlementImpl.fromJson(Map<String, dynamic> json) =>
      _$$PairEntitlementImplFromJson(json);

  @override
  final String id;
  @override
  final String pairId;
  @override
  final String sprinkleId;
  @override
  final bool isActive;
  @override
  final DateTime? expiresAt;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'PairEntitlement(id: $id, pairId: $pairId, sprinkleId: $sprinkleId, isActive: $isActive, expiresAt: $expiresAt, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PairEntitlementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pairId, pairId) || other.pairId == pairId) &&
            (identical(other.sprinkleId, sprinkleId) ||
                other.sprinkleId == sprinkleId) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      pairId,
      sprinkleId,
      isActive,
      expiresAt,
      const DeepCollectionEquality().hash(_metadata),
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PairEntitlementImplCopyWith<_$PairEntitlementImpl> get copyWith =>
      __$$PairEntitlementImplCopyWithImpl<_$PairEntitlementImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PairEntitlementImplToJson(
      this,
    );
  }
}

abstract class _PairEntitlement implements PairEntitlement {
  const factory _PairEntitlement(
      {required final String id,
      required final String pairId,
      required final String sprinkleId,
      required final bool isActive,
      final DateTime? expiresAt,
      final Map<String, dynamic> metadata,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$PairEntitlementImpl;

  factory _PairEntitlement.fromJson(Map<String, dynamic> json) =
      _$PairEntitlementImpl.fromJson;

  @override
  String get id;
  @override
  String get pairId;
  @override
  String get sprinkleId;
  @override
  bool get isActive;
  @override
  DateTime? get expiresAt;
  @override
  Map<String, dynamic> get metadata;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$PairEntitlementImplCopyWith<_$PairEntitlementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
