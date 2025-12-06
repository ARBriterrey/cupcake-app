// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CalendarEvent _$CalendarEventFromJson(Map<String, dynamic> json) {
  return _CalendarEvent.fromJson(json);
}

/// @nodoc
mixin _$CalendarEvent {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'pair_id')
  String get pairId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String? get createdBy => throw _privateConstructorUsedError; // Event details
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_type')
  EventType get eventType => throw _privateConstructorUsedError; // Timing
  @JsonKey(name: 'start_time')
  DateTime get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_time')
  DateTime? get endTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_all_day')
  bool get isAllDay => throw _privateConstructorUsedError; // Location
  String? get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'location_coordinates')
  String? get locationCoordinates =>
      throw _privateConstructorUsedError; // Visibility and privacy
  EventVisibility get visibility => throw _privateConstructorUsedError;
  @JsonKey(name: 'visible_to_user_id')
  String? get visibleToUserId => throw _privateConstructorUsedError; // Metadata
  String? get color => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata =>
      throw _privateConstructorUsedError; // Timestamps
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CalendarEventCopyWith<CalendarEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarEventCopyWith<$Res> {
  factory $CalendarEventCopyWith(
          CalendarEvent value, $Res Function(CalendarEvent) then) =
      _$CalendarEventCopyWithImpl<$Res, CalendarEvent>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'pair_id') String pairId,
      @JsonKey(name: 'created_by') String? createdBy,
      String title,
      String? description,
      @JsonKey(name: 'event_type') EventType eventType,
      @JsonKey(name: 'start_time') DateTime startTime,
      @JsonKey(name: 'end_time') DateTime? endTime,
      @JsonKey(name: 'is_all_day') bool isAllDay,
      String? location,
      @JsonKey(name: 'location_coordinates') String? locationCoordinates,
      EventVisibility visibility,
      @JsonKey(name: 'visible_to_user_id') String? visibleToUserId,
      String? color,
      List<String> tags,
      Map<String, dynamic> metadata,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt});
}

/// @nodoc
class _$CalendarEventCopyWithImpl<$Res, $Val extends CalendarEvent>
    implements $CalendarEventCopyWith<$Res> {
  _$CalendarEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pairId = null,
    Object? createdBy = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? eventType = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? isAllDay = null,
    Object? location = freezed,
    Object? locationCoordinates = freezed,
    Object? visibility = null,
    Object? visibleToUserId = freezed,
    Object? color = freezed,
    Object? tags = null,
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
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as EventType,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isAllDay: null == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      locationCoordinates: freezed == locationCoordinates
          ? _value.locationCoordinates
          : locationCoordinates // ignore: cast_nullable_to_non_nullable
              as String?,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as EventVisibility,
      visibleToUserId: freezed == visibleToUserId
          ? _value.visibleToUserId
          : visibleToUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
abstract class _$$CalendarEventImplCopyWith<$Res>
    implements $CalendarEventCopyWith<$Res> {
  factory _$$CalendarEventImplCopyWith(
          _$CalendarEventImpl value, $Res Function(_$CalendarEventImpl) then) =
      __$$CalendarEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'pair_id') String pairId,
      @JsonKey(name: 'created_by') String? createdBy,
      String title,
      String? description,
      @JsonKey(name: 'event_type') EventType eventType,
      @JsonKey(name: 'start_time') DateTime startTime,
      @JsonKey(name: 'end_time') DateTime? endTime,
      @JsonKey(name: 'is_all_day') bool isAllDay,
      String? location,
      @JsonKey(name: 'location_coordinates') String? locationCoordinates,
      EventVisibility visibility,
      @JsonKey(name: 'visible_to_user_id') String? visibleToUserId,
      String? color,
      List<String> tags,
      Map<String, dynamic> metadata,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt});
}

/// @nodoc
class __$$CalendarEventImplCopyWithImpl<$Res>
    extends _$CalendarEventCopyWithImpl<$Res, _$CalendarEventImpl>
    implements _$$CalendarEventImplCopyWith<$Res> {
  __$$CalendarEventImplCopyWithImpl(
      _$CalendarEventImpl _value, $Res Function(_$CalendarEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pairId = null,
    Object? createdBy = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? eventType = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? isAllDay = null,
    Object? location = freezed,
    Object? locationCoordinates = freezed,
    Object? visibility = null,
    Object? visibleToUserId = freezed,
    Object? color = freezed,
    Object? tags = null,
    Object? metadata = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$CalendarEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pairId: null == pairId
          ? _value.pairId
          : pairId // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as EventType,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isAllDay: null == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      locationCoordinates: freezed == locationCoordinates
          ? _value.locationCoordinates
          : locationCoordinates // ignore: cast_nullable_to_non_nullable
              as String?,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as EventVisibility,
      visibleToUserId: freezed == visibleToUserId
          ? _value.visibleToUserId
          : visibleToUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
class _$CalendarEventImpl implements _CalendarEvent {
  const _$CalendarEventImpl(
      {required this.id,
      @JsonKey(name: 'pair_id') required this.pairId,
      @JsonKey(name: 'created_by') this.createdBy,
      required this.title,
      this.description,
      @JsonKey(name: 'event_type') required this.eventType,
      @JsonKey(name: 'start_time') required this.startTime,
      @JsonKey(name: 'end_time') this.endTime,
      @JsonKey(name: 'is_all_day') this.isAllDay = false,
      this.location,
      @JsonKey(name: 'location_coordinates') this.locationCoordinates,
      required this.visibility,
      @JsonKey(name: 'visible_to_user_id') this.visibleToUserId,
      this.color,
      final List<String> tags = const [],
      final Map<String, dynamic> metadata = const {},
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt})
      : _tags = tags,
        _metadata = metadata;

  factory _$CalendarEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalendarEventImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'pair_id')
  final String pairId;
  @override
  @JsonKey(name: 'created_by')
  final String? createdBy;
// Event details
  @override
  final String title;
  @override
  final String? description;
  @override
  @JsonKey(name: 'event_type')
  final EventType eventType;
// Timing
  @override
  @JsonKey(name: 'start_time')
  final DateTime startTime;
  @override
  @JsonKey(name: 'end_time')
  final DateTime? endTime;
  @override
  @JsonKey(name: 'is_all_day')
  final bool isAllDay;
// Location
  @override
  final String? location;
  @override
  @JsonKey(name: 'location_coordinates')
  final String? locationCoordinates;
// Visibility and privacy
  @override
  final EventVisibility visibility;
  @override
  @JsonKey(name: 'visible_to_user_id')
  final String? visibleToUserId;
// Metadata
  @override
  final String? color;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

// Timestamps
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'CalendarEvent(id: $id, pairId: $pairId, createdBy: $createdBy, title: $title, description: $description, eventType: $eventType, startTime: $startTime, endTime: $endTime, isAllDay: $isAllDay, location: $location, locationCoordinates: $locationCoordinates, visibility: $visibility, visibleToUserId: $visibleToUserId, color: $color, tags: $tags, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pairId, pairId) || other.pairId == pairId) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.isAllDay, isAllDay) ||
                other.isAllDay == isAllDay) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.locationCoordinates, locationCoordinates) ||
                other.locationCoordinates == locationCoordinates) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.visibleToUserId, visibleToUserId) ||
                other.visibleToUserId == visibleToUserId) &&
            (identical(other.color, color) || other.color == color) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
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
      createdBy,
      title,
      description,
      eventType,
      startTime,
      endTime,
      isAllDay,
      location,
      locationCoordinates,
      visibility,
      visibleToUserId,
      color,
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_metadata),
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarEventImplCopyWith<_$CalendarEventImpl> get copyWith =>
      __$$CalendarEventImplCopyWithImpl<_$CalendarEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CalendarEventImplToJson(
      this,
    );
  }
}

abstract class _CalendarEvent implements CalendarEvent {
  const factory _CalendarEvent(
      {required final String id,
      @JsonKey(name: 'pair_id') required final String pairId,
      @JsonKey(name: 'created_by') final String? createdBy,
      required final String title,
      final String? description,
      @JsonKey(name: 'event_type') required final EventType eventType,
      @JsonKey(name: 'start_time') required final DateTime startTime,
      @JsonKey(name: 'end_time') final DateTime? endTime,
      @JsonKey(name: 'is_all_day') final bool isAllDay,
      final String? location,
      @JsonKey(name: 'location_coordinates') final String? locationCoordinates,
      required final EventVisibility visibility,
      @JsonKey(name: 'visible_to_user_id') final String? visibleToUserId,
      final String? color,
      final List<String> tags,
      final Map<String, dynamic> metadata,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'updated_at')
      required final DateTime updatedAt}) = _$CalendarEventImpl;

  factory _CalendarEvent.fromJson(Map<String, dynamic> json) =
      _$CalendarEventImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'pair_id')
  String get pairId;
  @override
  @JsonKey(name: 'created_by')
  String? get createdBy;
  @override // Event details
  String get title;
  @override
  String? get description;
  @override
  @JsonKey(name: 'event_type')
  EventType get eventType;
  @override // Timing
  @JsonKey(name: 'start_time')
  DateTime get startTime;
  @override
  @JsonKey(name: 'end_time')
  DateTime? get endTime;
  @override
  @JsonKey(name: 'is_all_day')
  bool get isAllDay;
  @override // Location
  String? get location;
  @override
  @JsonKey(name: 'location_coordinates')
  String? get locationCoordinates;
  @override // Visibility and privacy
  EventVisibility get visibility;
  @override
  @JsonKey(name: 'visible_to_user_id')
  String? get visibleToUserId;
  @override // Metadata
  String? get color;
  @override
  List<String> get tags;
  @override
  Map<String, dynamic> get metadata;
  @override // Timestamps
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$CalendarEventImplCopyWith<_$CalendarEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
