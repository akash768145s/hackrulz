import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
  // intl: ^0.18.1
  // timezone: ^0.9.2
void main() {
  tz.initializeTimeZones();
  runApp(TimeZoneConverterApp());
}

class TimeZoneConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: TimeZoneConverterScreen(),
    );
  }
}

class TimeZoneConverterScreen extends StatefulWidget {
  @override
  _TimeZoneConverterScreenState createState() =>
      _TimeZoneConverterScreenState();
}

class _TimeZoneConverterScreenState extends State<TimeZoneConverterScreen> {
  String selectedFromTimeZone = 'America/New_York';
  String selectedToTimeZone = 'Europe/London';
  TimeOfDay selectedTime = TimeOfDay.now();

  List<String> timeZones = tz.timeZoneDatabase.locations.keys.toList();

  String convertTime() {
    final now = DateTime.now();
    final localTime = DateTime(
        now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
    final fromZone = tz.getLocation(selectedFromTimeZone);
    final toZone = tz.getLocation(selectedToTimeZone);

    final fromTzTime = tz.TZDateTime.from(localTime, fromZone);
    final offsetDifference = Duration(
        seconds:
            toZone.currentTimeZone.offset - fromZone.currentTimeZone.offset);
    final toTzTime = fromTzTime.add(offsetDifference);

    return DateFormat('hh:mm a').format(toTzTime);
  }

  Future<void> pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Time Zone Converter")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedFromTimeZone,
              items: timeZones.map((zone) {
                return DropdownMenuItem(value: zone, child: Text(zone));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedFromTimeZone = value!;
                });
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => pickTime(context),
              child: Text("Select Time: ${selectedTime.format(context)}"),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedToTimeZone,
              items: timeZones.map((zone) {
                return DropdownMenuItem(value: zone, child: Text(zone));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedToTimeZone = value!;
                });
              },
            ),
            SizedBox(height: 20),
            Text("Converted Time: ${convertTime()}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}



/*
🌳 WIDGET TREE BREAKDOWN

TimeZoneConverterApp (StatelessWidget)
├── MaterialApp
│   ├── debugShowCheckedModeBanner: false → Removes debug banner
│   ├── theme → Sets deepPurple as primarySwatch, grey background
│   └── home: TimeZoneConverterScreen() → Main screen of the app

TimeZoneConverterScreen (StatefulWidget)
└── Scaffold
    ├── AppBar → Top bar with title "Time Zone Converter"
    └── body: Padding
        └── Column (Main content arranged vertically)
            ├── DropdownButton (From TimeZone)
            │   └── DropdownMenuItem → Populated using all available time zones
            ├── SizedBox → Adds spacing
            ├── ElevatedButton (Time Picker)
            │   └── Triggers showTimePicker and displays selected time
            ├── SizedBox → Adds spacing
            ├── DropdownButton (To TimeZone)
            │   └── DropdownMenuItem → Populated using all available time zones
            ├── SizedBox → Adds spacing
            └── Text (Converted Time Display)
                └── Shows converted time in 'hh:mm a' format (e.g., 03:45 PM)

🛠 KEY FUNCTIONS:
- pickTime(): Opens a time picker dialog and updates `selectedTime`
- convertTime(): Converts selected time from one timezone to another using `timezone` package and formats it nicely

📦 PACKAGES USED:
- intl → For formatting time nicely
- timezone → For accurate timezone calculations
*/
