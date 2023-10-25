import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class GTextField extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 43,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
        margin: EdgeInsets.only(bottom: 10.0), // Отступ снизу

        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // Цвет границы
            width: 1.0, // Ширина границы
          ),
          borderRadius: BorderRadius.circular(2.0), // Закругленные углы
        ),
        child: TextField(
          style: TextStyle(
            fontSize: 13,
          ),
          controller: _controller,
          decoration: InputDecoration(
            border: InputBorder.none, // Убираем встроенную границу TextField
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
        backgroundColor: Color(0xFFFEF7FF),
        //backgroundColor: Colors.blue,
        body: ListView(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          children: [
            Image.asset("assets/logo_small.png"),
            GTextField(),
            GTextField(),
            GTextField(),
            GTextField(),
            GTextField(),
            //DropdownMenu(dropdownMenuEntries: dropdownMenuEntries)
          ],
        ),
      ),
    );
  }
}
