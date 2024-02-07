import 'package:hive/hive.dart'; // Adjust the import path based on your project structure
import 'stock.dart';
import 'transaction.dart';

class StockAdapter extends TypeAdapter<Stock> {
  @override
  final int typeId = 1; // Unique ID for the adapter

  @override
  Stock read(BinaryReader reader) {
    // Implement how to read the Stock object from binary
    // This method is called when retrieving the object from the box
    return Stock(
      id: reader.readString(),
      code: reader.readInt(),
      name: reader.readString(),
      dateRegistored: DateTime.parse(reader.readString()),
      costPrice: reader.readDouble(),
      sellingPrice: reader.readDouble(),
      packageType: reader.readString(),
     transactions: List<Transaction>.from(reader.readList()),

    );
  }

  @override
  void write(BinaryWriter writer, Stock obj) {
    // Implement how to write the Stock object to binary
    // This method is called when storing the object in the box
    writer.writeString(obj.id);
    writer.writeInt(obj.code);
    writer.writeString(obj.name);
    writer.writeString(obj.dateRegistored.toIso8601String());
    writer.writeDouble(obj.costPrice);
    writer.writeDouble(obj.sellingPrice);
    writer.writeString(obj.packageType);
    writer.writeList(obj.transactions);
  }
}
