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
        body: ProductList(),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  ProductList({super.key});
  final List<String> items =
      List.generate(5, (index) => "Product ${index + 1}");

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text(items[index]),
            trailing: Text("\$ ${(index + 1) * 10}"),
          );
        });
  }
}

class MyContent extends StatelessWidget {
  const MyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column();
  }
}
