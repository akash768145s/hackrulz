import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  String _weather = "Enter a city to get the weather";
  String _temperature = "";
  String _icon = "";
  bool _isLoading = false;

  Future<void> fetchWeather(String city) async {
    if (city.isEmpty) return;

    setState(() {
      _isLoading = true;
      _weather = "Fetching weather...";
      _temperature = "";
      _icon = "";
    });

    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=211922dc4575ca7aa489da81548a4965&units=metric'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _temperature = "${data['main']['temp']}°C";
        _weather = data['weather'][0]['description'].toUpperCase();
        _icon = data['weather'][0]['icon'];
      });
    } else {
      setState(() {
        _weather = "City not found. Try again.";
        _temperature = "";
        _icon = "";
      });
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Weather App", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: 'Enter City',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => fetchWeather(_cityController.text),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.deepPurpleAccent,
                  ),
                  child: const Text("Get Weather", style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 30),
                _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : _weatherCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _weatherCard() {
    return _temperature.isNotEmpty
        ? Card(
            color: Colors.white.withOpacity(0.9),
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  if (_icon.isNotEmpty)
                    Image.network(
                      "https://openweathermap.org/img/wn/$_icon@2x.png",
                      height: 80,
                    ),
                  Text(_temperature, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(_weather, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
