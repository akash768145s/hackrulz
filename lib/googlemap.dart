import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// url_launcher: ^6.2.5
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MapLauncherApp(),
  ));
}

class MapLauncherApp extends StatefulWidget {
  const MapLauncherApp({super.key});

  @override
  State<MapLauncherApp> createState() => _MapLauncherAppState();
}

class _MapLauncherAppState extends State<MapLauncherApp> {
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

  void _launchGoogleMapsRoute() async {
    final pickup = Uri.encodeComponent(pickupController.text.trim());
    final destination = Uri.encodeComponent(destinationController.text.trim());

    if (pickup.isEmpty || destination.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter both locations.")),
      );
      return;
    }

    final Uri uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&origin=$pickup&destination=$destination&travelmode=driving',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open Google Maps.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Route Finder")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: pickupController,
              decoration: const InputDecoration(
                labelText: "Pickup Location",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: destinationController,
              decoration: const InputDecoration(
                labelText: "Destination Location",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.directions),
              label: const Text("Show Route in Google Maps"),
              onPressed: _launchGoogleMapsRoute,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            )
          ],
        ),
      ),
    );
  }
}
// MaterialApp
// └── MapLauncherApp (StatefulWidget)
//     └── Scaffold
//         ├── AppBar → Text("Route Finder")
//         └── Padding
//             └── Column
//                 ├── TextField (pickupController)
//                 ├── TextField (destinationController)
//                 └── ElevatedButton.icon (Launch Google Maps)
