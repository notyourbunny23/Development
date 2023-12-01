import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final TextEditingController _inputController = TextEditingController();

  _setData(int input) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('Some ID', input);
      debugPrint("Saving data");
    } catch (e) {
      // Catching the exception and handling it
      print('Exception caught: $e');
    }
  }

  _readData() async {
    try {
      SharedPreferences appData = await SharedPreferences.getInstance();
      final int? id = appData.getInt('Some ID');
      debugPrint("Reading data");
      debugPrint("ID: $id");
    } catch (e) {
      // Catching the exception and handling it
      print('Exception caught: $e');
    }
  }

  _updateData(String id, int value) async {
    try {
      SharedPreferences appData = await SharedPreferences.getInstance();
      appData.setInt(id, value);
      debugPrint("Updating data");
    } catch (e) {
      // Catching the exception and handling it
      print('Exception caught: $e');
    }
  }

  _deleteData(String id) async {
    try {
      SharedPreferences appData = await SharedPreferences.getInstance();
      await appData.remove(id);
      debugPrint("Deleting data");
    } catch (e) {
      // Catching the exception and handling it
      print('Exception caught: $e');
    }
  }

  _saveData() async {
    try {
      String dataStringInput = _inputController.text;
      SharedPreferences appData = await SharedPreferences.getInstance();
      appData.setString('string', dataStringInput);
      debugPrint("Saving data");
    } catch (e) {
      // Catching the exception and handling it
      print('Exception caught: $e');
    }
  }

  _loadData() async {
    try {
      String dataStringOutput;
      SharedPreferences appData = await SharedPreferences.getInstance();
      dataStringOutput = appData.getString('string').toString();

      setState(() {
        _inputController.text = dataStringOutput;
      });

      debugPrint("Loading data");
    } catch (e) {
      // Catching the exception and handling it
      print('Exception caught: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("5.6.1 Datenbanken"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                padding: const EdgeInsets.only(bottom: 20),
                child: const Center(
                  child: Text(
                    "Aufgabe 2",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    _setData(007);
                  },
                  child: const Text("Set")),
              ElevatedButton(
                  onPressed: () {
                    _readData();
                  },
                  child: const Text("Read")),
              ElevatedButton(
                  onPressed: () {
                    _updateData("Some ID", 666);
                  },
                  child: const Text("Update")),
              ElevatedButton(
                  onPressed: () {
                    _deleteData("Some ID");
                  },
                  child: const Text("Delete")),
              Container(
                width: 300,
                padding: const EdgeInsets.only(top: 20),
                child: const Center(
                  child: Text(
                    "Aufgabe 3",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              Container(
                  width: 300,
                  child: TextField(
                    controller: _inputController,
                  )),
              ElevatedButton(
                  onPressed: () {
                    _saveData();
                  },
                  child: const Text("Text speichern")),
              ElevatedButton(
                  onPressed: () {
                    _loadData();
                  },
                  child: const Text("Text laden")),
            ],
          ),
        ),
      ),
    );
  }
}
