import 'package:flutter/material.dart';

void main() {
  runApp(BudgetManagerApp());
}

class BudgetManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budget Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BudgetManagerScreen(),
    );
  }
}

class BudgetManagerScreen extends StatefulWidget {
  @override
  _BudgetManagerScreenState createState() => _BudgetManagerScreenState();
}

class _BudgetManagerScreenState extends State<BudgetManagerScreen> {
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController expensesController = TextEditingController();
  final TextEditingController savingsGoalController = TextEditingController();

  double? availableSavings;
  double? progressPercentage;

  void _calculateSavings() {
    double? income = double.tryParse(incomeController.text);
    double? expenses = double.tryParse(expensesController.text);
    double? savingsGoal = double.tryParse(savingsGoalController.text);

    if (income != null && expenses != null && savingsGoal != null) {
      setState(() {
        availableSavings = income - expenses;
        progressPercentage = (availableSavings! / savingsGoal) * 100;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Budget Manager')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: incomeController,
              decoration: InputDecoration(labelText: 'Income'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: expensesController,
              decoration: InputDecoration(labelText: 'Expenses'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: savingsGoalController,
              decoration: InputDecoration(labelText: 'Savings Goal'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateSavings,
              child: Text('Calculate Savings'),
            ),
            SizedBox(height: 20),
            if (availableSavings != null)
              Text(
                'Available Savings: \$${availableSavings!.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            if (progressPercentage != null)
              Text(
                'Progress Towards Goal: ${progressPercentage!.toStringAsFixed(2)}%',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
/*
🌳 WIDGET TREE STRUCTURE + PURPOSE

BudgetManagerApp (StatelessWidget)
├── MaterialApp
│   ├── title → "Budget Manager"
│   ├── theme → Uses blue color scheme
│   └── home → BudgetManagerScreen (StatefulWidget)

BudgetManagerScreen (StatefulWidget)
└── Scaffold
    ├── AppBar
    │   └── Title → "Budget Manager"
    └── body: Padding (EdgeInsets.all(16.0))
        └── Column (Main vertical layout)
            ├── TextField (incomeController)
            │   └── User enters total monthly/yearly income
            ├── SizedBox(height: 10)
            ├── TextField (expensesController)
            │   └── User enters total expenses
            ├── SizedBox(height: 10)
            ├── TextField (savingsGoalController)
            │   └── User enters desired savings target
            ├── SizedBox(height: 20)
            ├── ElevatedButton → "Calculate Savings"
            │   └── onPressed: _calculateSavings()
            ├── SizedBox(height: 20)
            ├── if availableSavings != null
            │   └── Text → Shows calculated savings after expenses
            └── if progressPercentage != null
                └── Text → Shows percentage progress toward savings goal

🧠 STATE MANAGEMENT:
- incomeController → stores income input
- expensesController → stores expenses input
- savingsGoalController → stores savings goal input
- availableSavings → result of income - expenses
- progressPercentage → availableSavings / savingsGoal * 100

🔢 FUNCTIONALITY:
- _calculateSavings():
  └ Parses all input values as `double`, computes:
    - available savings
    - progress toward savings goal
  └ Uses `setState()` to update the UI with results

📱 USER FLOW:
1. User enters income, expenses, and savings goal.
2. Taps "Calculate Savings".
3. Sees how much is left (available savings).
4. Sees how close they are to reaching their savings goal (progress %).

🎯 DESIGN GOALS:
- Simple, focused personal finance calculator.
- One-tap feedback on spending and saving habits.
- Clear financial feedback for planning.

*/
