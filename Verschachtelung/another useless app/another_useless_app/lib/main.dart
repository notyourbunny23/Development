import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:permission_handler/permission_handler.dart';

String resultPosition = "";

void main() {
  // Инициализация Binding
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());
}

class DisplayInfo extends StatefulWidget {
  const DisplayInfo({super.key});

  @override
  State<DisplayInfo> createState() => _DisplayInfoState();
}

class _DisplayInfoState extends State<DisplayInfo> {
  //String resultPosition = "";

  @override
  void initState() {
    super.initState();

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

      resultPosition = "${position?.latitude}, ${position?.longitude}";
    });

    // Отслеживать изменения координат устройства
    geolocator.getPositionStream().listen((position) {
      // Показать координаты устройства на консоли
      print(
          "Координаты устройства: ${position?.latitude}, ${position?.longitude}");
    });
  }

  @override
  Widget build(BuildContext context) {
    //  Geolocator.getCurrentPosition();
    double screenWidth =
        MediaQuery.of(context).size.width; // Finding a Screen Width in DIP

    double screenHeight =
        MediaQuery.of(context).size.height; // Finding a Screen height in DIP

    String screenHeightInDip = screenHeight.toStringAsFixed(0);
    String screenWidthInDip = screenWidth.toStringAsFixed(0);

    final screenPixelRatio = MediaQuery.of(context).devicePixelRatio;

    double screenHightInPx = screenHeight * screenPixelRatio;
    double screenWidthInPx = screenWidth * screenPixelRatio;
    String screenHightInPxString = screenHightInPx.toStringAsFixed(0);
    String screenWidthInPxString = screenWidthInPx.toStringAsFixed(0);

    final orientation = MediaQuery.of(context).orientation;

    double imageSize = orientation == Orientation.portrait
        ? 150.0
        : 70.0; // Resize image on Orientation change

    return MaterialApp(
      title: "Display Information",
      home: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              height: screenHeight,
              width: screenWidth,
              color: const Color.fromARGB(255, 11, 136, 52),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, top: 100.0, right: 20.0, bottom: 100.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/resolution.png',
                      width: imageSize,
                      height: imageSize,
                    ),
                    Text(
                      textAlign: TextAlign.left,
                      "Screen height: $screenHeightInDip DIP",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    Text(
                      "Screen width: $screenWidthInDip DIP",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    Text(
                      "\nDevice Pixel Ratio: $screenPixelRatio",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    Text(
                      "\nScreen Resolution: $screenHightInPxString x $screenWidthInPxString px",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    Text(
                      '\nCurrent Orientation: ${orientation == Orientation.portrait ? 'Portrait' : 'Landscape'}',
                      style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    Text(
                      "Current Location: $resultPosition",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Geolocator.getCurrentPosition();
    return const MaterialApp(
      home: Scaffold(
        body: DisplayInfo(),
      ),
    );
  }
}
