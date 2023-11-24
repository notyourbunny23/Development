import 'dart:io';

import 'package:flutter/material.dart';
import 'package:g_kasse/styles.dart';
import 'package:g_kasse/widgets.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF7FF),
      appBar: AppBar(
        iconTheme: IconThemeData.fallback(), // Leading Icon color
        backgroundColor: Color(0xFFFEF7FF), // Background color
        shadowColor: Theme.of(context).colorScheme.shadow, // Shadow Color
        elevation: 1, // Allways show Shadow
        centerTitle: true,
        title: Image.asset("assets/logo_small.png"), // Logo
        actions: [
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.person),
            onPressed: () {
              // ...
            },
          ),
        ],
      ),
      drawer: const GDrawer(),
      body: Container(
        color: Color(0xFFFEF7FF), // TODO: Background Color is different then AppBar Background Color
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Scrollbar(
            thumbVisibility: true,
            trackVisibility: false,
            thickness: 5,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: const Text(
                          "Einstellungen",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 40,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Header Text",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 100,
                        child: const TextField(
                          minLines: 2,
                          maxLines: 2,
                          //controller: _headerTextFieldController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Muster Firma, Muster Str. 100, 01234 Musterstadt",
                            suffixIcon: Icon(Icons.edit),
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Footer Text",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 100,
                        child: const TextField(
                          minLines: 2,
                          maxLines: 2,
                          //controller: _footerTextFieldController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Footer Text",
                            suffixIcon: Icon(Icons.edit),
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Fortlaufende Rechnungsnummer",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 80,
                        child: const TextField(
                          maxLines: 1,
                          //controller: _reNrTextFieldController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "xxxxxx",
                            suffixIcon: Icon(Icons.edit),
                          ),
                        ),
                      ),
                      Container(
                        child: Divider(),
                      ),
                      Container(
                        height: 40,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Rechung Logo",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFF79747E),
                            width: 0.8,
                          ),
                        ),
                        height: 100,
                        child: Image.asset(
                          "assets/images/no_logo_image.png",
                          width: 220,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10, right: 5),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFF79747E),
                                width: 0.8,
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {}, // TODO: Add funktion
                              icon: const Icon(Icons.image_outlined),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 5),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFF79747E),
                                width: 0.8,
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {}, // TODO: Add funktion
                              icon: const Icon(Icons.delete_outline_rounded),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            height: 40,
                            child: ElevatedButton(
                              style: gButton,
                              onPressed: () {
                                // TODO: Add funktion
                              },
                              child: const Text('Rechnung vorschau'),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 20,
                              bottom: 30,
                              right: 5,
                            ),
                            height: 40,
                            width: 150,
                            child: ElevatedButton(
                              style: gButton,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Abbrechen'),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 20,
                              bottom: 30,
                              left: 5,
                            ),
                            height: 40,
                            width: 150,
                            child: ElevatedButton(
                              style: gButton,
                              onPressed: () {
                                // TODO: Add save funktion
                                IconSnackBar.show(context: context, snackBarType: SnackBarType.save, duration: Duration(milliseconds: 700), label: 'Saved'); //Saved SnackBar Message
                                Future.delayed(const Duration(seconds: 1), () {
                                  Navigator.popUntil(context, ModalRoute.withName('/')); // Pop screen after SnackBar Message
                                });
                              },
                              child: const Text('Speichern'),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
