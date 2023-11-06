import 'package:flutter/material.dart';
import 'package:g_kasse/widgets.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF7FF),
      drawer: const GDrawer(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        children: [
          Image.asset("assets/logo_small.png"),
          const Text(
            "Settings\n",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const Placeholder(),
        ],
      ),
    );
  }
}
