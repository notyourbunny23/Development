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
          title: const Text('SizedBox Exercise'),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            color: Colors.blue,
            child: SizedBox(
              width: 100,
              height: 100,
              child: Center(
                  child: Text("Box 1", style: TextStyle(color: Colors.white))),
            ),
          ),
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              color: Colors.green,
              child: SizedBox(
                width: 140,
                height: 70,
                child: Center(
                    child:
                        Text("Box 2", style: TextStyle(color: Colors.white))),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
              color: Colors.red,
              child: SizedBox(
                width: 70,
                height: 140,
                child: Center(
                    child:
                        Text("Box 3", style: TextStyle(color: Colors.white))),
              ),
            ),
          ],
        )
      ],
    );
  }
}
