import 'package:flutter/material.dart';
import 'package:g_kasse/styles.dart';
import 'package:g_kasse/widgets.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> saveStringToPreferences(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getStringFromPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  late TextEditingController _headerFieldController;
  late TextEditingController _footerFieldController;
  late TextEditingController _receiptNumberFieldController;

  @override
  void initState() {
    super.initState();
    _headerFieldController = TextEditingController();
    _footerFieldController = TextEditingController();
    _receiptNumberFieldController = TextEditingController();

    loadSettings();
  }

  Future<void> loadSettings() async {
    String? headerText = await getStringFromPreferences('headerText');
    String? footerText = await getStringFromPreferences('footerText');
    String? receiptNumberText = await getStringFromPreferences('receiptNumberText');

    _headerFieldController.text = headerText.toString() ?? '';
    _footerFieldController.text = footerText.toString() ?? '';
    _receiptNumberFieldController.text = receiptNumberText ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF7FF),
      appBar: const GKasseAppBar(),
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
                        child: const Text(
                          "Header Text",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 100,
                        child: TextField(
                          minLines: 2,
                          maxLines: 2,
                          controller: _headerFieldController,
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
                        child: const Text(
                          "Footer Text",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 100,
                        child: TextField(
                          minLines: 2,
                          maxLines: 2,
                          controller: _footerFieldController,
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
                        child: const Text(
                          "Fortlaufende Rechnungsnummer",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 80,
                        child: TextField(
                          maxLines: 1,
                          controller: _receiptNumberFieldController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "xxxxxx",
                            suffixIcon: Icon(Icons.edit),
                          ),
                        ),
                      ),
                      Container(
                        child: const Divider(),
                      ),
                      // Container(
                      //   height: 40,
                      //   alignment: Alignment.centerLeft,
                      //   child: const Text(
                      //     "Rechung Logo",
                      //     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10),
                      //     border: Border.all(
                      //       color: const Color(0xFF79747E),
                      //       width: 0.8,
                      //     ),
                      //   ),
                      //   height: 100,
                      //   child: Image.asset(
                      //     "assets/images/no_logo_image.png",
                      //     width: 220,
                      //   ),
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Container(
                      //       margin: const EdgeInsets.only(top: 10, right: 5),
                      //       height: 50,
                      //       width: 50,
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(10),
                      //         border: Border.all(
                      //           color: const Color(0xFF79747E),
                      //           width: 0.8,
                      //         ),
                      //       ),
                      //       child: IconButton(
                      //         onPressed: () {}, // TODO: Add funktion
                      //         icon: const Icon(Icons.image_outlined),
                      //       ),
                      //     ),
                      //     Container(
                      //       margin: const EdgeInsets.only(top: 10, left: 5),
                      //       height: 50,
                      //       width: 50,
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(10),
                      //         border: Border.all(
                      //           color: const Color(0xFF79747E),
                      //           width: 0.8,
                      //         ),
                      //       ),
                      //       child: IconButton(
                      //         onPressed: () {}, // TODO: Add funktion
                      //         icon: const Icon(Icons.delete_outline_rounded),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Container(
                      //       margin: const EdgeInsets.only(top: 30),
                      //       height: 40,
                      //       child: ElevatedButton(
                      //         style: gButton,
                      //         onPressed: () {
                      //           // TODO: Add funktion
                      //         },
                      //         child: const Text('Rechnung vorschau'),
                      //       ),
                      //     )
                      //   ],
                      // ),
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
                                Navigator.pushReplacementNamed(context, '/');
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
                              onPressed: () async {
                                // TODO: Add save funktion
                                await saveStringToPreferences('headerText', _headerFieldController.text.toString());
                                await saveStringToPreferences('footerText', _footerFieldController.text.toString());
                                await saveStringToPreferences('receiptNumberText', _receiptNumberFieldController.text.toString());

                                IconSnackBar.show(context: context, snackBarType: SnackBarType.save, duration: const Duration(milliseconds: 700), label: 'Gespeichert'); //Saved SnackBar Message
                                Future.delayed(const Duration(seconds: 1), () {
                                  Navigator.pushReplacementNamed(context, '/'); // Pop screen after SnackBar Message
                                });
                              },
                              child: const Text('Speichern'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  // TextButton(
                  //     onPressed: () async {
                  //       String? headerText = await getStringFromPreferences('headerText');
                  //       String? footerText = await getStringFromPreferences('footerText');
                  //       String? receiptNumberText = await getStringFromPreferences('receiptNumberText');
                  //       print(headerText);
                  //       print(footerText);
                  //       print(receiptNumberText);
                  //     },
                  //     child: Text("print settings"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
