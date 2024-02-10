import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:g_kasse/boxes.dart';
import 'package:g_kasse/product_model.dart';
import 'package:g_kasse/styles.dart';
import 'package:g_kasse/widgets.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _TestAddProduct2State();
}

class _TestAddProduct2State extends State<AddProduct> {
  // TextField Comtrollers
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  TextEditingController _taxController = TextEditingController();
  int selectedTaxValue = 19; // Default Taxrate value

  @override
  void initState() {
    super.initState();
    _taxController = TextEditingController();
    _taxController.text = selectedTaxValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GKasseAppBar(),
      drawer: const GDrawer(),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          //! Start bottom section with Product List

          Expanded(
            child: ListView.builder(
                itemCount: boxProducts.length,
                itemBuilder: (context, index) {
                  ProductModel product = boxProducts.getAt(index);

                  return ListTile(
                    leading: IconButton(
                        onPressed: () {
                          setState(() {
                            boxProducts.deleteAt(index); // Delete Product
                          });
                        },
                        icon: const Icon(Icons.delete)),
                    title: Text(product.description),
                    textColor: Colors.black,
                    subtitle: Text(
                      product.category,
                      style: TextStyle(color: Colors.black87),
                    ),
                    trailing: Text(
                      "${product.price.toString() + " €"}",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }),
          ),

          //! End bottom section with Product List

          Positioned(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color(0xFFFEF7FF)),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    style: gButton,
                    onPressed: () {
                      // Show Dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: AlertDialog(
                              title: const Text(
                                'Produkt hinzufügen',
                                style: TextStyle(fontSize: 15),
                              ),
                              content: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    //! TextFields

                                    Container(
                                      decoration: TextFieldDecoration(),
                                      child: TextField(
                                        style: TextFieldStyle(),
                                        controller: _barcodeController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Barcode",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      decoration: TextFieldDecoration(),
                                      child: TextField(
                                        style: TextFieldStyle(),
                                        maxLines: 1,
                                        controller: _categoryController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Kategorie",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      decoration: TextFieldDecoration(),
                                      child: TextField(
                                        style: TextFieldStyle(),
                                        maxLines: 1,
                                        controller: _descriptionController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Beschreibung",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      decoration: TextFieldDecoration(),
                                      child: TextField(
                                        style: TextFieldStyle(),
                                        maxLines: 1,
                                        controller: _priceController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Preis",
                                        ),
                                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),

                                    //! DropDownMenu
                                    DropdownButtonFormField<int>(
                                      decoration: DropdownDecoration(),
                                      hint: Text("Mehrwertsteuersatz"),
                                      //value: selectedValue,
                                      onChanged: (int? value) {
                                        setState(() {
                                          selectedTaxValue = value!;
                                          _taxController.text = selectedTaxValue.toString();
                                        });
                                      },
                                      items: const [
                                        DropdownMenuItem<int>(
                                          value: 19,
                                          child: Text('19%'),
                                        ),
                                        DropdownMenuItem<int>(
                                          value: 7,
                                          child: Text('7%'),
                                        ),
                                      ],
                                    ),

                                    //! End DropDownMenu

                                    //! End TextFields
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  style: gButton,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  style: gButton,
                                  onPressed: () {
                                    setState(() {
                                      // Add Product to Hive
                                      boxProducts.put(
                                          'key_${_descriptionController.text}',
                                          ProductModel(
                                              category: _categoryController.text,
                                              description: _descriptionController.text,
                                              price: double.parse(_priceController.text),
                                              tax: double.parse(_taxController.text),
                                              barcode: int.parse(_barcodeController.text)));
                                    });
                                    // Clearing TextFields
                                    _barcodeController.clear();
                                    _categoryController.clear();
                                    _descriptionController.clear();
                                    _priceController.clear();
                                    _taxController.clear();

                                    IconSnackBar.show(context: context, snackBarType: SnackBarType.save, duration: const Duration(milliseconds: 700), label: 'Product successfully added');

                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Produkt hinzufügen'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text('Produkt hinzufügen'),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
