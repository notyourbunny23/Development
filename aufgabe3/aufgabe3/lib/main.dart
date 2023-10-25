import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());

//  WeatherData weatherData =
//      WeatherData(city: "Berlin", temperature: 20, weatherConditions: "Sonnig");
}

class WeatherData {
  String city = "";
  double temperature = 0;
  String weatherConditions = "";

  WeatherData(
      {required this.city,
      required this.temperature,
      required this.weatherConditions});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherApp(
          weatherData: WeatherData(
              city: "Berlin", temperature: 20, weatherConditions: "Sonnig")),
    );
  }
}

class WeatherApp extends StatelessWidget {
  final WeatherData weatherData;

  const WeatherApp({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 239, 124, 38),
          centerTitle: true,
          titleTextStyle: const TextStyle(color: Colors.black),
          title: const Text("Weather App"),
        ),
        body: Container(
          width: 500,
          height: 500,
          child: Center(
              child: Column(children: [
            const Text(
              "\nWillkommen zur Wetter-App!\n",
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 255), fontSize: 24),
            ),
            const Image(
              image: AssetImage("assets/icon_sunny.png"),
              height: 70,
              width: 70,
            ),
            Text(
              "\nAktuelles Wetter in ${weatherData.city}: ${weatherData.temperature}° Wetter: ${weatherData.weatherConditions}",
              style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 255), fontSize: 16),
            ),
            const Align(
              alignment: Alignment.center,
              child: Image(
                image: AssetImage("assets/image_bottom.png"),
                height: 120,
              ),
            ),
          ])),
        ));
  }
}
