import 'package:g_kasse/boxes.dart';
import 'package:g_kasse/product_model.dart';

Future<List<ProductModel>> fetchData() async {
  Map<dynamic, dynamic> hiveData = boxProducts.toMap();

  List<ProductModel> selectedProducts = [];

  hiveData.forEach((key, value) {
    if (value is ProductModel) {
      selectedProducts.add(value);
    }
  });
  print(selectedProducts);
  return selectedProducts;
}
