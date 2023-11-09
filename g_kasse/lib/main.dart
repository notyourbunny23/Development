import 'package:flutter/material.dart';
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
];

void main() {
  runApp(const MainApp());

  Map<String, List<Products>> productCategories = {};

  for (Products product in productList) {
    String category = product.getCategory();

    if (!productCategories.containsKey(category)) {
      productCategories[category] = [];
    }

    productCategories[category]!.add(product);
  }

  for (String categoryName in productCategories.keys) {
    List<Products> products = productCategories[categoryName]!;

    print("$categoryName:");
    for (Products product in products) {
      print("  * ${product.name}");
    }
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
    return MaterialApp(
      initialRoute: '/',
      routes: {
        //'/': (context) => const ,
        '/settings': (context) => const Settings(),
        '/about': (context) => const About(),
      },
      title: 'G-Kasse',
      home: Scaffold(
        drawer: const GDrawer(),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Image.asset("assets/logo_small.png"),
            // DropDown Element
          ],
        ),
      ),
    );
  }
}
