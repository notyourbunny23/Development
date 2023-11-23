import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_kasse/about.dart';
import 'package:g_kasse/settings.dart';
import 'package:g_kasse/profile.dart';
import 'package:g_kasse/widgets.dart';

void main() {
  runApp(MainApp());
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]); // Hide the status bar
}

class Products {
  final String category;
  final String name;
  final int barcode;
  final double price;
  final double tax;

  Products(this.category, this.name, this.barcode, this.price, this.tax);
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  List<Products> productList = [
    Products("Prozessoren Intel", "Intel Core i9 13900KS LGA1700 32MB Cache 3.0GHz retail", 123456789, 799.99, 0.19),
    Products("Prozessoren Intel", "Intel Core i5 13600KF LGA1700 24MB Cache 3.5GHz retail", 223456789, 329.99, 0.19),
    Products("Prozessoren Intel", "Intel Core i3 12100F LGA1700 12MB Cache 3.3GHz retail", 323456789, 109.99, 0.19),
    Products("Prozessoren AMD", "AMD Ryzen 7 7800X3D, 4.2 GHz, 8 Kerne, 16 Threads", 313456789, 399.99, 0.19),
    Products("Prozessoren AMD", "AMD Ryzen 9 7950X3D 5,7GHz AM5 144MB Cache", 323456789, 691.99, 0.19),
    Products("Prozessoren AMD", "AMD Ryzen 9 7900X3D 5,6GHz AM5 140MB Cache", 333456789, 549.99, 0.19),
    Products("Mainboards Intel", "MSI Z790 Gaming Plus Wifi (Z790, S1700, ATX, DDR5", 321456789, 239.99, 0.19),
    Products("Mainboards Intel", "MSI PRO B760-P DDR4 II (B760, S1700, ATX, DDR4)", 322456789, 139.99, 0.19),
    Products("Mainboards Intel", "Mainboard ASUS TUF GAMING B760-PLUS WIFI (Intel, 1700, DDR5, ATX)", 324456789, 199.99, 0.19),
    Products("Arbeitsspeicher", "DDR5 32GB PC 6000 CL40 G.Skill (2x16GB) 32-GX2-FX5 FLARE A", 4713294230539, 134.00, 0.19),
    Products("Arbeitsspeicher", "DDR4 16GB PC 4000 CL17 G.Skill KIT (2x8GB) 16GVKB Ripjaws", 4713294226150, 85.00, 0.19),
    Products("Arbeitsspeicher", "DDR4 16GB PC 2400 CL16 KIT (4x4GB) Crucial Ballistix Sp", 649528769800, 125.00, 0.19),
    Products("Festplatten", "SSD 500GB ADATA M.2 PCI-E NVMe Gen3 Legend 750 retail", 4711085935915, 29.00, 0.19),
    Products("Festplatten", "SSD 1TB Samsung M.2 PCI-E NVMe Gen4 980 PRO Heatsink", 8806092837683, 179.00, 0.19),
    Products("Festplatten", "SSD 1TB Samsung M.2 PCI-E NVMe 980 Basic retail", 8806090572210, 74.90, 0.19),
    Products("Grafikkarten", "MSI RTX4090 GAMING X TRIO 24G", 4711377019217, 2049.00, 0.19),
    Products("Grafikkarten", "ASUS TUF-RTX4070-O12G-GAMING", 4711387128176, 699.00, 0.19),
    Products("Grafikkarten", "Sapphire Radeon RX7900XTX Gaming OC Nitro+ 24GB GDDR6 2xHDMI", 4895106293328, 1199.00, 0.19),
    Products("PC-Gehäuse", "NZXT H5 Flow Matte Black Mid Tower Case", 5056547202334, 83.00, 0.19),
    Products("PC-Gehäuse", "be quiet! Pure Base 500 FX Black (ARGB)", 4260052189054, 119.00, 0.19),
    Products("PC-Gehäuse", "MSI Midi MPG VELOX 100R (B/Tempered Glas/System Fan)", 4719072829315, 129.00, 0.19),
    Products("Netzteile", "Seasonic Netzteil 1200W VERTEX-PX-1200 ATX30 Modular (Gold)", 4711173877769, 269.00, 0.19),
    Products("Netzteile", "Thermaltake Smart BM3 850W ATX3.0 80+ Bronze", 4713227539852, 99.00, 0.19),
    Products("Netzteile", "be quiet! Straight Power 12 750W 80+ Platinum Mod.", 4260052189412, 149.00, 0.19),
    Products("Kühler", "NZXT Kraken 240 RGB Black 1700/AM5", 5056547202662, 169.00, 0.19),
    Products("Kühler", "NZXT F140 CORE RGB Series Fan Black", 5056547202983, 19.90, 0.19),
    Products("Kühler", "CoolerMaster Kühler Hyper 212 Halo White", 4719512134092, 39.00, 0.19),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/settings': (context) => const Settings(),
          '/about': (context) => const About(),
          '/profile': (context) => const Profile(),
        },
        title: 'G-Kasse',
        home: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData.fallback(), // Leading Icon color
              backgroundColor: Color(0xFFFEF7FF), // Background color
              shadowColor: Theme.of(context).colorScheme.shadow, // Shadow Color
              elevation: 1, // Allways show Shadow
              centerTitle: true,
              title: Image.asset("assets/logo_small.png"), // Logo
              actions: [
                IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    //
                    print(MediaQuery.of(context).size.height);
                  },
                ),
              ],
            ),
            drawer: const GDrawer(),
            body: ProductDropdownWidget(productList: productList)));
  }
}
