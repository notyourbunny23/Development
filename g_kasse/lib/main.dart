import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class GDrawer extends StatelessWidget {
  const GDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          DrawerHeader(
              child: Text(
            "Menü",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          )),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Einstellungen'),
            onTap: () {
              Navigator.pop(context); //TODO: Navigate to Settings
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              Navigator.pop(context); //TODO: Navigate to About Page
            },
          ),
        ],
      ),
    );
  }
}

class GButton extends StatelessWidget {
  const GButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFF79747E)),
          borderRadius: BorderRadius.circular(3.80),
        ),
      ),
      child: Icon(Icons.shopping_cart),
    );
  }
}

class GTextField extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  GTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 43,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
        margin: const EdgeInsets.only(bottom: 10.0), // Padding bottom

        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // border color
            width: 1.0, // border width
          ),
          borderRadius: BorderRadius.circular(2.0), // Round borders
        ),
        child: TextField(
          style: const TextStyle(
            fontSize: 13,
          ),
          controller: _controller,
          decoration: const InputDecoration(
            border: InputBorder.none, // No borderline
          ),
        ),
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // double screenWidth =
    //     MediaQuery.of(context).size.width; // Finding a Screen Width in DIP

    // double screenHeight =
    //     MediaQuery.of(context).size.height; // Finding a Screen height in DIP

    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFFEF7FF),
        //backgroundColor: Colors.blue,
        drawer: GDrawer(),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          children: [
            Image.asset("assets/logo_small.png"),
            GTextField(),
            GTextField(),
            GTextField(),
            GTextField(),
            GTextField(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GButton(),
              ],
            )
            //DropdownMenu(dropdownMenuEntries: dropdownMenuEntries)
          ],
        ),
      ),
    );
  }
}
