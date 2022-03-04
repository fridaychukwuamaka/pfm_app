// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DebtAdapter extends TypeAdapter<Debt> {
  @override
  final int typeId = 0;

  @override
  Debt read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Debt(
      id: fields[0] as String?,
      amount: fields[1] as String,
      remark: fields[6] as String,
      isPaid: fields[7] as bool,
      date: fields[2] as DateTime,
      payOffBy: fields[3] as DateTime,
      debtorPhone: fields[4] as String,
      debtorName: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Debt obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.payOffBy)
      ..writeByte(4)
      ..write(obj.debtorPhone)
      ..writeByte(5)
      ..write(obj.debtorName)
      ..writeByte(6)
      ..write(obj.remark)
      ..writeByte(7)
      ..write(obj.isPaid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DebtAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
