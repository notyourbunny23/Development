import 'package:flutter/material.dart';
import 'package:categorized_dropdown/categorized_dropdown.dart';
import 'dart:convert';
import 'widgets.dart';
import 'package:g_kasse/about.dart';
import 'package:g_kasse/settings.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MainApp> {
  final List<CategorizedDropdownItem<String>>? items = [
    CategorizedDropdownItem(text: 'Exhaust', subItems: [
      SubCategorizedDropdownItem(text: 'Pipes', value: 'pipes'),
      SubCategorizedDropdownItem(text: 'Mufflers', value: 'mufflers'),
      SubCategorizedDropdownItem(text: 'Gaskets', value: 'gaskets'),
    ]),
    CategorizedDropdownItem(text: 'Engine Parts', subItems: [
      SubCategorizedDropdownItem(text: 'Engine mounts', value: 'engine-mounts'),
      SubCategorizedDropdownItem(text: 'Oil Filters', value: 'oil-filters'),
    ]),
    CategorizedDropdownItem(text: 'Fuel & Emission', subItems: [
      SubCategorizedDropdownItem(
          text: 'Fuel Injection', value: 'fuel-incection'),
      SubCategorizedDropdownItem(text: '02 Sensor', value: 'o2-sensor'),
    ]),
    CategorizedDropdownItem(text: 'Other', value: 'Other'),
  ];
  String? value;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        //'/': (context) => const ,
        '/settings': (context) => const Settings(),
        '/about': (context) => const About(),
      },
      title: 'G-Kasse',
      home: Scaffold(
        drawer: const GDrawer(),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Image.asset("assets/logo_small.png"),
            CategorizedDropdown(
              items: items,
              value: value,
              hint: const Text('Select auto parts'),
              onChanged: (v) {
                setState(() {
                  value = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
