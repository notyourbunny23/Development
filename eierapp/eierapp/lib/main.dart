import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]); // Disable changing Display Orientation
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.amber[400],
        body: const TimerApp(),
      ),
    );
  }
}

class TimerApp extends StatefulWidget {
  const TimerApp({super.key});

  @override
  _TimerAppState createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  int _seconds = 0;
  int _currentMinute = 0;
  String? _currentImage;
  String? _previousImage;
  final AudioPlayer audioPlayer = AudioPlayer();
  late Timer _timer;
  bool isFinished = false;

  Map<int, String> minuteToImage = {
    0: 'assets/0min.png',
    1: 'assets/1min.png',
    2: 'assets/2min.png',
    3: 'assets/3min.png',
    5: 'assets/5min.png',
    7: 'assets/7min.png',
    8: 'assets/8min.png',
    9: 'assets/9min.png',
    11: 'assets/11min.png',
    13: 'assets/13min.png',
    15: 'assets/15min.png',
  };

  bool _timerRunning = false;

  @override
  void initState() {
    super.initState();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (isFinished == true && _currentMinute == 15) {
          _resetTimer();
        }

        if (_timerRunning) {
          _seconds++;
          _currentMinute = _seconds ~/ 60;
          _previousImage = _currentImage;
          if (_currentMinute != 4 &&
              _currentMinute != 6 &&
              _currentMinute != 8 &&
              _currentMinute != 10 &&
              _currentMinute != 12 &&
              _currentMinute != 14) {
            _currentImage = minuteToImage[_currentMinute];
          }

          // 15 Min
          if (_currentMinute == 15) {
            _stopTimer();
            _playSound();
            isFinished == true;
          }
        }
      });
    });
  }

  void _toggleTimer() {
    setState(() {
      _timerRunning = !_timerRunning;
      if (_timerRunning) {
        _startTimer();
      } else {
        _timer.cancel();
      }
    });
  }

  void _stopTimer() {
    setState(() {
      _timerRunning = false;
      _timer.cancel();
    });
  }

  void _resetTimer() {
    setState(() {
      _seconds = 0;
      _currentMinute = 0;
      _currentImage = null;
      _previousImage = null;
      _timer.cancel();
      _timerRunning = false;
    });
  }

  String _formatTime() {
    int minutes = _seconds ~/ 60;
    int seconds = _seconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void _playSound() async {
    await audioPlayer.play(AssetSource("stop_timer.mp3"));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
              "Das Wasser zum Kochen bringen.\nDie Eier in das Wasser geben und\nauf Start drücken."),
          Container(
            height: 200,
            padding: const EdgeInsets.only(
                bottom: 20), // Здесь устанавливается отступ сверху
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: _currentImage != null
                  ? Image.asset(_currentImage!, key: Key(_currentImage!))
                  : const SizedBox(key: Key('empty_key')),
            ),
          ),
          Text(
            _formatTime(),
            style: const TextStyle(fontSize: 48),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 252, 151, 0))),
                onPressed: _toggleTimer,
                child: Text(_timerRunning ? 'Pause' : 'Start'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 252, 151, 0))),
                onPressed: _resetTimer,
                child: const Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
