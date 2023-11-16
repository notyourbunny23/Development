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
              GestureDetector(child: Image.asset("assets/logo_small.png")), // Logo
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
