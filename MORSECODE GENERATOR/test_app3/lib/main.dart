import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  MyFormState createState() => MyFormState();
}

class MyFormState extends State<MyForm> {
  final TextEditingController _textController = TextEditingController();
  String morseCodeResult = ''; // Добавьте переменную для хранения результата

  void _submitForm() {
    String enteredText = _textController.text;
    // Ваша обработка введенного текста

    Morsecode morsecode = Morsecode(enteredText);
    String result = morsecode.generateMorsecode();
// Обновите состояние, чтобы отобразить результат в секции Text
    setState(() {
      morseCodeResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(89, 182, 121, 100),
        title: const Text('Morsecode Generator'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                    labelText: 'Put your text hier',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 89, 182, 121)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 89, 182, 121))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 89, 182, 121)))),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 89, 182, 121)),
              onPressed: _submitForm,
              child: const Text('Generate'),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'MorseCode:',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),

            // Вывод результата в секции Text с добавлением padding
            Padding(
              padding: const EdgeInsets.all(
                  20.0), // Можете настроить отступы по вашему усмотрению
              child: Text(
                morseCodeResult,
                
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

class Morsecode {
  String inputString = "";

  // Konstruktor
  Morsecode(this.inputString);

  String generateMorsecode() {
    String stringOutput = "";
    List<String> letters = inputString
        .split(''); // Der Satz wird durch split('') in Zeichen zerlegt
    //print("$inputString \n");

    for (int i = 0; i < letters.length; i++) {
      String currentLetter =
          letters[i].toUpperCase(); // toUpperCase wegen switch Case Keys

      switch (currentLetter) {
        case "A":
          {
            stringOutput = "$stringOutput.- ";
          }
        case "B":
          {
            stringOutput = "$stringOutput-... ";
          }
        case "C":
          {
            stringOutput = "$stringOutput-.-. ";
          }
        case "D":
          {
            stringOutput = "$stringOutput-.. ";
          }
        case "E":
          {
            stringOutput = "$stringOutput. ";
          }
        case "F":
          {
            stringOutput = "$stringOutput..-. ";
          }
        case "G":
          {
            stringOutput = "$stringOutput--. ";
          }
        case "H":
          {
            stringOutput = "$stringOutput.... ";
          }
        case "I":
          {
            stringOutput = "$stringOutput.. ";
          }
        case "J":
          {
            stringOutput = "$stringOutput.--- ";
          }
        case "K":
          {
            stringOutput = "$stringOutput-.- ";
          }
        case "L":
          {
            stringOutput = "$stringOutput.-.. ";
          }
        case "M":
          {
            stringOutput = "$stringOutput-- ";
          }
        case "N":
          {
            stringOutput = "$stringOutput-. ";
          }
        case "O":
          {
            stringOutput = "$stringOutput--- ";
          }
        case "P":
          {
            stringOutput = "$stringOutput.--. ";
          }
        case "Q":
          {
            stringOutput = "$stringOutput--.- ";
          }
        case "R":
          {
            stringOutput = "$stringOutput.-. ";
          }
        case "S":
          {
            stringOutput = "$stringOutput... ";
          }
        case "T":
          {
            stringOutput = "$stringOutput- ";
          }
        case "U":
          {
            stringOutput = "$stringOutput..- ";
          }
        case "V":
          {
            stringOutput = "$stringOutput...- ";
          }
        case "W":
          {
            stringOutput = "$stringOutput.-- ";
          }
        case "X":
          {
            stringOutput = "$stringOutput-..- ";
          }
        case "Y":
          {
            stringOutput = "$stringOutput-.-- ";
          }
        case "Z":
          {
            stringOutput = "$stringOutput--.. ";
          }
        case "1":
          {
            stringOutput = "$stringOutput.---- ";
          }
        case "2":
          {
            stringOutput = "$stringOutput..--- ";
          }
        case "3":
          {
            stringOutput = "$stringOutput...-- ";
          }
        case "4":
          {
            stringOutput = "$stringOutput....- ";
          }
        case "5":
          {
            stringOutput = "$stringOutput..... ";
          }
        case "6":
          {
            stringOutput = "$stringOutput-.... ";
          }
        case "7":
          {
            stringOutput = "$stringOutput--... ";
          }
        case "8":
          {
            stringOutput = "$stringOutput---.. ";
          }
        case "9":
          {
            stringOutput = "$stringOutput----. ";
          }
        case "0":
          {
            stringOutput = "$stringOutput----- ";
          }

        case "!":
          {
            stringOutput = "$stringOutput-.-.-- ";
          }
        case "?":
          {
            stringOutput = "$stringOutput..--.. ";
          }
        case ".":
          {
            stringOutput = "$stringOutput.-.-.- ";
          }
        case ",":
          {
            stringOutput = "$stringOutput--..-- ";
          }
        case " ":
          {
            stringOutput = "$stringOutput/ ";
          }
        case "/":
          {
            stringOutput = "$stringOutput-..-. ";
          }
        case "-":
          {
            stringOutput = "$stringOutput-....- ";
          }
        case "+":
          {
            stringOutput = "$stringOutput.-.-. ";
          }
        case "=":
          {
            stringOutput = "$stringOutput-...- ";
          }
        case "_":
          {
            stringOutput = "$stringOutput..--.- ";
          }

          break;
      }
    }
    return stringOutput;
  }
}
