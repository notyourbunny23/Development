import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Akademie Button Widget'),
        ),
        body: const Center(
          child: Column(
            children: [MyButton()],
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context);
            },
            child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                    child: Text("Button Text",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white)))),
          ),
        )
      ],
    );
  }
}

class MyButtonWithShadow extends StatefulWidget {
  const MyButtonWithShadow({super.key});

  @override
  State<MyButtonWithShadow> createState() => _MyButtonWithShadowState();
}

class _MyButtonWithShadowState extends State<MyButtonWithShadow> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue,
        ),
        child: const Center(
            child: Text("Button Text",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white))));
  }
}
