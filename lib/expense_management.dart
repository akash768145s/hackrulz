import 'package:flutter/material.dart';

void main() {
  runApp(ExpenseManagerApp());
}

class ExpenseManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Manager',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ExpenseListScreen(),
    );
  }
}

class ExpenseListScreen extends StatefulWidget {
  @override
  _ExpenseListScreenState createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  final List<Map<String, String>> expenses = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  void _addExpense() {
    if (titleController.text.isNotEmpty && amountController.text.isNotEmpty) {
      setState(() {
        expenses.add({
          'title': titleController.text,
          'amount': amountController.text,
        });
      });
      titleController.clear();
      amountController.clear();
      Navigator.of(context).pop();
    }
  }

  void _showAddExpenseDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Expense Title'),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _addExpense,
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expense Manager')),
      body: expenses.isEmpty
          ? Center(child: Text('No expenses added yet.'))
          : ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(expenses[index]['title']!,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text('Amount: \$${expenses[index]['amount']!}',
                      style: TextStyle(fontSize: 16)),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddExpenseDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
/*
🌳 WIDGET TREE STRUCTURE + PURPOSE

ExpenseManagerApp (StatelessWidget)
├── MaterialApp
│   ├── title → 'Expense Manager'
│   ├── theme → Green primary swatch
│   └── home → ExpenseListScreen (StatefulWidget)

ExpenseListScreen (StatefulWidget)
└── Scaffold
    ├── AppBar
    │   └── Text → "Expense Manager"
    ├── body
    │   ├── If expenses.isEmpty
    │   │   └── Center → Text("No expenses added yet.")
    │   └── Else → ListView.builder
    │       └── ListTile (for each expense)
    │           ├── title → Expense title (bold, larger font)
    │           └── subtitle → Expense amount in dollars (smaller font)
    └── floatingActionButton
        └── Icon(Icons.add)
            └── onPressed: _showAddExpenseDialog()

🧾 ADD EXPENSE DIALOG
Triggered via `_showAddExpenseDialog()` when FAB is tapped:
- AlertDialog
  ├── title: "Add Expense"
  ├── content: Column with 2 TextFields
  │   ├── titleController → for expense name
  │   └── amountController → for expense amount (number input)
  └── actions:
      ├── TextButton "Cancel" → closes dialog
      └── ElevatedButton "Add" → triggers _addExpense()

🧠 STATE MANAGEMENT
- `List<Map<String, String>> expenses` → Stores expense records
- `titleController` and `amountController` → Input fields for expense data
- `setState()` is used to update UI when a new expense is added

💡 USER FLOW
1. User taps ➕ FAB → sees dialog to add new expense
2. Inputs title and amount, taps "Add"
3. Expense appears in the list
4. If no expenses, fallback text is shown instead

🎯 PURPOSE
- Manage personal expenses using a lightweight form
- Clear layout with ListTiles and AlertDialog
- Simple state-driven list without external storage

*/
