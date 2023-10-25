import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Column and Row Example",
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 238, 238, 238),
        appBar: AppBar(
          title: const Text('Column and Row Example'),
        ),
        body: const MyContent(),
      ),
    );
  }
}

class MyContent extends StatelessWidget {
  const MyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("A"), Text("B")],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("C"), Text("D")],
            )
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("E")],
            )
          ],
        ),
      ],
    );
  }
}
