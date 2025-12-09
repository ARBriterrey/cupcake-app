// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalendarEventLocalAdapter extends TypeAdapter<CalendarEventLocal> {
  @override
  final int typeId = 0;

  @override
  CalendarEventLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalendarEventLocal(
      id: fields[0] as String,
      pairId: fields[1] as String,
      createdBy: fields[2] as String?,
      title: fields[3] as String,
      description: fields[4] as String?,
      eventType: fields[5] as String,
      startTime: fields[6] as DateTime,
      endTime: fields[7] as DateTime?,
      isAllDay: fields[8] as bool,
      location: fields[9] as String?,
      locationCoordinates: fields[10] as String?,
      visibility: fields[11] as String,
      visibleToUserId: fields[12] as String?,
      color: fields[13] as String?,
      tags: (fields[14] as List).cast<String>(),
      metadata: (fields[15] as Map).cast<dynamic, dynamic>(),
      createdAt: fields[16] as DateTime,
      updatedAt: fields[17] as DateTime,
      isSynced: fields[18] as bool,
      lastSyncAttempt: fields[19] as DateTime?,
      isDeleted: fields[20] as bool,
      deletedAt: fields[21] as DateTime?,
      deletedBy: fields[22] as String?,
      isPendingDelete: fields[23] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CalendarEventLocal obj) {
    writer
      ..writeByte(24)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.pairId)
      ..writeByte(2)
      ..write(obj.createdBy)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.eventType)
      ..writeByte(6)
      ..write(obj.startTime)
      ..writeByte(7)
      ..write(obj.endTime)
      ..writeByte(8)
      ..write(obj.isAllDay)
      ..writeByte(9)
      ..write(obj.location)
      ..writeByte(10)
      ..write(obj.locationCoordinates)
      ..writeByte(11)
      ..write(obj.visibility)
      ..writeByte(12)
      ..write(obj.visibleToUserId)
      ..writeByte(13)
      ..write(obj.color)
      ..writeByte(14)
      ..write(obj.tags)
      ..writeByte(15)
      ..write(obj.metadata)
      ..writeByte(16)
      ..write(obj.createdAt)
      ..writeByte(17)
      ..write(obj.updatedAt)
      ..writeByte(18)
      ..write(obj.isSynced)
      ..writeByte(19)
      ..write(obj.lastSyncAttempt)
      ..writeByte(20)
      ..write(obj.isDeleted)
      ..writeByte(21)
      ..write(obj.deletedAt)
      ..writeByte(22)
      ..write(obj.deletedBy)
      ..writeByte(23)
      ..write(obj.isPendingDelete);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalendarEventLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
