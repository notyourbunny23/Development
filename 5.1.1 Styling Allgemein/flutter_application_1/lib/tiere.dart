import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigationExample(),
    );
  }
}

TextStyle titleText = const TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
);

class CatInfo extends StatelessWidget {
  const CatInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Steckbrief Cat'),
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/cat.png",
              height: 370,
            ),
          ),
          Text("Name", style: titleText),
          const Text("NoGo Cat\n"),
          Text("Gewicht", style: titleText),
          const Text("3,5 kg\n"),
          Text("Lieblingsessen", style: titleText),
          const Text("Käse\n")
        ],
      )),
    );
  }
}

class FrogInfo extends StatelessWidget {
  const FrogInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Steckbrief Frog'),
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/frog.png"),
          ),
          Text("Name", style: titleText),
          const Text("Crazy Frog\n"),
          Text("Gewicht", style: titleText),
          const Text("2,5 kg\n"),
          Text("Lieblingsessen", style: titleText),
          const Text("Hühnersuppe\n")
        ],
      )),
    );
  }
}

class FoxInfo extends StatelessWidget {
  const FoxInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Steckbrief Fox'),
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/fox.png",
              height: 370,
            ),
          ),
          Text("Name", style: titleText),
          const Text("Fennec\n"),
          Text("Gewicht", style: titleText),
          const Text("1,8 kg\n"),
          Text("Lieblingsessen", style: titleText),
          const Text("Snickers, Mars, Twix\n")
        ],
      )),
    );
  }
}

// Beispielcode für das BottomNavigation Widget
class BottomNavigationExample extends StatefulWidget {
  const BottomNavigationExample({super.key});

  @override
  State<BottomNavigationExample> createState() =>
      _BottomNavigationExampleState();
}

class _BottomNavigationExampleState extends State<BottomNavigationExample> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    CatInfo(),
    FrogInfo(),
    FoxInfo(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.pets_rounded),
            label: 'Cat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets_rounded),
            label: 'Frog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets_rounded),
            label: 'Fox',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
