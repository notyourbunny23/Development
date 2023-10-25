import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Создать поток геолокатора
  final geolocator = GeolocatorPlatform.instance;

  // Запрашивать разрешение на доступ к местоположению
  geolocator.checkPermission().then((permission) {
    if (permission == LocationPermission.denied) {
      geolocator.requestPermission();
    }
  });

  // Получить текущие координаты устройства
  geolocator.getCurrentPosition().then((position) {
    // Показать координаты устройства на консоли
    print(
        "Координаты устройства: ${position?.latitude}, ${position?.longitude}");

    // Создать виджет для отображения координат
    return Scaffold(
      appBar: AppBar(
        title: Text("Координаты устройства"),
      ),
      body: StreamBuilder<Position>(
        stream: geolocator.getPositionStream(),
        builder: (context, snapshot) {
          Center(
            child: Text(
              "Привет!",
              style: TextStyle(fontSize: 20),
            ),
          );

          if (snapshot.hasData) {
            return Center(
              child: Column(
                children: [
                  Text(
                    "Широта: ${snapshot.data?.latitude ?? "Неизвестно"}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Долгота: ${snapshot.data?.longitude ?? "Неизвестно"}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Привет!",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  });

  // Отслеживать изменения координат устройства
  geolocator.getPositionStream().listen((position) {
    // Показать координаты устройства на консоли
    print(
        "Координаты устройства: ${position?.latitude}, ${position?.longitude}");
  });
}
