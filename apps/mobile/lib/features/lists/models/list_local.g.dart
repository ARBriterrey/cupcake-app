// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListLocalAdapter extends TypeAdapter<ListLocal> {
  @override
  final int typeId = 3;

  @override
  ListLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListLocal(
      id: fields[0] as String,
      pairId: fields[1] as String,
      title: fields[2] as String,
      listType: fields[3] as String,
      description: fields[4] as String?,
      currentTurnUserId: fields[5] as String?,
      lastPickAt: fields[6] as DateTime?,
      createdBy: fields[7] as String,
      createdAt: fields[8] as DateTime,
      updatedAt: fields[9] as DateTime,
      isDeleted: fields[10] as bool,
      deletedAt: fields[11] as DateTime?,
      deletedBy: fields[12] as String?,
      isSynced: fields[13] as bool,
      lastSyncedAt: fields[14] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ListLocal obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.pairId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.listType)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.currentTurnUserId)
      ..writeByte(6)
      ..write(obj.lastPickAt)
      ..writeByte(7)
      ..write(obj.createdBy)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.isDeleted)
      ..writeByte(11)
      ..write(obj.deletedAt)
      ..writeByte(12)
      ..write(obj.deletedBy)
      ..writeByte(13)
      ..write(obj.isSynced)
      ..writeByte(14)
      ..write(obj.lastSyncedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
