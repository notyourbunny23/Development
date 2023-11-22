import 'package:flutter/material.dart';
import 'package:g_kasse/about.dart';
import 'package:g_kasse/settings.dart';
import 'package:g_kasse/main.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';

String selectedProduct = "";
double selectedProductPrice = 0.00;
double selectedProducttaxRate = 0.00;
int selectedProductbarcode = 0;
double dropDownSectionHeight = 220;

//539

const AddedToCartMessage = SnackBar(
  duration: Duration(milliseconds: 300),
  content: Center(child: Text('\n\nAdded to Cart!\n\n')),
  backgroundColor: Colors.green,
);

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
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Einstellungen'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Settings()),
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

  const ProductDropdownWidget({Key? key, required this.productList}) : super(key: key);

  @override
  _ProductDropdownWidgetState createState() => _ProductDropdownWidgetState();
}

class _ProductDropdownWidgetState extends State<ProductDropdownWidget> {
  Map<String, Products?> selectedProducts = {};

  final scrollController = ScrollController();

  TextEditingController _barcodeFieldController =
      TextEditingController(text: selectedProductbarcode != 0 ? "$selectedProductbarcode" : ""); // Change ControllerText only if selectedProductbarcode != 0

  bool AllwaysAddToCart_isSwitched = false;

  @override
  Widget build(BuildContext context) {
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

      // Добавляем первый элемент в список с названием категории
      dropdownItems.add(
        DropdownMenuItem(
          value: null,
          child: Text(
            category,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

      for (var product in products) {
        dropdownItems.add(
          DropdownMenuItem(
            value: product,
            child: Text(
              product.name,
              style: const TextStyle(fontSize: 14, overflow: TextOverflow.ellipsis),
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
                        selectedProduct = value.name;
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

    return IntrinsicHeight(
      child: Column(
        children: [
          Expanded(
            child: Container(
              height: 100,
              decoration: const BoxDecoration(color: Color(0xFFFEF7FF), boxShadow: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ]),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  child: ListView(
                    controller: scrollController,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(left: 1, top: 10, right: 15, bottom: 10),
                    children: categoryWidgets,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
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
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFF79747E),
                              width: 0.8,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              '$selectedProduct', // Current selected Item
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10), // Space before next Row

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: const Text(
                              'Einzelstück Preis: ', // Current selected Item Price // TODO: change € to currecy variable
                            ),
                          ),
                        ),
                        Container(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              'MwSt.:', // Current selected Item TaxRate
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,

                            //color: Colors.red,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFF79747E),
                                width: 0.8,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  '$selectedProductPrice €', // Current selected Item Price // TODO: change € to currecy variable
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFF79747E),
                                width: 0.8,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  '$selectedProducttaxRate %', // Current selected Item TaxRate
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          child: Placeholder(child: Image.asset("assets/images/image_placeholder.png")),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Container(
                              width: MediaQuery.of(context).size.width - 110,
                              child: TextField(
                                onTap: () {
                                  // _barcodeFieldController.clear(); // Clear textField onTap
                                },
                                //controller: _barcodeFieldController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Name / Barcode',
                                  suffixIcon: Icon(Icons.search),
                                ),
                              )),
                        ),
                        Container(
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFF79747E),
                                width: 0.8,
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                if (selectedProduct != "") {
                                  IconSnackBar.show(context: context, snackBarType: SnackBarType.save, label: 'Added to Cart'); // Added to Cart SnackBar Message
                                }
                              }, // TODO: Add funktion
                              icon: const Icon(Icons.shopping_cart_rounded),
                            )),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: MediaQuery.of(context).size.width - 100, child: Text("Automatisch in den Warenkorb hinzufügen")),
                        Container(
                          child: Switch(
                              value: AllwaysAddToCart_isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  AllwaysAddToCart_isSwitched = value; // TODO: Add funktion
                                });
                              }),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 20,
                          child: ElevatedButton(
                            onPressed: () {}, // TODO: Add funktion
                            child: const Text('Rechnung anzeigen'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
