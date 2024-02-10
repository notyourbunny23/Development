import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:g_kasse/boxes.dart';
import 'package:g_kasse/product_model.dart';

class addProduct extends StatefulWidget {
  const addProduct({Key? key}) : super(key: key);

  @override
  State<addProduct> createState() => _TestAddProduct2State();
}

class _TestAddProduct2State extends State<addProduct> {
  // TextField Comtrollers
  TextEditingController _barcodeController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
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
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Show Dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: AlertDialog(
                          title: Text('Add new Product'),
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width - 200,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //! TextFields

                                TextField(
                                  controller: _barcodeController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Barcode",
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                TextField(
                                  maxLines: 1,
                                  controller: _categoryController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Category",
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                TextField(
                                  maxLines: 1,
                                  controller: _descriptionController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Description",
                                  ),
                                ),
                                const SizedBox(height: 5),
                                TextField(
                                  maxLines: 1,
                                  controller: _priceController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Price",
                                  ),
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                                  ],
                                ),
                                const SizedBox(height: 5.0),

                                //! DropDownMenu
                                DropdownButtonFormField<int>(
                                  hint: Text("Select Tax Rate"),
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
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
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
                              child: Text('Add Product'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text('Add new Product'),
              ),
            ],
          ),

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
          )

          //! End bottom section with Product List
        ],
      ),
    );
  }
}
