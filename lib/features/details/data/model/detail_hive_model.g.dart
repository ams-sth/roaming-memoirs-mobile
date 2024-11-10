// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetailHiveModelAdapter extends TypeAdapter<DetailHiveModel> {
  @override
  final int typeId = 2;

  @override
  DetailHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetailHiveModel(
      tripId: fields[0] as String?,
      user: fields[5] as UserEntity,
      tripName: fields[1] as String,
      description: fields[2] as String,
      startDate: fields[3] as String,
      endDate: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DetailHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.tripId)
      ..writeByte(1)
      ..write(obj.tripName)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.endDate)
      ..writeByte(5)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
