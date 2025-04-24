import 'package:flutter/material.dart';

void main() {
  runApp(UnitConverterApp());
}

class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UnitConverterScreen(),
    );
  }
}

class UnitConverterScreen extends StatefulWidget {
  @override
  _UnitConverterScreenState createState() => _UnitConverterScreenState();
}

class _UnitConverterScreenState extends State<UnitConverterScreen> {
  final TextEditingController valueController = TextEditingController();

  String category = 'Length'; // Category toggle
  String inputUnit = 'Meters';
  String outputUnit = 'Kilometers';
  double? convertedValue;

  final Map<String, double> lengthConversion = {
    'Meters': 1.0,
    'Kilometers': 0.001,
    'Centimeters': 100.0,
    'Millimeters': 1000.0,
  };

  final Map<String, double> weightConversion = {
    'Kilograms': 1.0,
    'Grams': 1000.0,
    'Pounds': 2.20462,
    'Ounces': 35.274,
  };

  void _convert() {
    double? inputValue = double.tryParse(valueController.text);
    if (inputValue == null) return;

    setState(() {
      final currentMap =
          category == 'Length' ? lengthConversion : weightConversion;

      convertedValue =
          inputValue * (currentMap[outputUnit]! / currentMap[inputUnit]!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final unitList = category == 'Length'
        ? lengthConversion.keys.toList()
        : weightConversion.keys.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Unit Converter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: category,
              onChanged: (value) {
                setState(() {
                  category = value!;
                  // Reset units to default on category switch
                  inputUnit = category == 'Length' ? 'Meters' : 'Kilograms';
                  outputUnit = category == 'Length' ? 'Kilometers' : 'Grams';
                  convertedValue = null;
                });
              },
              items: ['Length', 'Weight'].map((c) {
                return DropdownMenuItem(value: c, child: Text(c));
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: valueController,
              decoration: const InputDecoration(labelText: 'Enter Value'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: inputUnit,
                  onChanged: (newValue) {
                    setState(() {
                      inputUnit = newValue!;
                    });
                  },
                  items: unitList.map((unit) {
                    return DropdownMenuItem(value: unit, child: Text(unit));
                  }).toList(),
                ),
                const Icon(Icons.arrow_forward),
                DropdownButton<String>(
                  value: outputUnit,
                  onChanged: (newValue) {
                    setState(() {
                      outputUnit = newValue!;
                    });
                  },
                  items: unitList.map((unit) {
                    return DropdownMenuItem(value: unit, child: Text(unit));
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            if (convertedValue != null)
              Text(
                'Converted Value: ${convertedValue!.toStringAsFixed(2)} $outputUnit',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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

UnitConverterApp (StatelessWidget)
├── MaterialApp
│   ├── title: 'Unit Converter'
│   ├── theme → Blue primary swatch
│   └── home → UnitConverterScreen (StatefulWidget)

UnitConverterScreen (StatefulWidget)
└── Scaffold
    ├── AppBar
    │   └── Text('Unit Converter') → Displays the app title
    └── body: Padding (EdgeInsets.all(16.0))
        └── Column (Main vertical layout)
            ├── TextField (valueController)
            │   └── Input field for user to enter value to convert
            ├── SizedBox(height: 10)
            ├── Row (for unit selection)
            │   ├── DropdownButton<String> (inputUnit)
            │   │   └── Selects the unit to convert from
            │   ├── Icon(Icons.arrow_forward) → Visual arrow icon
            │   └── DropdownButton<String> (outputUnit)
            │       └── Selects the unit to convert to
            ├── SizedBox(height: 20)
            ├── ElevatedButton → "Convert"
            │   └── onPressed → Runs _convert() method to calculate result
            ├── SizedBox(height: 20)
            └── if (convertedValue != null)
                └── Text → Displays formatted result of conversion

📦 STATE:
- `valueController`: handles numeric input
- `inputUnit`, `outputUnit`: selected unit strings
- `convertedValue`: result of unit conversion

🧠 CONVERSION LOGIC:
- Two separate conversion maps: `lengthConversion`, `weightConversion`
- _convert():
  ├── Parses input from text field
  ├── Checks if selected units are from same category (length/weight)
  ├── Converts using formula:
      inputValue * (outputUnitRatio / inputUnitRatio)

🔁 USER FLOW:
1. User types a value into the input field
2. Selects "from" and "to" units using dropdowns
3. Taps "Convert"
4. App calculates and displays the result below the button

🎯 UI DESIGN GOALS:
- Simple unit conversion between common metric and imperial systems
- Visually clean and responsive layout
- No third-party plugins or advanced styling required

*/
