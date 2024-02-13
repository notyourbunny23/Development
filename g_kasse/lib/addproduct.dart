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
                    title: Text(
                      product.description,
                      style: TextStyle(fontSize: 14),
                    ),
                    textColor: Colors.black,
                    subtitle: Text(
                      product.category,
                      style: TextStyle(color: Colors.black87),
                    ),
                    trailing: Text(
                      "${product.price.toStringAsFixed(2) + " €"}",
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
                                      style: TextStyle(fontSize: 14, color: Colors.black),
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
//                                 TextButton(
//                                     onPressed: () {
//                                       setState(() {
//                                         // Add Product to Hive
//                                         boxProducts.put(
//                                             'key_${"Intel Core i9 13900KS LGA1700 32MB Cache 3.0GHz retail"}',
//                                             ProductModel(
//                                                 category: "Prozessoren Intel", description: "Intel Core i9 13900KS LGA1700 32MB Cache 3.0GHz retail", price: 799.99, tax: 0.19, barcode: 123456789));
// //!
//                                         boxProducts.put(
//                                             'key_${"Intel Core i5 13600KF LGA1700 24MB Cache 3.5GHz retail"}',
//                                             ProductModel(
//                                                 category: "Prozessoren Intel", description: "Intel Core i5 13600KF LGA1700 24MB Cache 3.5GHz retail", price: 329.99, tax: 0.19, barcode: 223456789));
// //!
//                                         boxProducts.put(
//                                             'key_${"Intel Core i3 12100F LGA1700 12MB Cache 3.3GHz retail"}',
//                                             ProductModel(
//                                                 category: "Prozessoren Intel", description: "Intel Core i3 12100F LGA1700 12MB Cache 3.3GHz retail", price: 109.99, tax: 0.19, barcode: 323456789));
// //!
//                                         boxProducts.put(
//                                             'key_${"Intel Core i7 14700K LGA1700 33MB Cache 3,4GHz retail"}',
//                                             ProductModel(
//                                                 category: "Prozessoren Intel", description: "Intel Core i7 14700K LGA1700 33MB Cache 3,4GHz retail", price: 472.00, tax: 0.19, barcode: 5032037278485));
// //!
//                                         boxProducts.put(
//                                             'key_${"Intel Core i5 12600K LGA1700 20MB Cache 3,7GHz retail"}',
//                                             ProductModel(
//                                                 category: "Prozessoren Intel", description: "Intel Core i5 12600K LGA1700 20MB Cache 3,7GHz retail", price: 250.00, tax: 0.19, barcode: 5032037234108));
// //!
//                                         boxProducts.put(
//                                             'key_${"Intel Core i9 12900K LGA1700 30MB Cache 3,2GHz retail"}',
//                                             ProductModel(
//                                                 category: "Prozessoren Intel", description: "Intel Core i9 12900K LGA1700 30MB Cache 3,2GHz retail", price: 449.00, tax: 0.19, barcode: 5032037234641));
// //!
//                                         boxProducts.put(
//                                             'key_${"Intel Core i5 13400F LGA1700 20MB Cache 2,5GHz tray"}',
//                                             ProductModel(
//                                                 category: "Prozessoren Intel", description: "Intel Core i5 13400F LGA1700 20MB Cache 2,5GHz tray", price: 209.00, tax: 0.19, barcode: 8071505093005));
// //!
//                                         boxProducts.put(
//                                             'key_${"Intel Core i3 12100 LGA1700 12MB Cache 3,3GHz retail"}',
//                                             ProductModel(
//                                                 category: "Prozessoren Intel", description: "Intel Core i3 12100 LGA1700 12MB Cache 3,3GHz retail", price: 160.00, tax: 0.19, barcode: 5032037238458));
// //!
//                                         boxProducts.put('key_${"AMD Ryzen 7 7800X3D, 4.2 GHz, 8 Kerne, 16 Threads"}',
//                                             ProductModel(category: "Prozessoren AMD", description: "AMD Ryzen 7 7800X3D, 4.2 GHz, 8 Kerne, 16 Threads", price: 399.99, tax: 0.19, barcode: 313456789));
// //!
//                                         boxProducts.put('key_${"AMD Ryzen 9 7950X3D 5,7GHz AM5 144MB Cache"}',
//                                             ProductModel(category: "Prozessoren AMD", description: "AMD Ryzen 9 7950X3D 5,7GHz AM5 144MB Cache", price: 691.99, tax: 0.19, barcode: 323456789));
// //!
//                                         boxProducts.put('key_${"AMD Ryzen 9 7900X3D 5,6GHz AM5 140MB Cache"}',
//                                             ProductModel(category: "Prozessoren AMD", description: "AMD Ryzen 9 7900X3D 5,6GHz AM5 140MB Cache", price: 549.99, tax: 0.19, barcode: 333456789));
// //!
//                                         boxProducts.put('key_${"MSI Z790 Gaming Plus Wifi Z790, S1700, ATX, DDR5"}',
//                                             ProductModel(category: "Mainboards Intel", description: "MSI Z790 Gaming Plus Wifi Z790, S1700, ATX, DDR5", price: 239.99, tax: 0.19, barcode: 321456789));
// //!
//                                         boxProducts.put('key_${"MSI PRO B760-P DDR4 II B760, S1700, ATX, DDR4"}',
//                                             ProductModel(category: "Mainboards Intel", description: "MSI PRO B760-P DDR4 II B760, S1700, ATX, DDR4", price: 139.99, tax: 0.19, barcode: 322456789));
// //!
//                                         boxProducts.put(
//                                             'key_${"Mainboard ASUS TUF GAMING B760-PLUS WIFI, Intel, 1700, DDR5, ATX"}',
//                                             ProductModel(
//                                                 category: "Mainboards Intel",
//                                                 description: "Mainboard ASUS TUF GAMING B760-PLUS WIFI, Intel, 1700, DDR5, ATX",
//                                                 price: 199.99,
//                                                 tax: 0.19,
//                                                 barcode: 324456789));
// //!
//                                         boxProducts.put(
//                                             'key_${"DDR5 32GB PC 6000 CL40 G.Skill 2x16GB 32-GX2-FX5 FLARE A"}',
//                                             ProductModel(
//                                                 category: "Arbeitsspeicher",
//                                                 description: "DDR5 32GB PC 6000 CL40 G.Skill 2x16GB 32-GX2-FX5 FLARE A",
//                                                 price: 134.00,
//                                                 tax: 0.19,
//                                                 barcode: 4713294230539));
// //!
//                                         boxProducts.put(
//                                             'key_${"DDR4 16GB PC 4000 CL17 G.Skill KIT 2x8GB 16GVKB Ripjaws"}',
//                                             ProductModel(
//                                                 category: "Arbeitsspeicher", description: "DDR4 16GB PC 4000 CL17 G.Skill KIT 2x8GB 16GVKB Ripjaws", price: 85.00, tax: 0.19, barcode: 4713294226150));
// //!
//                                         boxProducts.put(
//                                             'key_${"DDR4 16GB PC 2400 CL16 KIT 4x4GB Crucial Ballistix Sp"}',
//                                             ProductModel(
//                                                 category: "Arbeitsspeicher", description: "DDR4 16GB PC 2400 CL16 KIT 4x4GB Crucial Ballistix Sp", price: 125.00, tax: 0.19, barcode: 649528769800));
// //!
//                                         boxProducts.put(
//                                             'key_${"SSD 500GB ADATA M.2 PCI-E NVMe Gen3 Legend 750 retail"}',
//                                             ProductModel(
//                                                 category: "Festplatten", description: "SSD 500GB ADATA M.2 PCI-E NVMe Gen3 Legend 750 retail", price: 29.00, tax: 0.19, barcode: 4711085935915));
// //!
//                                         boxProducts.put(
//                                             'key_${"SSD 1TB Samsung M.2 PCI-E NVMe Gen4 980 PRO Heatsink"}',
//                                             ProductModel(
//                                                 category: "Festplatten", description: "SSD 1TB Samsung M.2 PCI-E NVMe Gen4 980 PRO Heatsink", price: 179.00, tax: 0.19, barcode: 8806092837683));
// //!
//                                         boxProducts.put('key_${"SSD 1TB Samsung M.2 PCI-E NVMe 980 Basic retail"}',
//                                             ProductModel(category: "Festplatten", description: "SSD 1TB Samsung M.2 PCI-E NVMe 980 Basic retail", price: 74.90, tax: 0.19, barcode: 8806090572210));
// //!
//                                         boxProducts.put('key_${"MSI RTX4090 GAMING X TRIO 24G"}',
//                                             ProductModel(category: "Grafikkarten", description: "MSI RTX4090 GAMING X TRIO 24G", price: 2049.00, tax: 0.19, barcode: 4711377019217));
// //!
//                                         boxProducts.put('key_${"ASUS TUF-RTX4070-O12G-GAMING"}',
//                                             ProductModel(category: "Grafikkarten", description: "ASUS TUF-RTX4070-O12G-GAMING", price: 699.00, tax: 0.19, barcode: 4711387128176));
// //!
//                                         boxProducts.put(
//                                             'key_${"Sapphire Radeon RX7900XTX Gaming OC Nitro+ 24GB GDDR6 2xHDMI"}',
//                                             ProductModel(
//                                                 category: "Grafikkarten",
//                                                 description: "Sapphire Radeon RX7900XTX Gaming OC Nitro+ 24GB GDDR6 2xHDMI",
//                                                 price: 1199.00,
//                                                 tax: 0.19,
//                                                 barcode: 4895106293328));
// //!
//                                         boxProducts.put('key_${"NZXT H5 Flow Matte Black Mid Tower Case"}',
//                                             ProductModel(category: "PC-Gehäuse", description: "NZXT H5 Flow Matte Black Mid Tower Case", price: 83.00, tax: 0.19, barcode: 5056547202334));
// //!
//                                         boxProducts.put('key_${"be quiet! Pure Base 500 FX Black ARGB"}',
//                                             ProductModel(category: "PC-Gehäuse", description: "be quiet! Pure Base 500 FX Black ARGB", price: 119.00, tax: 0.19, barcode: 4260052189054));
// //!
//                                         boxProducts.put('key_${"MSI Midi MPG VELOX 100R, B/Tempered Glas/System Fan"}',
//                                             ProductModel(category: "PC-Gehäuse", description: "MSI Midi MPG VELOX 100R, B/Tempered Glas/System Fan", price: 129.00, tax: 0.19, barcode: 4719072829315));
// //!
//                                         boxProducts.put(
//                                             'key_${"Seasonic Netzteil 1200W VERTEX-PX-1200 ATX30 Modular Gold"}',
//                                             ProductModel(
//                                                 category: "Netzteile", description: "Seasonic Netzteil 1200W VERTEX-PX-1200 ATX30 Modular Gold", price: 269.00, tax: 0.19, barcode: 4711173877769));
// //!
//                                         boxProducts.put('key_${"Thermaltake Smart BM3 850W ATX3.0 80+ Bronze"}',
//                                             ProductModel(category: "Netzteile", description: "Thermaltake Smart BM3 850W ATX3.0 80+ Bronze", price: 99.00, tax: 0.19, barcode: 4713227539852));
// //!
//                                         boxProducts.put('key_${"be quiet! Straight Power 12 750W 80+ Platinum Mod."}',
//                                             ProductModel(category: "Netzteile", description: "be quiet! Straight Power 12 750W 80+ Platinum Mod.", price: 149.00, tax: 0.19, barcode: 4260052189412));
// //!
//                                         boxProducts.put('key_${"NZXT Kraken 240 RGB Black 1700/AM5"}',
//                                             ProductModel(category: "Kühler", description: "NZXT Kraken 240 RGB Black 1700/AM5", price: 169.00, tax: 0.19, barcode: 5056547202662));
// //!
//                                         boxProducts.put('key_${"NZXT F140 CORE RGB Series Fan Black"}',
//                                             ProductModel(category: "Kühler", description: "NZXT Kraken 240 RGB Black 1700/AM5", price: 19.90, tax: 0.19, barcode: 5056547202983));
// //!
//                                         boxProducts.put('key_${"CoolerMaster Kühler Hyper 212 Halo White"}',
//                                             ProductModel(category: "Kühler", description: "CoolerMaster Kühler Hyper 212 Halo White", price: 39.00, tax: 0.19, barcode: 4719512134092));
//                                       });
//                                     },
//                                     child: Text(
//                                       "data",
//                                       style: TextStyle(color: Color(0xFFFEF7FF), fontSize: 1),
//                                     ))
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
