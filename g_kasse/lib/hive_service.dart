import 'package:g_kasse/product_model.dart';
import "package:hive/hive.dart";
import "package:path_provider/path_provider.dart" as path_provider;

class HiveService {
  static initHive() async {
    final applicationDocumentDir = await path_provider.getApplicationDocumentsDirectory();

    Hive
      ..init(applicationDocumentDir.path)
      ..registerAdapter(ProductModelAdapter());

    Hive.openBox<ProductModel>('product');
  }

  static void addProduct(ProductModel product) {
    Hive.box<ProductModel>('product').add(product);
  }
}
