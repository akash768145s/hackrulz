import 'package:flutter/material.dart';

void main() {
  runApp(AQIApp());
}

class AQIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        textTheme: TextTheme(bodyLarge: TextStyle(fontFamily: 'Montserrat')),
      ),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: TextTheme(bodyLarge: TextStyle(fontFamily: 'Montserrat')),
      ),
      themeMode: ThemeMode.system,
      home: AQIScreen(),
    );
  }
}

class AQIScreen extends StatefulWidget {
  @override
  _AQIScreenState createState() => _AQIScreenState();
}

class _AQIScreenState extends State<AQIScreen> {
  int? aqi;
  String status = "Fetching data...";
  Color statusColor = Colors.grey;

  Future<void> fetchAQI() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      aqi = 125;
      _updateStatus();
    });
  }

  void _updateStatus() {
    if (aqi == null) return;
    if (aqi! <= 50) {
      status = "Good";
      statusColor = Colors.green;
    } else if (aqi! <= 100) {
      status = "Moderate";
      statusColor = Colors.yellow;
    } else if (aqi! <= 150) {
      status = "Unhealthy for Sensitive Groups";
      statusColor = Colors.orange;
    } else if (aqi! <= 200) {
      status = "Unhealthy";
      statusColor = Colors.red;
    } else {
      status = "Hazardous";
      statusColor = Colors.purple;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAQI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Air Quality Index (AQI)")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              aqi != null ? "AQI: $aqi" : "Loading...",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              status,
              style: TextStyle(fontSize: 20, color: statusColor),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchAQI,
              child: Text("Refresh"),
            ),
          ],
        ),
      ),
    );
  }
}



/*
🌳 WIDGET TREE STRUCTURE + PURPOSE

AQIApp (StatelessWidget)
├── MaterialApp
│   ├── theme → Light theme using Montserrat font
│   ├── darkTheme → Dark mode using same font
│   ├── themeMode: ThemeMode.system → Follows system light/dark setting
│   └── home → AQIScreen (main content)

AQIScreen (StatefulWidget)
└── Scaffold
    ├── AppBar
    │   └── Text("Air Quality Index (AQI)") → Title bar at top
    └── body: Center
        └── Column (Vertically stacked widgets)
            ├── Text → Shows AQI value or "Loading..."
            ├── SizedBox → Vertical space
            ├── Text → Displays AQI status (Good, Unhealthy, etc.)
            ├── SizedBox → More vertical space
            └── ElevatedButton → Triggers `fetchAQI()` to refresh dummy AQI

FUNCTIONS
- fetchAQI() → Simulates API call with dummy value (e.g., aqi = 125)
- _updateStatus() → Updates `status` and `statusColor` based on AQI level

AQI RANGES:
- 0–50: Good (green)
- 51–100: Moderate (yellow)
- 101–150: Unhealthy for Sensitive Groups (orange)
- 151–200: Unhealthy (red)
- 201+: Hazardous (purple)
*/
