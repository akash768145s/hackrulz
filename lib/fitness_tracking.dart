import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(FitnessTrackerApp());
}

// fl_chart: ^0.64.0
// google_fonts: ^4.0.4
class FitnessTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF7F9FB),
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: FitnessTrackerScreen(),
    );
  }
}

class FitnessTrackerScreen extends StatefulWidget {
  @override
  _FitnessTrackerScreenState createState() => _FitnessTrackerScreenState();
}

class _FitnessTrackerScreenState extends State<FitnessTrackerScreen> {
  int steps = 5000;
  double caloriesBurned = 200;
  List<FlSpot> workoutProgress = [
    FlSpot(1, 2),
    FlSpot(2, 3),
    FlSpot(3, 5),
    FlSpot(4, 7),
    FlSpot(5, 8),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fitness Tracker", style: GoogleFonts.lato()),
        centerTitle: true,
        backgroundColor: Colors.blue.shade600,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                _buildInfoCard("Daily Steps", "$steps", "steps"),
                SizedBox(width: 16),
                _buildInfoCard(
                    "Calories", caloriesBurned.toStringAsFixed(1), "kcal"),
              ],
            ),
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4))
                ],
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Workout Progress",
                      style: GoogleFonts.lato(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey)),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: true),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 32,
                              getTitlesWidget: (value, meta) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text("Day ${value.toInt()}",
                                      style: TextStyle(fontSize: 12)),
                                );
                              },
                              interval: 1,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 28,
                              interval: 2,
                              getTitlesWidget: (value, meta) {
                                return Text("${value.toInt()}");
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: workoutProgress,
                            isCurved: true,
                            color: Colors.blue,
                            barWidth: 4,
                            isStrokeCapRound: true,
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.blue.withOpacity(0.2),
                            ),
                            dotData: FlDotData(show: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, String unit) {
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
          ],
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700])),
            SizedBox(height: 6),
            Text("$value $unit",
                style: GoogleFonts.lato(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800)),
          ],
        ),
      ),
    );
  }
}

// ... (your entire code remains unchanged above)

/// ----------------------
/// WIDGET TREE STRUCTURE
/// ----------------------
/*
FitnessTrackerApp
└── MaterialApp
    └── FitnessTrackerScreen (StatefulWidget)
        └── Scaffold
            ├── AppBar
            │   └── Text ("Fitness Tracker")
            └── SingleChildScrollView
                └── Padding (EdgeInsets.all(20))
                    └── Column
                        ├── Row
                        │   ├── _buildInfoCard ("Daily Steps", "$steps", "steps")
                        │   └── _buildInfoCard ("Calories", "$caloriesBurned", "kcal")
                        ├── SizedBox(height: 30)
                        └── Container (Workout Progress Card)
                            └── Padding (EdgeInsets.all(20))
                                └── Column
                                    ├── Text ("Workout Progress")
                                    ├── SizedBox(height: 20)
                                    └── SizedBox(height: 200)
                                        └── LineChart
                                            └── LineChartData
                                                ├── FlGridData
                                                ├── FlTitlesData (bottom & left axis)
                                                └── LineChartBarData (workoutProgress)
*/

/// -----------------------------
/// WHAT EACH WIDGET/SECTION DOES
/// -----------------------------

/// MaterialApp
/// - Root of the app, sets theme and home page.

/// Scaffold
/// - Basic app layout: contains AppBar and Body content.

/// AppBar
/// - Displays the title "Fitness Tracker" in the app bar.

/// SingleChildScrollView
/// - Makes the content scrollable in case of smaller screens.

/// Padding
/// - Adds spacing all around the column content.

/// Column
/// - Arranges UI elements vertically.

/// Row
/// - Horizontally lays out the two info cards side by side.

/// _buildInfoCard()
/// - A reusable method that creates a Card with a title and a value+unit text.
/// - Used for both "Steps" and "Calories".

/// Container (Workout Progress Card)
/// - A white box with rounded corners and shadows.
/// - Contains the "Workout Progress" chart.

/// Text (Workout Progress)
/// - Title above the chart.

/// SizedBox (LineChart)
/// - Fixed height space for the chart.

/// LineChart
/// - Shows curved workout progress with FlSpot data.
