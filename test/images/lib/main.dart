import 'package:flutter/material.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  runApp(MainApp());

  var status = await Permission.storage.request();
  print(status);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  const Text(
                    "5.3.1 Images - Aufgabe 1",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Image.asset(
                    'assets/image.png',
                    height: 200,
                  ),
                  const Text(
                    "5.3.1 Images - Aufgabe 2\n",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Image.network(
                    'https://steamuserimages-a.akamaihd.net/ugc/80340220917898104/4DCE28CA3725160380E2D9D048F04538D8C0D758/?imw=5000&imh=5000&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=false',
                    height: 150,
                  ),
                  const Text(
                    "5.3.1 Images - Aufgabe 4\n",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  CachedNetworkImage(
                      imageUrl: "https://www.marssociety.org/wp-content/uploads/2020/07/dragoncrew.8k.jpg", placeholder: (context, url) => Image.asset("assets/loading.gif", height: 200, width: 200)),
                  const Text("\n5.3.1 Images - Image.file (with permission request)\n", style: TextStyle(color: Colors.white, fontSize: 16)),
                  Image.file(File('/storage/emulated/0/Download/file_image.png')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
