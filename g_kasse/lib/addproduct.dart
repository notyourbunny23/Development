import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:g_kasse/products.dart';
import 'package:g_kasse/widgets.dart';

class AddProduct extends StatefulWidget {
  AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController _selectCategory = TextEditingController();

  String selectedCategory = "No product categorys available";

  @override
  Widget build(BuildContext context) {
    List<String> categories = productList.map((product) => product.category).toSet().toList();

    // Ensure the initial value exists in the list of categories
    _selectCategory.text = categories.isNotEmpty ? categories[0] : '';

    return Scaffold(
      backgroundColor: const Color(0xFFFEF7FF),
      appBar: const GKasseAppBar(),
      drawer: const GDrawer(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
                child: const Text(
                  "Produkt hinzufügen",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFF79747E),
                      width: 0.8,
                    ),
                  ),
                  //color: Colors.amber,
                  width: MediaQuery.of(context).size.width - 80.0,
                  height: 50,
                  //padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      ProductDropDown(),
// DropDownWidget
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFF79747E),
                    width: 0.8,
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    _showAddCategoryDialog(context);
                  }, // TODO: Add function
                  icon: const Icon(Icons.add_rounded),
                ),
              )
            ],
          ),
          ElevatedButton(
              onPressed: () {
                getCats();
              },
              child: Text("GET DATA"))
        ],
      ),
    );
  }
}

// ShowDialog Add Category
void _showAddCategoryDialog(BuildContext context) {
  TextEditingController _newCategory = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Kategorie hinzufügen',
          style: TextStyle(fontSize: 16),
        ),
        content: Container(
          height: 70,
          width: 400,
          child: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _newCategory,
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Abbrechen'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Hinzufügen'),
            onPressed: () async {
              //TODO: Add category function
              if (_newCategory.text != "") {
                IconSnackBar.show(context: context, snackBarType: SnackBarType.save, duration: const Duration(milliseconds: 1500), label: 'Added Caterory'); // Added to Cart SnackBar Message
                Navigator.of(context).pop();

                //TODO Firestore Add
                FirebaseFirestore firestore = FirebaseFirestore.instance;

                await firestore.collection('product').add({
                  'Category': _newCategory.text,
                });
              }
            },
          ),
        ],
      );
    },
  );
}

Future<void> getCats() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot querySnapshot = await firestore.collection('product').get();

  List<String> categorysList = [];

  categorysList.clear(); // Clear Category List

  for (QueryDocumentSnapshot doc in querySnapshot.docs) {
    // Получаем данные о категории из каждого документа
    String category = doc['Category'];
    categorysList.add(category);
  }

  print(categorysList);
}

class ProductDropDown extends StatefulWidget {
  @override
  _ProductDropDownState createState() => _ProductDropDownState();
}

class _ProductDropDownState extends State<ProductDropDown> {
  late Map<String, dynamic> productMap;
  String? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('product').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        List<DropdownMenuItem<String>> items = [];
        productMap = {};

        for (QueryDocumentSnapshot document in snapshot.data!.docs) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          String id = document.id;

          // Save data to the map
          productMap[id] = data;

          // Add category to the dropdown items
          items.add(DropdownMenuItem(
            value: id,
            child: Text(data['Category'] ?? 'Unknown Category'),
          ));
        }

        return Column(
          children: [
            DropdownButton(
              padding: EdgeInsets.only(left: 20, right: 10),
              underline: Container(color: Colors.transparent),
              isExpanded: true,
              value: selectedCategoryId,
              items: items,
              onChanged: (value) {
                setState(() {
                  selectedCategoryId = value as String?;
                });
              },
              hint: Text('Select a category'),
            ),
          ],
        );
      },
    );
  }
}
