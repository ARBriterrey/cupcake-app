// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pair.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Pair _$PairFromJson(Map<String, dynamic> json) {
  return _Pair.fromJson(json);
}

/// @nodoc
mixin _$Pair {
  String get id => throw _privateConstructorUsedError;
  String get user1Id => throw _privateConstructorUsedError;
  String get user2Id => throw _privateConstructorUsedError;
  String? get coupleName => throw _privateConstructorUsedError;
  DateTime? get anniversaryDate => throw _privateConstructorUsedError;
  Map<String, dynamic> get sharedPreferences =>
      throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Pair to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Pair
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PairCopyWith<Pair> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PairCopyWith<$Res> {
  factory $PairCopyWith(Pair value, $Res Function(Pair) then) =
      _$PairCopyWithImpl<$Res, Pair>;
  @useResult
  $Res call({
    String id,
    String user1Id,
    String user2Id,
    String? coupleName,
    DateTime? anniversaryDate,
    Map<String, dynamic> sharedPreferences,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$PairCopyWithImpl<$Res, $Val extends Pair>
    implements $PairCopyWith<$Res> {
  _$PairCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Pair
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user1Id = null,
    Object? user2Id = null,
    Object? coupleName = freezed,
    Object? anniversaryDate = freezed,
    Object? sharedPreferences = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            user1Id: null == user1Id
                ? _value.user1Id
                : user1Id // ignore: cast_nullable_to_non_nullable
                      as String,
            user2Id: null == user2Id
                ? _value.user2Id
                : user2Id // ignore: cast_nullable_to_non_nullable
                      as String,
            coupleName: freezed == coupleName
                ? _value.coupleName
                : coupleName // ignore: cast_nullable_to_non_nullable
                      as String?,
            anniversaryDate: freezed == anniversaryDate
                ? _value.anniversaryDate
                : anniversaryDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            sharedPreferences: null == sharedPreferences
                ? _value.sharedPreferences
                : sharedPreferences // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
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
abstract class _$$PairImplCopyWith<$Res> implements $PairCopyWith<$Res> {
  factory _$$PairImplCopyWith(
    _$PairImpl value,
    $Res Function(_$PairImpl) then,
  ) = __$$PairImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String user1Id,
    String user2Id,
    String? coupleName,
    DateTime? anniversaryDate,
    Map<String, dynamic> sharedPreferences,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$PairImplCopyWithImpl<$Res>
    extends _$PairCopyWithImpl<$Res, _$PairImpl>
    implements _$$PairImplCopyWith<$Res> {
  __$$PairImplCopyWithImpl(_$PairImpl _value, $Res Function(_$PairImpl) _then)
    : super(_value, _then);

  /// Create a copy of Pair
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user1Id = null,
    Object? user2Id = null,
    Object? coupleName = freezed,
    Object? anniversaryDate = freezed,
    Object? sharedPreferences = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$PairImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        user1Id: null == user1Id
            ? _value.user1Id
            : user1Id // ignore: cast_nullable_to_non_nullable
                  as String,
        user2Id: null == user2Id
            ? _value.user2Id
            : user2Id // ignore: cast_nullable_to_non_nullable
                  as String,
        coupleName: freezed == coupleName
            ? _value.coupleName
            : coupleName // ignore: cast_nullable_to_non_nullable
                  as String?,
        anniversaryDate: freezed == anniversaryDate
            ? _value.anniversaryDate
            : anniversaryDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        sharedPreferences: null == sharedPreferences
            ? _value._sharedPreferences
            : sharedPreferences // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
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
class _$PairImpl implements _Pair {
  const _$PairImpl({
    required this.id,
    required this.user1Id,
    required this.user2Id,
    this.coupleName,
    this.anniversaryDate,
    final Map<String, dynamic> sharedPreferences = const {},
    required this.createdAt,
    required this.updatedAt,
  }) : _sharedPreferences = sharedPreferences;

  factory _$PairImpl.fromJson(Map<String, dynamic> json) =>
      _$$PairImplFromJson(json);

  @override
  final String id;
  @override
  final String user1Id;
  @override
  final String user2Id;
  @override
  final String? coupleName;
  @override
  final DateTime? anniversaryDate;
  final Map<String, dynamic> _sharedPreferences;
  @override
  @JsonKey()
  Map<String, dynamic> get sharedPreferences {
    if (_sharedPreferences is EqualUnmodifiableMapView)
      return _sharedPreferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_sharedPreferences);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Pair(id: $id, user1Id: $user1Id, user2Id: $user2Id, coupleName: $coupleName, anniversaryDate: $anniversaryDate, sharedPreferences: $sharedPreferences, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PairImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user1Id, user1Id) || other.user1Id == user1Id) &&
            (identical(other.user2Id, user2Id) || other.user2Id == user2Id) &&
            (identical(other.coupleName, coupleName) ||
                other.coupleName == coupleName) &&
            (identical(other.anniversaryDate, anniversaryDate) ||
                other.anniversaryDate == anniversaryDate) &&
            const DeepCollectionEquality().equals(
              other._sharedPreferences,
              _sharedPreferences,
            ) &&
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
    user1Id,
    user2Id,
    coupleName,
    anniversaryDate,
    const DeepCollectionEquality().hash(_sharedPreferences),
    createdAt,
    updatedAt,
  );

  /// Create a copy of Pair
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PairImplCopyWith<_$PairImpl> get copyWith =>
      __$$PairImplCopyWithImpl<_$PairImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PairImplToJson(this);
  }
}

abstract class _Pair implements Pair {
  const factory _Pair({
    required final String id,
    required final String user1Id,
    required final String user2Id,
    final String? coupleName,
    final DateTime? anniversaryDate,
    final Map<String, dynamic> sharedPreferences,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$PairImpl;

  factory _Pair.fromJson(Map<String, dynamic> json) = _$PairImpl.fromJson;

  @override
  String get id;
  @override
  String get user1Id;
  @override
  String get user2Id;
  @override
  String? get coupleName;
  @override
  DateTime? get anniversaryDate;
  @override
  Map<String, dynamic> get sharedPreferences;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Pair
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PairImplCopyWith<_$PairImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
