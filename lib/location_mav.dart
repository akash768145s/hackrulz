import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// url_launcher: ^6.2.5
void main() {
  runApp(LocationApp());
}

class LocationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Location Navigator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LocationScreen(),
    );
  }
}

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  void _openGoogleMaps() async {
    final pickup = Uri.encodeComponent(_pickupController.text);
    final destination = Uri.encodeComponent(_destinationController.text);
    final googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&origin=$pickup&destination=$destination';

    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch Google Maps')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App shell
      appBar: AppBar(
        title: Text('Google Maps Navigator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input for Pickup Location
            TextField(
              controller: _pickupController,
              decoration: InputDecoration(
                labelText: 'Pickup Location',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            // Input for Destination
            TextField(
              controller: _destinationController,
              decoration: InputDecoration(
                labelText: 'Destination Location',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // Get Directions Button
            ElevatedButton.icon(
              onPressed: _openGoogleMaps,
              icon: Icon(Icons.directions),
              label: Text('Get Directions'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
🌳 WIDGET TREE STRUCTURE + PURPOSE

LocationApp (StatelessWidget)
├── MaterialApp
│   ├── title → "Location Navigator"
│   ├── theme → Blue primary color
│   └── home → LocationScreen

LocationScreen (StatefulWidget)
└── Scaffold
    ├── AppBar → Shows "Google Maps Navigator" title
    └── body: Padding (EdgeInsets.all(16))
        └── Column
            ├── TextField (_pickupController)
            │   └── Input: "Pickup Location"
            ├── SizedBox → spacing
            ├── TextField (_destinationController)
            │   └── Input: "Destination Location"
            ├── SizedBox → spacing
            └── ElevatedButton.icon
                ├── onPressed → _openGoogleMaps()
                ├── Icon → Directions arrow
                └── Label: "Get Directions"

🧠 _openGoogleMaps():
- Encodes user input into a Google Maps URL
- Checks if the URL can be launched
- Launches directions using url_launcher
*/
