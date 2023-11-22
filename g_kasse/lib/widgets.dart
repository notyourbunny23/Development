import 'package:flutter/material.dart';
import 'package:g_kasse/about.dart';
import 'package:g_kasse/settings.dart';
import 'package:g_kasse/main.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';

String selectedProduct = "";
double selectedProductPrice = 0.00;
double selectedProducttaxRate = 0.00;
int selectedProductbarcode = 0;
double DropDownSectionHeight = 220;

//539

const AddedToCartMessage = SnackBar(
  duration: Duration(milliseconds: 500),
  content: Center(child: Text('\n\nAdded to Cart!\n\n')),
  backgroundColor: Colors.green,
);

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    DropDownSectionHeight = MediaQuery.of(context).size.height - 460; // Calculating DropDown Section Size //TODO: Must be fixed!

    return Column(
      children: [
        Container(
          height: 64,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Color(0xFFFEF7FF), boxShadow: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ]),
          child: SizedBox(
            height: 64,
            child: Row(
              children: [
                IconButton(
                  iconSize: 40,
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer(); // Open GDrawer
                  },
                ),
                Image.asset("assets/logo_small.png"), // Logo
                IconButton(
                  iconSize: 40,
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    // ...
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 8, // To show TopBar Shadows
        )
      ],
    );
  }
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
              //color: Colors.grey, // Font color
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

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width, // ListView width
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
              height: DropDownSectionHeight, // Calculated Automaticaly

              child: Column(
                children: [
                  SizedBox(
                    height: DropDownSectionHeight, // Calculated Automaticaly
                    child: Scrollbar(
                      thickness: 5.0,
                      thumbVisibility: true,
                      child: ListView(
                        padding: const EdgeInsets.only(left: 1, top: 10, right: 15, bottom: 10),
                        children: categoryWidgets,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),

        // Bottom content

        Padding(
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
                    height: 50,
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
                      height: 20,
                      child: const Text(
                        'Einzelstück Preis: ', // Current selected Item Price // TODO: change € to currecy variable
                      ),
                    ),
                  ),
                  Container(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 20,
                      //color: Colors.red,

                      child: Text(
                        'MwSt.:', // Current selected Item TaxRate
                      ),
                    ),
                  ),
                  Container(
                    width: 60,

                    //color: Colors.yellow,
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 40,
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
                      height: 40,
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
                    width: 60,
                    height: 60,
                    child: Placeholder(child: Image.asset("assets/images/image_placeholder.png")),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 60,
                    child: Container(
                        width: MediaQuery.of(context).size.width - 110,
                        height: 20,
                        child: TextField(
                          onTap: () {
                            _barcodeFieldController.clear(); // Clear textField onTap
                          },
                          controller: _barcodeFieldController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Name / Barcode',
                            suffixIcon: Icon(Icons.search),
                          ),
                        )),
                  ),
                  Container(
                      width: 60,
                      height: 60,
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
                      height: 40,
                      child: Switch(
                          value: AllwaysAddToCart_isSwitched,
                          onChanged: (value) {
                            setState(() {
                              AllwaysAddToCart_isSwitched = value; // TODO: Add funktion
                            });
                          }))
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 35,
              width: MediaQuery.of(context).size.width - 20,
              child: ElevatedButton(
                onPressed: () {}, // TODO: Add funktion
                child: const Text('Rechnung anzeigen'),
              ),
            ),
          ],
        )
      ],
    );
  }
}
