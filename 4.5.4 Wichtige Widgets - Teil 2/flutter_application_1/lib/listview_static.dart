import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ListView Exercise",
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 238, 238, 238),
        appBar: AppBar(
          title: const Text('SizedBox Exercise'),
        ),
        body: const ProductList(),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text("Product 1"),
          trailing: Text("\$ 10"),
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text("Product 2"),
          trailing: Text("\$ 20"),
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text("Product 3"),
          trailing: Text("\$ 30"),
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text("Product 4"),
          trailing: Text("\$ 40"),
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text("Product 5"),
          trailing: Text("\$ 50"),
        ),
      ],
    );
  }
}

class MyContent extends StatelessWidget {
  const MyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column();
  }
}
