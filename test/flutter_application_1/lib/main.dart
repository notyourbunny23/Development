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
        body: Center(
            child: Container(
          width: 348.25,
          height: 42.21,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 348.25,
                  height: 42.21,
                  decoration: BoxDecoration(
                    color: Color(0x26283752),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(33.77),
                      bottomRight: Radius.circular(33.77),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 17,
                top: 10,
                child: SizedBox(
                  width: 310,
                  child: Text(
                    'this is a text',
                    style: TextStyle(
                      color: Color(0xFF283752),
                      fontSize: 19,
                      fontFamily: 'Helvetica Neue',
                      fontWeight: FontWeight.w300,
                      height: 0,
                      letterSpacing: -0.29,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
