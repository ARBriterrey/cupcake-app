// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JournalEntryLocalAdapter extends TypeAdapter<JournalEntryLocal> {
  @override
  final int typeId = 1;

  @override
  JournalEntryLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JournalEntryLocal(
      id: fields[0] as String,
      pairId: fields[1] as String,
      createdBy: fields[2] as String?,
      title: fields[3] as String,
      body: fields[4] as String,
      visibility: fields[5] as String,
      visibleToUserId: fields[6] as String?,
      tags: (fields[7] as List?)?.cast<String>(),
      mood: fields[8] as String?,
      calendarEventId: fields[9] as String?,
      createdAt: fields[10] as DateTime,
      updatedAt: fields[11] as DateTime,
      isDeleted: fields[12] as bool,
      deletedAt: fields[13] as DateTime?,
      isSynced: fields[14] as bool,
      lastSyncAttempt: fields[15] as DateTime?,
      isPendingDelete: fields[16] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, JournalEntryLocal obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.pairId)
      ..writeByte(2)
      ..write(obj.createdBy)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.body)
      ..writeByte(5)
      ..write(obj.visibility)
      ..writeByte(6)
      ..write(obj.visibleToUserId)
      ..writeByte(7)
      ..write(obj.tags)
      ..writeByte(8)
      ..write(obj.mood)
      ..writeByte(9)
      ..write(obj.calendarEventId)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.updatedAt)
      ..writeByte(12)
      ..write(obj.isDeleted)
      ..writeByte(13)
      ..write(obj.deletedAt)
      ..writeByte(14)
      ..write(obj.isSynced)
      ..writeByte(15)
      ..write(obj.lastSyncAttempt)
      ..writeByte(16)
      ..write(obj.isPendingDelete);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournalEntryLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
