// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:g_kasse/products.dart';
import 'package:g_kasse/styles.dart';
import 'package:g_kasse/about.dart';
import 'package:g_kasse/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      actions: [],
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
            leading: const Icon(Icons.add_circle),
            title: const Text('Produkt hinzufügen'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => AddProduct()),
              // );
              Navigator.pushReplacementNamed(context, '/addproduct');
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

List<AddedToCart> cartItems = [];

double nettoBetrag = 0;
double mwst = 0;
double reBetrag = 0;
double currentProduktNetto = 0;
double currentProduktMwst = 0;
double currentProduktBrutto = 0;

class AddedToCart {
  String description;
  int amount;
  double price;
  double taxRate;

  AddedToCart(this.description, this.amount, this.taxRate, this.price);

  @override
  String toString() {
    return 'AddedToCart{$amount x $description, ${taxRate.toStringAsFixed(0) + "%"}, ${price.toStringAsFixed(2) + "€"}}';
  }
}

Future<void> _showReceiptDialog(BuildContext context) async {
  Future<String?> getStringFromPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> saveStringToPreferences(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

// Загрузка настроек при отображении диалога
  String? headerText = await getStringFromPreferences('headerText');
  String? footerText = await getStringFromPreferences('footerText');
  String? receiptNumberText = await getStringFromPreferences('receiptNumberText');

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Rechung',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$headerText",
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
            const Text(
              "------------------------------------------------------------------------------------",
              style: TextStyle(fontSize: 11),
            ),
            Text(
              "Rechunungsnummer: $receiptNumberText",
              style: TextStyle(fontSize: 11),
            ),
            Text(
              "Rechunungsdatum: ${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year} - ${DateTime.now().hour}:${DateTime.now().minute}",
              style: TextStyle(fontSize: 11),
            ),
            const Text(
              "------------------------------------------------------------------------------------",
              style: TextStyle(fontSize: 11),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height - 20,
                width: MediaQuery.of(context).size.width - 20,
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        '${cartItems[index].amount} x ${cartItems[index].description}',
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: Text('${cartItems[index].price.toStringAsFixed(2)}€'),
                    );
                  },
                ),
              ),
            ),
            Text("Nettobetrag: ${nettoBetrag.toStringAsFixed(2)}€"),
            Text("zzgl. Umsatzsteuer: ${mwst.toStringAsFixed(2)}€"),
            Text("Rechungngsbetrag: ${reBetrag.toStringAsFixed(2)}€"),
            const Text(
              "------------------------------------------------------------------------------------",
              style: TextStyle(fontSize: 11),
            ),
            Text(
              "$footerText",
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            style: gButton,
            onPressed: () {
              // Закрыть AlertDialog
              Navigator.of(context).pop();
            },
            child: Text('Ausdrucken'),
          ),
          TextButton(
            style: gButton,
            onPressed: () {
              // Закрыть AlertDialog
              Navigator.of(context).pop();
            },
            child: Text('Schießen'),
          ),
        ],
      );
    },
  );
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
                                // Add to cart
                                AddedToCart newItem = AddedToCart(
                                  "$selectedProduct",
                                  1,
                                  double.parse("$selectedProducttaxRate"),
                                  double.parse("$selectedProductPrice"),
                                );
                                cartItems.add(newItem);
                                print(cartItems.toString());

                                IconSnackBar.show(
                                    context: context,
                                    snackBarType: SnackBarType.save,
                                    duration: const Duration(milliseconds: 1000),
                                    label: 'Zum Warenkorb hinzugefügt'); // Added to Cart SnackBar Message

                                //! Calculating prices
                                currentProduktBrutto = double.parse("$selectedProductPrice");
                                currentProduktMwst = double.parse("$selectedProductPrice") / 100 * double.parse("$selectedProducttaxRate");
                                currentProduktNetto = double.parse("$selectedProductPrice") - (double.parse("$selectedProductPrice") / 100 * double.parse("$selectedProducttaxRate"));

                                reBetrag = reBetrag + currentProduktBrutto;
                                nettoBetrag = nettoBetrag + currentProduktNetto;
                                mwst = mwst + currentProduktMwst;

                                //! END
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
                              _showReceiptDialog(context);
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
