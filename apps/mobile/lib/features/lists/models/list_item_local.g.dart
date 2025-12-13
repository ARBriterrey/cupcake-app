// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_item_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListItemLocalAdapter extends TypeAdapter<ListItemLocal> {
  @override
  final int typeId = 4;

  @override
  ListItemLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListItemLocal(
      id: fields[0] as String,
      listId: fields[1] as String,
      title: fields[2] as String,
      description: fields[3] as String?,
      assignedTo: fields[4] as String?,
      assignedAt: fields[5] as DateTime?,
      isCompleted: fields[6] as bool,
      completedBy: fields[7] as String?,
      completedAt: fields[8] as DateTime?,
      sortOrder: fields[9] as int,
      createdBy: fields[10] as String,
      createdAt: fields[11] as DateTime,
      updatedAt: fields[12] as DateTime,
      isDeleted: fields[13] as bool,
      deletedAt: fields[14] as DateTime?,
      deletedBy: fields[15] as String?,
      isSynced: fields[16] as bool,
      lastSyncedAt: fields[17] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ListItemLocal obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.listId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.assignedTo)
      ..writeByte(5)
      ..write(obj.assignedAt)
      ..writeByte(6)
      ..write(obj.isCompleted)
      ..writeByte(7)
      ..write(obj.completedBy)
      ..writeByte(8)
      ..write(obj.completedAt)
      ..writeByte(9)
      ..write(obj.sortOrder)
      ..writeByte(10)
      ..write(obj.createdBy)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.updatedAt)
      ..writeByte(13)
      ..write(obj.isDeleted)
      ..writeByte(14)
      ..write(obj.deletedAt)
      ..writeByte(15)
      ..write(obj.deletedBy)
      ..writeByte(16)
      ..write(obj.isSynced)
      ..writeByte(17)
      ..write(obj.lastSyncedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListItemLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
