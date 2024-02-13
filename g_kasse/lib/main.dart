import 'package:flutter/material.dart';
import 'package:g_kasse/about.dart';
import 'package:g_kasse/boxes.dart';
import 'package:g_kasse/product_model.dart';
import 'package:g_kasse/products.dart';
import 'package:g_kasse/settings.dart';
import 'package:g_kasse/addproduct.dart';
import 'package:g_kasse/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  boxProducts = await Hive.openBox<ProductModel>('productBox');

  // runApp(
  //   MaterialApp(
  //       debugShowMaterialGrid: true, // Enable debugging grid
  //       ),
  // );

  runApp(MainApp());
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]); // Hide the status bar
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/settings': (context) => const SettingsPage(),
        '/about': (context) => const About(),
        '/addproduct': (context) => AddProduct(),
      },
      title: 'G-Kasse',
      home: Scaffold(
        appBar: const GKasseAppBar(),
        drawer: const GDrawer(),
        body: ProductDropdownWidget(productList: productList),
        //body: AddProduct(),
      ),
    );
  }
}
