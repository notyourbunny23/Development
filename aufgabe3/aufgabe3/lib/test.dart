import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.blue,
                child: Center(
                    child: const Text.rich(TextSpan(
                  children: <InlineSpan>[
                    TextSpan(text: 'Flutter is'),
                    WidgetSpan(
                        child: SizedBox(
                      width: 120,
                      height: 50,
                      child: Card(child: Center(child: Text('Hello World!'))),
                    )),
                    TextSpan(text: 'the best!'),
                  ],
                ))),
              ),
            ),
            Container(
              color: Colors.yellow,
              height: 300, // Высота нижней части
              alignment: Alignment.center,
              child: Image.asset(
                  'assets/your_image.png'), // Путь к вашему изображению
            ),
          ],
        ),
      ),
    );
  }
}
