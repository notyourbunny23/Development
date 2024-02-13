import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:g_kasse/product_model.dart';
import 'package:g_kasse/styles.dart';
//import 'package:g_kasse/widgets.dart';
import 'package:g_kasse/boxes.dart';

class Catalog extends StatefulWidget {
  Catalog({super.key});

  @override
  State<Catalog> createState() => _CatalogState();
}

//!Newest code
class ProductDropdownWidget extends StatefulWidget {
  const ProductDropdownWidget({super.key, required productList});

  @override
  State<ProductDropdownWidget> createState() => _ProductDropdownWidgetState();
}

class _ProductDropdownWidgetState extends State<ProductDropdownWidget> {
  Map<String, ProductModel?> selectedProducts = {};

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
//! END

class _CatalogState extends State<Catalog> {
  List<ProductModel> data = [];
  Map<String, List<ProductModel>> categorizedData = {};
  Map<String?, String?> selectedValues = {};
  Map<String?, String?> selectedProductDescriptions = {};

  bool allwaysAddToCartIsSwitched = false;

  @override
  void initState() {
    super.initState();
    getData();
    fetchData();
  }

  Future<void> getData() async {
    final allProducts = boxProducts.values.toList();

    for (var data in allProducts) {
      print(data.toString());
    }

    categorizedData.clear();
    for (var product in allProducts) {
      if (!categorizedData.containsKey(product.category)) {
        categorizedData[product.category] = [];
      }
      categorizedData[product.category]!.add(product);
    }

    for (var category in categorizedData.keys) {
      selectedValues[category] = null;
    }

    setState(() {
      data = allProducts.cast<ProductModel>();
    });
  }

  Future<void> fetchData() async {
    Map<dynamic, dynamic> hiveData = boxProducts.toMap();

    Map<String, ProductModel?> selectedProducts = {};

    hiveData.forEach((key, value) {
      if (value is ProductModel) {
        selectedProducts[key.toString()] = value;
      }
      print("StringList: $selectedProducts");
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Screen width
    double bottomPartWidth = screenWidth - 100; // Bottom Part Width
    double appBarHeight = AppBar().preferredSize.height; // AppBar height
    double singlePiecePriceRowWidth = (MediaQuery.of(context).size.width / 2 - 30 - 10);
    double taxRateRowWidth = (MediaQuery.of(context).size.width / 2 - 30 - 10);
    double imageRowWidth = 60;

    String selectedProductDescription = "selectedValues.values.where((value) => value != null).join(', ')"; // Display selected product for the current category

    return
        //! New Code

        Scaffold(
      backgroundColor: const Color(0xFFFEF7FF),
      //drawer: const GDrawer(),
      //appBar: const GKasseAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height, // Fixed screen size
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 370, // Top section height
                child: Text("top section")),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 370, // Bottom section height
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Text("bottom section"),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    //! END
  }
}
