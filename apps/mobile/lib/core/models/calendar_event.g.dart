// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CalendarEventImpl _$$CalendarEventImplFromJson(Map<String, dynamic> json) =>
    _$CalendarEventImpl(
      id: json['id'] as String,
      pairId: json['pair_id'] as String,
      createdBy: json['created_by'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      eventType: $enumDecode(_$EventTypeEnumMap, json['event_type']),
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: json['end_time'] == null
          ? null
          : DateTime.parse(json['end_time'] as String),
      isAllDay: json['is_all_day'] as bool? ?? false,
      location: json['location'] as String?,
      locationCoordinates: json['location_coordinates'] as String?,
      visibility: $enumDecode(_$EventVisibilityEnumMap, json['visibility']),
      visibleToUserId: json['visible_to_user_id'] as String?,
      color: json['color'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      isDeleted: json['is_deleted'] as bool? ?? false,
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      deletedBy: json['deleted_by'] as String?,
    );

Map<String, dynamic> _$$CalendarEventImplToJson(_$CalendarEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pair_id': instance.pairId,
      'created_by': instance.createdBy,
      'title': instance.title,
      'description': instance.description,
      'event_type': _$EventTypeEnumMap[instance.eventType]!,
      'start_time': instance.startTime.toIso8601String(),
      'end_time': instance.endTime?.toIso8601String(),
      'is_all_day': instance.isAllDay,
      'location': instance.location,
      'location_coordinates': instance.locationCoordinates,
      'visibility': _$EventVisibilityEnumMap[instance.visibility]!,
      'visible_to_user_id': instance.visibleToUserId,
      'color': instance.color,
      'tags': instance.tags,
      'metadata': instance.metadata,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'is_deleted': instance.isDeleted,
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'deleted_by': instance.deletedBy,
    };

const _$EventTypeEnumMap = {
  EventType.moment: 'moment',
  EventType.date: 'date',
  EventType.appointment: 'appointment',
  EventType.reminder: 'reminder',
  EventType.anniversary: 'anniversary',
  EventType.other: 'other',
};

const _$EventVisibilityEnumMap = {
  EventVisibility.private: 'private',
  EventVisibility.shared: 'shared',
};
