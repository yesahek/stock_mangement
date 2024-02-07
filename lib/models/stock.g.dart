// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StockAdapter extends TypeAdapter<Stock> {
  @override
  final int typeId = 0;

  @override
  Stock read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Stock(
      id: fields[0] as String,
      code: fields[1] as int,
      name: fields[2] as String,
      dateRegistored: fields[3] as DateTime,
      costPrice: fields[4] as double,
      sellingPrice: fields[5] as double,
      packageType: fields[6] as String,
      transactions: (fields[7] as List).cast<Transaction>(),
    );
  }

  @override
  void write(BinaryWriter writer, Stock obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.dateRegistored)
      ..writeByte(4)
      ..write(obj.costPrice)
      ..writeByte(5)
      ..write(obj.sellingPrice)
      ..writeByte(6)
      ..write(obj.packageType)
      ..writeByte(7)
      ..write(obj.transactions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
