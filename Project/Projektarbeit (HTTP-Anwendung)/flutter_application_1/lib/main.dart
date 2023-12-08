import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MainApp());
}

final textInputController = TextEditingController();

Future<User> fetchUser() async {
  final name = textInputController.text.trim(); // Trim to handle cases with only spaces

  if (name.isEmpty) {
    // Return a dummy user or handle the empty case gracefully
    return User(age: 0); // You can adjust this as needed
  }

  final response = await http.get(Uri.parse('https://api.agify.io/?name=$name'));

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load User');
  }
}

class User {
  int? id;
  String? name;
  int age;

  User({this.id, this.name, required this.age});

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return User(age: json['age'] as int);
    } catch (e) {
      throw FormatException('Failed to load User: $e');
    }
  }
}

class MainApp extends StatefulWidget {
  MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: textInputController,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print("Button pressed");
                  _handleButtonPress();
                },
                child: Text("Geschätzte Alter erfahren"),
              ),
              FutureBuilder<User>(
                future: futureUser,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Text('Geschätzte Alter: ${snapshot.data?.age}');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleButtonPress() {
    setState(() {
      futureUser = fetchUser();
    });
  }
}
