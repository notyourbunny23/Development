import 'package:flutter/material.dart';
import 'package:g_kasse/products.dart';
import 'package:g_kasse/styles.dart';
import 'package:g_kasse/about.dart';
import 'package:g_kasse/settings.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';

String selectedProduct = "";
double selectedProductPrice = 0.00;
double selectedProducttaxRate = 0.00;
int selectedProductbarcode = 0;

class GKasseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GKasseAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData.fallback(),
      backgroundColor: const Color(0xFFFEF7FF),
      shadowColor: Theme.of(context).colorScheme.shadow,
      elevation: 1,
      centerTitle: true,
      title: Image.asset("assets/logo/logo_small.png"),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class GDrawer extends StatelessWidget {
  const GDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const SizedBox(
            height: 100,
            child: DrawerHeader(
                child: Text(
              "Menü",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            )),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Catalog'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/catalog');
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Produkt hinzufügen'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/addproduct');
            },
          ),
          ListTile(
            leading: const Icon(Icons.euro),
            title: const Text('Rechnung'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => AddProduct()),
              // );
              Navigator.pushReplacementNamed(context, '/receipt');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Einstellungen'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const About()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProductDropdownWidget extends StatefulWidget {
  final List<Products> productList;

  const ProductDropdownWidget({super.key, required this.productList});

  @override
  _ProductDropdownWidgetState createState() => _ProductDropdownWidgetState();
}

class _ProductDropdownWidgetState extends State<ProductDropdownWidget> {
  Map<String, Products?> selectedProducts = {};

  TextEditingController _barcodeFieldController =
      TextEditingController(text: selectedProductbarcode != 0 ? "$selectedProductbarcode" : ""); // Change ControllerText only if selectedProductbarcode != 0

  bool allwaysAddToCartIsSwitched = false;

  @override
  Widget build(BuildContext context) {
    /*
     Screen Size vars
     double screenHeight = MediaQuery.of(context).size.height; // Screen height
    */
    double screenWidth = MediaQuery.of(context).size.width; // Screen width
    double bottomPartWidth = screenWidth - 100; // Bottom Part Width
    double appBarHeight = AppBar().preferredSize.height; // AppBar height
    double singlePiecePriceRowWidth = (MediaQuery.of(context).size.width / 2 - 30 - 10);
    double taxRateRowWidth = (MediaQuery.of(context).size.width / 2 - 30 - 10);
    double imageRowWidth = 60;

    /*
     Sorting by Category Name
    */
    Map<String, List<Products>> categorizedProducts = {};

    for (var product in widget.productList) {
      if (!categorizedProducts.containsKey(product.category)) {
        categorizedProducts[product.category] = [];
      }
      categorizedProducts[product.category]!.add(product);
    }

    List<Widget> categoryWidgets = [];

    categorizedProducts.forEach((category, products) {
      List<DropdownMenuItem<Products>> dropdownItems = [];
      /*
       Adding first element with Categoryname
      */
      dropdownItems.add(
        DropdownMenuItem(
          value: null,
          child: Text(
            category,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
      /*
       Adding other elements
      */
      for (var product in products) {
        dropdownItems.add(
          DropdownMenuItem(
            value: product,
            child: Text(
              product.description,
              style: const TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis),
            ),
          ),
        );
      }

      categoryWidgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50, // Dropdowns height
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0), // Padding bottom for each dropdown element
                child: DropdownButtonFormField(
                  dropdownColor: Colors.white,
                  isExpanded: true,
                  menuMaxHeight: 600,
                  items: dropdownItems,
                  onChanged: (value) {
                    setState(() {
                      selectedProducts[category] = value as Products?;

                      // Display current selected Item Description
                      if (value != null) {
                        selectedProduct = value.description;
                      }

                      // Display current selected Item Price
                      if (value != null) {
                        selectedProductPrice = value.price;
                      }

                      // Display current selected Item TaxRate
                      if (value != null) {
                        selectedProducttaxRate = value.tax * 100;
                      }

                      // Display current selected Item Barcode
                      if (value != null) {
                        selectedProductbarcode = value.barcode;
                        _barcodeFieldController.text = "$selectedProductbarcode";
                      }

                      //TODO: Display current selected Item Image

                      // Reset other Dropdowns
                      for (var otherCategory in categorizedProducts.keys) {
                        if (otherCategory != category) {
                          selectedProducts[otherCategory] = null;
                        }
                      }
                    });
                  },
                  value: selectedProducts[category],
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });

    return Stack(
      children: [
        //
        // Top Part with ListView.builder
        // Building ListView
        //
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 370, // Учитываем высоту Positioned в нижней части
          child: Scrollbar(
            thumbVisibility: true,
            trackVisibility: false,
            thickness: 5,
            child: Container(
              decoration: const BoxDecoration(color: Color(0xFFFEF7FF), boxShadow: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ]),
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 10, top: 10, right: 15, bottom: 10),
                children: categoryWidgets,
              ),
            ),
          ),
        ),

        // Bottom Part with Positioned
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 370,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                width: bottomPartWidth - 20, // Bottom Part width - Padding left and right (each 10)
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 30,
                          child: const Text("Ausgewählte Produkt:"),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width - 20, // Bottom full width - Padding left and right (each 10)
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFF79747E),
                                width: 0.8,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '$selectedProduct', // Current selected Item
                              ),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 10,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: singlePiecePriceRowWidth - 10,
                          child: const Text('Einzelstück Preis: '),
                        ),
                        Container(
                          width: taxRateRowWidth,
                          child: const Text('MwSt: '),
                        ),
                        Container(
                          width: imageRowWidth,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 45,
                          //width: MediaQuery.of(context).size.width / 3 + 20,
                          width: singlePiecePriceRowWidth - 10, //TODO
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFF79747E),
                              width: 0.8,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "$selectedProductPrice €", // Current selected Item Price // TODO: change € to currecy variable
                            ),
                          ),
                        ),
                        Container(
                          child: Container(
                            height: 45,
                            //width: MediaQuery.of(context).size.width / 3 + 5,
                            width: taxRateRowWidth - 10, //TODO
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFF79747E),
                                width: 0.8,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "$selectedProducttaxRate %", // Current selected Item TaxRate
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          width: imageRowWidth,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Image.asset("assets/images/image_placeholder.png"), // Current selected Item Image
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width - 90, // - 3x Padding and button width
                            child: TextField(
                              onTap: () {
                                _barcodeFieldController.clear(); // Clear textField onTap
                              },
                              controller: _barcodeFieldController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Name / Barcode',
                                suffixIcon: Icon(Icons.search),
                              ),
                            )),
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: const Color(0xFF79747E),
                              width: 0.8,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              if (selectedProduct != "") {
                                IconSnackBar.show(
                                    context: context, snackBarType: SnackBarType.save, duration: const Duration(milliseconds: 700), label: 'Added to Cart'); // Added to Cart SnackBar Message
                              }
                            }, // TODO: Add funktion
                            icon: const Icon(Icons.shopping_cart_rounded),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 80,
                          child: const Text("Automatisch in den Warenkorb hinzufügen"),
                        ),
                        Container(
                          width: 60,
                          child: Switch(
                              value: allwaysAddToCartIsSwitched,
                              activeColor: Colors.green.shade900,
                              onChanged: (value) {
                                setState(() {
                                  allwaysAddToCartIsSwitched = value; // TODO: Add funktion
                                });
                              }),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 20,
                          height: 40,
                          child: ElevatedButton(
                            style: gButton,
                            onPressed: () {
                              print("AppBar height: $appBarHeight");
                              print("Bottom Part width: $bottomPartWidth");
                            }, // TODO: Add funktion
                            child: const Text('Rechnung anzeigen'),
                          ),
                        )
                      ],
                    )
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
