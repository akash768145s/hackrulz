import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DummyWeatherApp(),
  ));
}

class DummyWeatherApp extends StatefulWidget {
  @override
  State<DummyWeatherApp> createState() => _DummyWeatherAppState();
}

class _DummyWeatherAppState extends State<DummyWeatherApp> {
  final TextEditingController cityController = TextEditingController();
  String city = "";
  String temperature = "";
  String description = "";
  String icon = "";
  bool loading = false;

  final Map<String, Map<String, String>> dummyWeatherData = {
    'chennai': {'temp': '32°C', 'desc': 'Sunny', 'icon': '01d'},
    'london': {'temp': '12°C', 'desc': 'Cloudy', 'icon': '03d'},
    'new york': {'temp': '18°C', 'desc': 'Rainy', 'icon': '09d'},
    'tokyo': {'temp': '22°C', 'desc': 'Clear sky', 'icon': '01n'},
  };

  void getDummyWeather(String cityInput) {
    setState(() {
      loading = true;
      temperature = "";
      description = "";
      icon = "";
    });

    Future.delayed(const Duration(seconds: 1), () {
      final key = cityInput.toLowerCase().trim();
      final data = dummyWeatherData[key];

      setState(() {
        if (data != null) {
          temperature = data['temp']!;
          description = data['desc']!;
          icon = data['icon']!;
        } else {
          temperature = "";
          description = "City not found in dummy data!";
          icon = "";
        }
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dummy Weather App"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                hintText: "Enter city (e.g. Chennai, London)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => getDummyWeather(cityController.text),
              child: const Text("Get Weather"),
            ),
            const SizedBox(height: 20),
            if (loading) const CircularProgressIndicator(),
            const SizedBox(height: 20),
            if (temperature.isNotEmpty)
              Text(temperature, style: const TextStyle(fontSize: 32)),
            if (description.isNotEmpty)
              Text(description, style: const TextStyle(fontSize: 18)),
            if (icon.isNotEmpty)
              Image.network(
                "https://openweathermap.org/img/wn/$icon@2x.png",
                height: 100,
              ),
          ],
        ),
      ),
    );
  }
}



// MaterialApp
// └── DummyWeatherApp (StatefulWidget)
//     └── Scaffold
//         ├── AppBar
//         │   └── Text ("Dummy Weather App")
//         └── Padding
//             └── Column
//                 ├── TextField (Enter city)
//                 ├── SizedBox
//                 ├── ElevatedButton ("Get Weather")
//                 ├── SizedBox
//                 ├── if (loading)
//                 │   └── CircularProgressIndicator
//                 ├── SizedBox
//                 ├── if (temperature.isNotEmpty)
//                 │   └── Text (temperature)
//                 ├── if (description.isNotEmpty)
//                 │   └── Text (weather description)
//                 └── if (icon.isNotEmpty)
//                     └── Image.network (weather icon)
