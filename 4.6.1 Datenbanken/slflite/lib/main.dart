import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

void main() async {
// Initialize the database
  await DatabaseHelper.database;

  // Inserting products into the database
  await DatabaseHelper.insertProduct(Product(description: 'Gigabyte RTX3050 Windforce OC 8GB GDDR6 HDMI DP DVI', price: 245.00, barcode: 4719331312350));
  await DatabaseHelper.insertProduct(Product(description: 'MSI RTX4080 GAMING X TRIO 16GB GDDR6X HDMI 3xDP', price: 1329.00, barcode: 67890));

  runApp(MainApp());
}

class DatabaseHelper {
  static Database? _database;

  // Method to get or create the database
  static Future<Database> get database async {
    WidgetsFlutterBinding.ensureInitialized();

    if (_database != null) return _database!;

    _database = await openDatabase(
      join(await getDatabasesPath(), 'products_database.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database
        return db.execute(
          'CREATE TABLE products(id INTEGER PRIMARY KEY, description TEXT, price DOUBLE, barcode INTEGER)',
        );
      },
      version: 1,
    );

    return _database!;
  }

  // Method to insert a product into the database
  static Future<void> insertProduct(Product product) async {
    final db = await database;
    await db.insert(
      'products',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Method to get all products from the database
  static Future<List<Product>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');

    return List.generate(maps.length, (i) {
      return Product(
        id: maps[i]['id'] as int,
        description: maps[i]['description'] as String,
        price: maps[i]['price'] as double,
        barcode: maps[i]['barcode'] as int,
      );
    });
  }
}

class Product {
  final int? id;
  final String description;
  final double price;
  final int barcode;

  // Product constructor
  const Product({
    this.id,
    required this.description,
    required this.price,
    required this.barcode,
  });

  // Convert a product into a Map for database insertion
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'price': price,
      'barcode': barcode,
    };
  }

  // Override toString method for convenient printing of product information
  @override
  String toString() {
    return 'Product{id: $id, description: $description, price: $price, barcode: $barcode}';
  }
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  // Button press handler
  Future<void> _onPressButton() async {
    List<Product> productList = await DatabaseHelper.getProducts();
    print(productList);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Button to trigger database operation
              ElevatedButton(
                onPressed: () {
                  _onPressButton();
                },
                child: const Text('Get Products from Database'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
