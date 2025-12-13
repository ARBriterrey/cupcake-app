// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collaborative_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CollaborativeList _$CollaborativeListFromJson(Map<String, dynamic> json) {
  return _CollaborativeList.fromJson(json);
}

/// @nodoc
mixin _$CollaborativeList {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'pair_id')
  String get pairId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'list_type')
  ListType get listType => throw _privateConstructorUsedError;
  String? get description =>
      throw _privateConstructorUsedError; // Chit Jar specific
  @JsonKey(name: 'current_turn_user_id')
  String? get currentTurnUserId => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_pick_at')
  DateTime? get lastPickAt => throw _privateConstructorUsedError; // Metadata
  @JsonKey(name: 'created_by')
  String get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError; // Soft delete
  @JsonKey(name: 'is_deleted')
  bool get isDeleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'deleted_at')
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'deleted_by')
  String? get deletedBy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CollaborativeListCopyWith<CollaborativeList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollaborativeListCopyWith<$Res> {
  factory $CollaborativeListCopyWith(
          CollaborativeList value, $Res Function(CollaborativeList) then) =
      _$CollaborativeListCopyWithImpl<$Res, CollaborativeList>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'pair_id') String pairId,
      String title,
      @JsonKey(name: 'list_type') ListType listType,
      String? description,
      @JsonKey(name: 'current_turn_user_id') String? currentTurnUserId,
      @JsonKey(name: 'last_pick_at') DateTime? lastPickAt,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'is_deleted') bool isDeleted,
      @JsonKey(name: 'deleted_at') DateTime? deletedAt,
      @JsonKey(name: 'deleted_by') String? deletedBy});
}

/// @nodoc
class _$CollaborativeListCopyWithImpl<$Res, $Val extends CollaborativeList>
    implements $CollaborativeListCopyWith<$Res> {
  _$CollaborativeListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pairId = null,
    Object? title = null,
    Object? listType = null,
    Object? description = freezed,
    Object? currentTurnUserId = freezed,
    Object? lastPickAt = freezed,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isDeleted = null,
    Object? deletedAt = freezed,
    Object? deletedBy = freezed,
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
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      listType: null == listType
          ? _value.listType
          : listType // ignore: cast_nullable_to_non_nullable
              as ListType,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      currentTurnUserId: freezed == currentTurnUserId
          ? _value.currentTurnUserId
          : currentTurnUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastPickAt: freezed == lastPickAt
          ? _value.lastPickAt
          : lastPickAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedBy: freezed == deletedBy
          ? _value.deletedBy
          : deletedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CollaborativeListImplCopyWith<$Res>
    implements $CollaborativeListCopyWith<$Res> {
  factory _$$CollaborativeListImplCopyWith(_$CollaborativeListImpl value,
          $Res Function(_$CollaborativeListImpl) then) =
      __$$CollaborativeListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'pair_id') String pairId,
      String title,
      @JsonKey(name: 'list_type') ListType listType,
      String? description,
      @JsonKey(name: 'current_turn_user_id') String? currentTurnUserId,
      @JsonKey(name: 'last_pick_at') DateTime? lastPickAt,
      @JsonKey(name: 'created_by') String createdBy,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'is_deleted') bool isDeleted,
      @JsonKey(name: 'deleted_at') DateTime? deletedAt,
      @JsonKey(name: 'deleted_by') String? deletedBy});
}

/// @nodoc
class __$$CollaborativeListImplCopyWithImpl<$Res>
    extends _$CollaborativeListCopyWithImpl<$Res, _$CollaborativeListImpl>
    implements _$$CollaborativeListImplCopyWith<$Res> {
  __$$CollaborativeListImplCopyWithImpl(_$CollaborativeListImpl _value,
      $Res Function(_$CollaborativeListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pairId = null,
    Object? title = null,
    Object? listType = null,
    Object? description = freezed,
    Object? currentTurnUserId = freezed,
    Object? lastPickAt = freezed,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isDeleted = null,
    Object? deletedAt = freezed,
    Object? deletedBy = freezed,
  }) {
    return _then(_$CollaborativeListImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pairId: null == pairId
          ? _value.pairId
          : pairId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      listType: null == listType
          ? _value.listType
          : listType // ignore: cast_nullable_to_non_nullable
              as ListType,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      currentTurnUserId: freezed == currentTurnUserId
          ? _value.currentTurnUserId
          : currentTurnUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastPickAt: freezed == lastPickAt
          ? _value.lastPickAt
          : lastPickAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedBy: freezed == deletedBy
          ? _value.deletedBy
          : deletedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CollaborativeListImpl implements _CollaborativeList {
  const _$CollaborativeListImpl(
      {required this.id,
      @JsonKey(name: 'pair_id') required this.pairId,
      required this.title,
      @JsonKey(name: 'list_type') this.listType = ListType.standard,
      this.description,
      @JsonKey(name: 'current_turn_user_id') this.currentTurnUserId,
      @JsonKey(name: 'last_pick_at') this.lastPickAt,
      @JsonKey(name: 'created_by') required this.createdBy,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt,
      @JsonKey(name: 'is_deleted') this.isDeleted = false,
      @JsonKey(name: 'deleted_at') this.deletedAt,
      @JsonKey(name: 'deleted_by') this.deletedBy});

  factory _$CollaborativeListImpl.fromJson(Map<String, dynamic> json) =>
      _$$CollaborativeListImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'pair_id')
  final String pairId;
  @override
  final String title;
  @override
  @JsonKey(name: 'list_type')
  final ListType listType;
  @override
  final String? description;
// Chit Jar specific
  @override
  @JsonKey(name: 'current_turn_user_id')
  final String? currentTurnUserId;
  @override
  @JsonKey(name: 'last_pick_at')
  final DateTime? lastPickAt;
// Metadata
  @override
  @JsonKey(name: 'created_by')
  final String createdBy;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
// Soft delete
  @override
  @JsonKey(name: 'is_deleted')
  final bool isDeleted;
  @override
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;
  @override
  @JsonKey(name: 'deleted_by')
  final String? deletedBy;

  @override
  String toString() {
    return 'CollaborativeList(id: $id, pairId: $pairId, title: $title, listType: $listType, description: $description, currentTurnUserId: $currentTurnUserId, lastPickAt: $lastPickAt, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted, deletedAt: $deletedAt, deletedBy: $deletedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollaborativeListImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pairId, pairId) || other.pairId == pairId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.listType, listType) ||
                other.listType == listType) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.currentTurnUserId, currentTurnUserId) ||
                other.currentTurnUserId == currentTurnUserId) &&
            (identical(other.lastPickAt, lastPickAt) ||
                other.lastPickAt == lastPickAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.deletedBy, deletedBy) ||
                other.deletedBy == deletedBy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      pairId,
      title,
      listType,
      description,
      currentTurnUserId,
      lastPickAt,
      createdBy,
      createdAt,
      updatedAt,
      isDeleted,
      deletedAt,
      deletedBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CollaborativeListImplCopyWith<_$CollaborativeListImpl> get copyWith =>
      __$$CollaborativeListImplCopyWithImpl<_$CollaborativeListImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CollaborativeListImplToJson(
      this,
    );
  }
}

abstract class _CollaborativeList implements CollaborativeList {
  const factory _CollaborativeList(
      {required final String id,
      @JsonKey(name: 'pair_id') required final String pairId,
      required final String title,
      @JsonKey(name: 'list_type') final ListType listType,
      final String? description,
      @JsonKey(name: 'current_turn_user_id') final String? currentTurnUserId,
      @JsonKey(name: 'last_pick_at') final DateTime? lastPickAt,
      @JsonKey(name: 'created_by') required final String createdBy,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'updated_at') required final DateTime updatedAt,
      @JsonKey(name: 'is_deleted') final bool isDeleted,
      @JsonKey(name: 'deleted_at') final DateTime? deletedAt,
      @JsonKey(name: 'deleted_by')
      final String? deletedBy}) = _$CollaborativeListImpl;

  factory _CollaborativeList.fromJson(Map<String, dynamic> json) =
      _$CollaborativeListImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'pair_id')
  String get pairId;
  @override
  String get title;
  @override
  @JsonKey(name: 'list_type')
  ListType get listType;
  @override
  String? get description;
  @override // Chit Jar specific
  @JsonKey(name: 'current_turn_user_id')
  String? get currentTurnUserId;
  @override
  @JsonKey(name: 'last_pick_at')
  DateTime? get lastPickAt;
  @override // Metadata
  @JsonKey(name: 'created_by')
  String get createdBy;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @override // Soft delete
  @JsonKey(name: 'is_deleted')
  bool get isDeleted;
  @override
  @JsonKey(name: 'deleted_at')
  DateTime? get deletedAt;
  @override
  @JsonKey(name: 'deleted_by')
  String? get deletedBy;
  @override
  @JsonKey(ignore: true)
  _$$CollaborativeListImplCopyWith<_$CollaborativeListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
