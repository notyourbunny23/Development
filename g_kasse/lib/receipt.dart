import 'package:flutter/material.dart';
import 'package:g_kasse/widgets.dart';

class Receipt extends StatefulWidget {
  Receipt({super.key});

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF7FF),
      drawer: const GDrawer(),
      appBar: const GKasseAppBar(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        children: [
          Expanded(
              child: Container(
            height: MediaQuery.of(context).size.height - 200,
            child: Placeholder(),
          )),
          Positioned(left: 0, right: 0, top: 0, bottom: 100, child: IconButton(onPressed: () {}, icon: const Icon(Icons.print)))
        ],
      ),
    );
  }
}
