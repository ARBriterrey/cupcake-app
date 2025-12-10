// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nudge_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NudgeLocalAdapter extends TypeAdapter<NudgeLocal> {
  @override
  final int typeId = 2;

  @override
  NudgeLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NudgeLocal(
      id: fields[0] as String,
      pairId: fields[1] as String,
      senderId: fields[2] as String,
      receiverId: fields[3] as String,
      nudgeType: fields[4] as String,
      createdAt: fields[5] as DateTime,
      viewedAt: fields[6] as DateTime?,
      expiresAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, NudgeLocal obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.pairId)
      ..writeByte(2)
      ..write(obj.senderId)
      ..writeByte(3)
      ..write(obj.receiverId)
      ..writeByte(4)
      ..write(obj.nudgeType)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.viewedAt)
      ..writeByte(7)
      ..write(obj.expiresAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NudgeLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
