import 'package:flutter/material.dart';
import 'package:g_kasse/about.dart';
import 'package:g_kasse/settings.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 64,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: Color(0xFFFEF7FF), boxShadow: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ]),
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              IconButton(
                iconSize: 40,
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // Open GDrawer
                },
              ),
              Image.asset("assets/logo_small.png"), // Logo
              IconButton(
                iconSize: 40,
                icon: const Icon(Icons.person),
                onPressed: () {
                  // ...
                },
              ),
            ],
          ),
        )

        // Image.asset("assets/logo_small.png"), // Logo
        );
  }
}

class GDrawer extends StatelessWidget {
  const GDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const SizedBox(
            height: 100,
            child: DrawerHeader(
                child: Text(
              "Menü",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            )),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Einstellungen'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Settings()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const About()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProductInfoFields extends StatefulWidget {
  const ProductInfoFields({super.key});

  @override
  _ProductInfoFieldsState createState() => _ProductInfoFieldsState();
}

class _ProductInfoFieldsState extends State<ProductInfoFields> {
  TextEditingController _textFieldController1 = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();
  TextEditingController _textFieldController3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('First Line'),
          TextField(
            controller: _textFieldController1,
            decoration: const InputDecoration(labelText: 'Second Line'),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textFieldController2,
                  decoration: const InputDecoration(labelText: 'Third Line - Part 1'),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: TextField(
                  controller: _textFieldController3,
                  decoration: const InputDecoration(labelText: 'Third Line - Part 2'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Finding a Screen Width in DIP

    return Column(
      children: [
        Column(
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: screenWidth,
                  height: 33,
                  //color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Ausgewählte Produkt:"),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: screenWidth,
                  height: 100,
                  //color: Colors.red,
                  child: Center(
                    child: Container(
                      height: 70,
                      width: screenWidth - 10,
                      padding: EdgeInsets.only(left: 15, top: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.8),
                        border: Border.all(
                          color: Color(0xFF79747E),
                          width: 0.8,
                        ),
                      ),
                      child: const Text(
                        'Selected Product Description', // TODO: Add $productDescription
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: screenWidth / 3 - 5,
                  height: 30,
                  //color: Colors.purple,
                  child: Text("Einzelstück Preis:"),
                ),
                Container(
                  width: screenWidth / 3 - 5,
                  height: 30,
                  //color: Colors.amber,
                  child: Text("MwSt:"),
                ),
                Container(
                  width: screenWidth / 3 - 5,
                  height: 30,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: screenWidth / 3 - 5,
                  height: 60,
                  //color: Colors.blue,
                  child: Row(
                    children: [
                      Container(
                        width: screenWidth / 3 - 5,
                        height: 60,
                        child: Center(
                          child: Container(
                            height: 50,
                            width: screenWidth - 10,
                            padding: EdgeInsets.only(left: 15, top: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0.8),
                              border: Border.all(
                                color: Color(0xFF79747E),
                                width: 0.8,
                              ),
                            ),
                            child: const Text(
                              'Price', // TODO: Add $productPrice
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: screenWidth / 3 - 5,
                  height: 60,
                  //color: Colors.yellow,
                  child: Row(
                    children: [
                      Container(
                        width: screenWidth / 3 - 5,
                        height: 60,
                        child: Center(
                          child: Container(
                            height: 50,
                            width: screenWidth - 10,
                            padding: EdgeInsets.only(left: 15, top: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0.8),
                              border: Border.all(
                                color: Color(0xFF79747E),
                                width: 0.8,
                              ),
                            ),
                            child: const Text(
                              'MwSt', // TODO: Add $productTax
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: screenWidth / 3 - 5,
                  height: 60,
                  //color: Colors.red,
                  child: Placeholder(
                    // Product Image
                    fallbackHeight: 80,
                    fallbackWidth: 80,
                    strokeWidth: 0.5,
                  ),
                ),
              ],
            ),
            // Row(
            //   children: [
            //     Container(width: 50, height: 50, color: Colors.red), // Первая ячейка
            //     Container(width: 50, height: 50, color: Colors.green), // Вторая ячейка
            //     Container(width: 50, height: 50, color: Colors.blue), // Третья ячейка
            //     Container(width: 50, height: 50, color: Colors.yellow), // Четвертая ячейка
            //     Container(width: 50, height: 100, color: Colors.orange), // Пятая ячейка с объединением двух строк
            //   ],
            // ),
            // Row(
            //   children: [
            //     Container(width: 50, height: 50, color: Colors.purple), // Первая ячейка во втором ряду
            //     Container(width: 50, height: 50, color: Colors.cyan), // Вторая ячейка во втором ряду
            //     Container(width: 50, height: 50, color: Colors.pink), // Третья ячейка во втором ряду
            //     Container(width: 50, height: 50, color: Colors.brown), // Четвертая ячейка во втором ряду
            //   ],
            // ),
          ],
        ),
      ],
    );
  }
}
