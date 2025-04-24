import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

//  google_fonts: ^4.0.4
//  http: ^0.13.6
// https://home.openweathermap.org/api_keys

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.montserratTextTheme(),
        scaffoldBackgroundColor: Colors.blueGrey[50],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.indigo[700],
          foregroundColor: Colors.white,
        ),
      ),
      themeMode: ThemeMode.system,
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String location = "New York";
  double? temperature;
  String description = "Fetching weather...";
  String apiKey = "749a708472a15dd7cd61ee4f33fec74a";

  Future<void> fetchWeather() async {
    final response = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey&units=metric"),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        temperature = data['main']['temp'];
        description = data['weather'][0]['description'];
      });
    } else {
      setState(() {
        description = "Error fetching weather";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(" Weather App")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on, size: 30, color: Colors.deepPurple),
                  Text(
                    location,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 12),
                  temperature != null
                      ? Text(
                          "${temperature!.toStringAsFixed(1)}°C",
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        )
                      : CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text(
                    description,
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: fetchWeather,
                    icon: Icon(Icons.refresh),
                    label: Text("Refresh"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


/*
🌳 WIDGET TREE EXPLANATION FOR WeatherApp

WeatherApp (StatelessWidget)
├── MaterialApp
│   ├── debugShowCheckedModeBanner: false → Hides the "debug" banner on top
│   ├── theme → Light theme with Montserrat font and blueGrey background
│   ├── darkTheme → Dark theme with same font and darker backgrounds
│   ├── themeMode: ThemeMode.system → Adapts based on system light/dark mode
│   └── home: WeatherScreen() → Sets the first screen to be WeatherScreen

WeatherScreen (StatefulWidget)
└── Scaffold
    ├── AppBar
    │   └── Text("☁️ Weather App") → Top bar with the app title
    └── body: Center
        └── Padding (EdgeInsets.all(20)) → Adds uniform padding around content
            └── Card
                ├── elevation: 8 → Shadow effect for raised look
                ├── shape: RoundedRectangleBorder → Rounded corners
                └── Padding (EdgeInsets.all(24)) → Internal spacing for the card
                    └── Column (Main content in vertical layout)
                        ├── Icon(Icons.location_on) → Shows location pin icon
                        ├── Text(location) → Displays city name ("New York")
                        ├── SizedBox(height: 12) → Adds vertical spacing
                        ├── Text(temperatureText / CircularProgressIndicator)
                        │   └── Shows current temperature or a loading spinner
                        ├── SizedBox(height: 12) → Spacing
                        ├── Text(description) → Shows weather description like "clear sky"
                        ├── SizedBox(height: 24) → Spacing before button
                        └── ElevatedButton.icon
                            ├── onPressed: fetchWeather → Re-fetch weather data
                            ├── icon: Refresh icon
                            └── label: Text("Refresh") → Button text
*/


// Widget	Purpose
// MaterialApp	The root of your app. Controls themes and navigation.
// Scaffold	Provides structure with AppBar, body, etc.
// AppBar	Displays the title of the app at the top.
// Center	Centers its child widget in the screen.
// Padding	Adds spacing around widgets for neat layout.
// Card	A material-styled container with shadow and rounded corners.
// Column	Arranges widgets vertically.
// Icon	Shows a symbol/icon – here, a location pin.
// Text	Displays plain text like city, temperature, description.
// SizedBox	Provides vertical spacing between widgets.
// CircularProgressIndicator	Spinner shown while temperature is being loaded.
// ElevatedButton.icon	A raised button with an icon and text. Used to trigger refresh.