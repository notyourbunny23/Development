import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel {
  ProductModel({required this.category, required this.description, required this.price, required this.tax, required this.barcode});

  @HiveField(0)
  int barcode;

  @HiveField(1)
  String category;

  @HiveField(2)
  String description;

  @HiveField(3)
  double price;

  @HiveField(4)
  double tax;

  @override
  String toString() {
    return 'ProductModel{barcode: $barcode, category: $category, description: $description, price: $price, tax: $tax}';
  }
}
