import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'gkasse_classen.dart';
import 'widgets.dart';
import 'package:g_kasse/about.dart';
import 'package:g_kasse/settings.dart';

// Product Lists
List<Products> productList = [
  Products("Prozessoren Intel", "Intel Core i9 13900KS LGA1700 32MB Cache 3.0GHz retail", 123456789, 799.99, 0.19),
  Products("Prozessoren Intel", "Intel Core i5 13600KF LGA1700 24MB Cache 3.5GHz retail", 223456789, 329.99, 0.19),
  Products("Prozessoren Intel", "Intel Core i3 12100F LGA1700 12MB Cache 3.3GHz retail", 323456789, 109.99, 0.19),
  Products("Prozessoren AMD", "AMD Ryzen 7 7800X3D, 4.2 GHz, 8 Kerne, 16 Threads", 313456789, 399.99, 0.19),
  Products("Prozessoren AMD", "AMD Ryzen 9 7950X3D 5,7GHz AM5 144MB Cache", 323456789, 691.99, 0.19),
  Products("Prozessoren AMD", "AMD Ryzen 9 7900X3D 5,6GHz AM5 140MB Cache", 333456789, 549.99, 0.19),
  Products("Mainboards Intel", "MSI Z790 Gaming Plus Wifi (Z790, S1700, ATX, DDR5", 321456789, 239.99, 0.19),
  Products("Mainboards Intel", "MSI PRO B760-P DDR4 II (B760, S1700, ATX, DDR4)", 322456789, 139.99, 0.19),
  Products("Mainboards Intel", "Mainboard ASUS TUF GAMING B760-PLUS WIFI (Intel, 1700, DDR5, ATX)", 324456789, 199.99, 0.19),
  Products("Arbeitsspeicher", "Arbeitsspeicher Item", 0000, 00.00, 0.19),
  Products("Festplatten", "Festplatten Item", 0000, 00.00, 0.19),
  Products("Grafikkarten", "Grafikkarten Item", 0000, 00.00, 0.19),
  Products("PC-Gehäuse", "PC-Gehäuse Item", 0000, 00.00, 0.19),
  Products("Netzteil", "Netzteil Item", 0000, 00.00, 0.19),
  Products("Kühler", "Kühler Item", 0000, 00.00, 0.19),
];
const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

void main() {
  runApp(const MainApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack); // Hide Statusbar
}

class DynamicProdctsDropdown extends StatefulWidget {
  String keyV;
  List<Products> keyValues;

  DynamicProdctsDropdown({required this.keyV, required this.keyValues, super.key});

  @override
  State<DynamicProdctsDropdown> createState() => _DynamicProdctsDropdownState();
}

class _DynamicProdctsDropdownState extends State<DynamicProdctsDropdown> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.keyValues[0].name; // Initial Value
  }

  @override
  Widget build(BuildContext context) {
    //double screenWidth = MediaQuery.of(context).size.width; // Finding a Screen Width in DIP

    //double screenHeight = MediaQuery.of(context).size.height; // Finding a Screen height in DIP

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text(
            widget.keyValues[0].category,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey, // Set the border color here
              width: 1.0, // Set the border width here
            ),
            borderRadius: BorderRadius.circular(10.0), // Set the border radius here
          ),
          child: DropdownButton<String>(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            isExpanded: true,
            itemHeight: null, // Hide baseline
            value: selectedValue,
            items: widget.keyValues.map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value.name,
                child: Text(
                  value.name,
                  style: Theme.of(context).textTheme.labelMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedValue = newValue!;
              });
            },
          ),
        ),
      ],
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    Map<String, List<Products>> productCategories = {};

    for (Products product in productList) {
      String category = product.getCategory();
      if (!productCategories.containsKey(category)) {
        productCategories[category] = [];
      }
      productCategories[category]!.add(product);
    }

    return MaterialApp(
      routes: {
        '/settings': (context) => const Settings(),
        '/about': (context) => const About(),
      },
      title: 'G-Kasse',
      home: Scaffold(
        drawer: const GDrawer(),
        body: Container(
          color: const Color(0xFFFEF7FF),
          child: Column(
            children: [
              TopBar(),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 15, right: 5, bottom: 15),
                child: Container(
                    height: 300,
                    child: Scrollbar(
                      thickness: 5.0,
                      thumbVisibility: true,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: ListView(
                          children: [
                            Column(
                              children: productCategories.keys
                                  .map(
                                    (key) => DynamicProdctsDropdown(
                                      keyV: key,
                                      keyValues: productCategories[key]!,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
              Divider(),
              Container(
                  height: 200,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Pavlo"),
                          // TextField(
                          //   decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Item", enabled: false),
                          // ),
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
