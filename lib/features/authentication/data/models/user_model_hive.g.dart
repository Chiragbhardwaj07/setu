// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as String?,
      uid: fields[1] as String?,
      phone: fields[2] as String?,
      name: fields[3] as String?,
      dob: fields[4] as String?,
      email: fields[5] as String?,
      emailVerified: fields[6] as bool,
      region: fields[7] as String?,
      language: fields[8] as String?,
      firstTime: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.uid)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.dob)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.emailVerified)
      ..writeByte(7)
      ..write(obj.region)
      ..writeByte(8)
      ..write(obj.language)
      ..writeByte(9)
      ..write(obj.firstTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
