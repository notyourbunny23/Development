import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageTextApp(),
    );
  }
}

class ImageTextApp extends StatefulWidget {
  @override
  _ImageTextAppState createState() => _ImageTextAppState();
}

class _ImageTextAppState extends State<ImageTextApp> {
  bool showText1 = false;
  bool showText2 = false;
  bool showText3 = false;

  void toggleText1() {
    setState(() {
      showText1 = !showText1;
      // Hide the other text if it's currently shown
      showText2 = false;
      showText3 = false;
    });
  }

  void toggleText2() {
    setState(() {
      showText2 = !showText2;
      // Hide the other text if it's currently shown
      showText1 = false;
      showText3 = false;
    });
  }

  void toggleText3() {
    setState(() {
      showText3 = !showText3;
      // Hide the other text if it's currently shown
      showText1 = false;
      showText2 = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pizza Size App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: toggleText1,
                  child: Image.asset('assets/pizza20.png'),
                ),
                GestureDetector(
                  onTap: toggleText2,
                  child: Image.asset('assets/pizza30.png'),
                ),
                GestureDetector(
                  onTap: toggleText3,
                  child: Image.asset('assets/pizza40.png'),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
              width: 400,
            ),
            if (showText1)
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'bool isPizzaSizeBig == false',
                    style: TextStyle(fontSize: 20),
                  )),
            if (showText2)
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Kauf deine Pizza woanders!\nWir verkaufen sowas nicht. Und das nächste mal wähle einen richtigen Datentyp anstatt "bool" aus!',
                    style: TextStyle(fontSize: 20),
                  )),
            if (showText3)
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'bool isPizzaSizeBig == true',
                    style: TextStyle(fontSize: 20),
                  )),
          ],
        ),
      ),
    );
  }
}
