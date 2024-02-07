// import 'package:hive/hive.dart';
// import 'transaction.dart'; // Import your Transaction class

// class TransactionAdapter extends TypeAdapter<Transaction> {
//   @override
//   final int typeId = 1; // Unique identifier for your type

//   @override
//   Transaction read(BinaryReader reader) {
//     return Transaction(
//       // Implement the logic to read the fields from BinaryReader
//       id: reader.readString(),
//       type: reader.readEnum(),
//       quantity: reader.readInt(),
//       invoiceNumber: reader.readInt(),
//       price: reader.readDouble(),
//       dateTimeTransaction: reader.readDateTime(),
//       dateTimeSaved: reader.readDateTime(),
//     );
//   }

//   @override
//   void write(BinaryWriter writer, Transaction obj) {
//     // Implement the logic to write the fields to BinaryWriter
//     writer.writeString(obj.id);
//     writer.writeEnum(obj.type);
//     writer.writeInt(obj.quantity);
//     writer.writeInt(obj.invoiceNumber);
//     writer.writeDouble(obj.price);
//     writer.writeDateTime(obj.dateTimeTransaction);
//     writer.writeDateTime(obj.dateTimeSaved);
//   }
// }
