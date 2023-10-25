import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomeScreen',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/details': (context) => const DetailsScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<String> products = [
    "Produkt 1",
    "Produkt 2",
    "Produkt 3",
    "Produkt 4"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomeScreen"),
      ),
      body: Center(
          child: Column(
        children: [
          for (String product in products)
            Card(
              child: ListTile(
                title: Text(product),
                leading: const Icon(Icons.inventory_2),
                onTap: () {
                  Navigator.pushNamed(context, "/details", arguments: product);
                },
              ),
            ),
        ],
      )),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailsScreen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Details für $product'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/");
              },
              child: const Text('Zurück zum HomeScreen'),
            ),
          ],
        ),
      ),
    );
  }
}
