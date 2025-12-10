// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JournalEntryImpl _$$JournalEntryImplFromJson(Map<String, dynamic> json) =>
    _$JournalEntryImpl(
      id: json['id'] as String,
      pairId: json['pair_id'] as String,
      createdBy: json['created_by'] as String?,
      title: json['title'] as String,
      body: json['body'] as String,
      visibility:
          $enumDecodeNullable(_$EventVisibilityEnumMap, json['visibility']) ??
              EventVisibility.private,
      visibleToUserId: json['visible_to_user_id'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      mood: json['mood'] as String?,
      calendarEventId: json['calendar_event_id'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      isDeleted: json['is_deleted'] as bool? ?? false,
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      deletedBy: json['deleted_by'] as String?,
    );

Map<String, dynamic> _$$JournalEntryImplToJson(_$JournalEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pair_id': instance.pairId,
      'created_by': instance.createdBy,
      'title': instance.title,
      'body': instance.body,
      'visibility': _$EventVisibilityEnumMap[instance.visibility]!,
      'visible_to_user_id': instance.visibleToUserId,
      'tags': instance.tags,
      'mood': instance.mood,
      'calendar_event_id': instance.calendarEventId,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'is_deleted': instance.isDeleted,
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'deleted_by': instance.deletedBy,
    };

const _$EventVisibilityEnumMap = {
  EventVisibility.private: 'private',
  EventVisibility.shared: 'shared',
};
