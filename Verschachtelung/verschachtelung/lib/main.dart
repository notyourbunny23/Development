import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: Scaffold(
    body: Counter(),
    appBar: AppBar(title: Text("Nesting")),
  )));
}

class Counter extends StatefulWidget {
  Counter({super.key});
  @override
  CounterState createState() => CounterState();
}

class CounterState extends State<Counter> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Text("Value: $value", style: TextStyle(fontSize: 22)),
        onPressed: () {
          setState(() {
            value++;
          });
        });
  }
}
