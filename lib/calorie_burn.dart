import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// google_fonts: ^4.0.4

void main() {
  runApp(CalorieBurnCalculatorApp());
}

class CalorieBurnCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF8F9FA),
        primarySwatch: Colors.deepOrange,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: CalorieBurnCalculatorScreen(),
    );
  }
}

class CalorieBurnCalculatorScreen extends StatefulWidget {
  @override
  _CalorieBurnCalculatorScreenState createState() =>
      _CalorieBurnCalculatorScreenState();
}

class _CalorieBurnCalculatorScreenState
    extends State<CalorieBurnCalculatorScreen> {
  double weight = 60.0;
  String selectedActivity = 'Running';
  double duration = 30.0;
  double caloriesBurned = 0.0;

  final Map<String, double> activityMETs = {
    'Running': 8.0,
    'Walking': 3.5,
    'Cycling': 6.0,
    'Swimming': 7.0,
  };

  void calculateCalories() {
    double metValue = activityMETs[selectedActivity] ?? 3.5;
    setState(() {
      caloriesBurned = (metValue * 3.5 * weight / 200) * duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calorie Burn Calculator"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Weight (kg)",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                Slider(
                  value: weight,
                  min: 30,
                  max: 150,
                  divisions: 120,
                  label: "${weight.toStringAsFixed(1)} kg",
                  activeColor: Colors.deepOrange,
                  onChanged: (value) {
                    setState(() {
                      weight = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                Text("Activity Type",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedActivity,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.orange.shade50,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                  ),
                  items: activityMETs.keys.map((activity) {
                    return DropdownMenuItem(
                        value: activity, child: Text(activity));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedActivity = value!;
                    });
                  },
                ),
                SizedBox(height: 20),
                Text("Duration (minutes)",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                Slider(
                  value: duration,
                  min: 5,
                  max: 120,
                  divisions: 23,
                  label: "${duration.toStringAsFixed(0)} mins",
                  activeColor: Colors.deepOrange,
                  onChanged: (value) {
                    setState(() {
                      duration = value;
                    });
                  },
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: calculateCalories,
                    child: Text("Calculate"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      textStyle: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                if (caloriesBurned > 0)
                  Center(
                    child: Text(
                      "Calories Burned: ${caloriesBurned.toStringAsFixed(2)} kcal",
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



/*
Widget Tree:
CalorieBurnCalculatorApp
└── MaterialApp
    └── CalorieBurnCalculatorScreen (StatefulWidget)
        └── Scaffold
            ├── AppBar (title: Calorie Burn Calculator)
            └── SingleChildScrollView
                └── Padding
                    └── Card
                        └── Padding
                            └── Column
                                ├── Text (Weight)
                                ├── Slider (weight)
                                ├── SizedBox
                                ├── Text (Activity Type)
                                ├── DropdownButtonFormField
                                ├── SizedBox
                                ├── Text (Duration)
                                ├── Slider (duration)
                                ├── SizedBox
                                ├── ElevatedButton (Calculate)
                                ├── SizedBox
                                └── Text (Calories Burned) [conditional]
*/
/*

Widget	Purpose
MaterialApp	Entry point, theme setup
Scaffold	Page layout with app bar
AppBar	Displays the title bar
SingleChildScrollView	Allows vertical scrolling
Card	Stylish container for form content
Text	Displays labels and result text
Slider	Lets user set weight and duration
DropdownButtonFormField	Choose activity type
ElevatedButton	Triggers calorie calculation
SizedBox	Adds spacing between UI elements
*/