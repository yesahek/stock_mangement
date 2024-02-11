import 'package:hive/hive.dart';
import 'transaction.dart';

class TransactionAdapter extends TypeAdapter<Transaction> {
  @override
  final typeId = 0; // Unique ID for Hive TypeAdapter

  @override
  Transaction read(BinaryReader reader) {
    // Read fields from binary
    final type = reader.readByte();
    final quantity = reader.readInt();
    final invoiceNumber = reader.readInt();
    final dateTimeTransaction = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final dateTimeSaved = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final price = reader.readDouble();
    final remark = reader.readString();

    // Convert the type byte to TransactionType
    final transactionType = TransactionType.values[type];

    return Transaction(
      id: '', // You may need to modify this based on your implementation
      type: transactionType,
      quantity: quantity,
      invoiceNumber: invoiceNumber,
      dateTimeTransaction: dateTimeTransaction,
      dateTimeSaved: dateTimeSaved,
      price: price,
      remark: remark,
    );
  }

  @override
  void write(BinaryWriter writer, Transaction obj) {
    // Write fields to binary
    writer.writeByte(obj.type.index);
    writer.writeInt(obj.quantity);
    writer.writeInt(obj.invoiceNumber);
    writer.writeInt(obj.dateTimeTransaction.millisecondsSinceEpoch);
    writer.writeInt(obj.dateTimeSaved.millisecondsSinceEpoch);
    writer.writeDouble(obj.price);
    writer.writeString(obj.remark);
  }
}
