import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'package:g_kasse/addproduct.dart';
import 'package:g_kasse/products.dart';
import 'package:g_kasse/about.dart';
import 'package:g_kasse/settings.dart';
import 'package:g_kasse/profile.dart';
import 'package:g_kasse/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MainApp());
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]); // Hide the status bar
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      routes: {
        '/settings': (context) => const SettingsPage(),
        '/about': (context) => const About(),
        '/profile': (context) => const Profile(),
        '/addproduct': (context) => AddProduct(),
      },
      title: 'G-Kasse',
      home: Scaffold(
        appBar: const GKasseAppBar(),
        drawer: const GDrawer(),
        body: ProductDropdownWidget(productList: productList),
      ),
    );
  }
}
