import 'package:flutter/material.dart';

void main() {
  runApp(EmployeeApp());
}

class EmployeeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EmployeeScreen(),
    );
  }
}

class EmployeeScreen extends StatefulWidget {
  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  final List<Map<String, String>> employees = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();

  void _addEmployee() {
    if (nameController.text.isNotEmpty &&
        positionController.text.isNotEmpty &&
        salaryController.text.isNotEmpty) {
      setState(() {
        employees.add({
          'name': nameController.text,
          'position': positionController.text,
          'salary': salaryController.text,
        });
        nameController.clear();
        positionController.clear();
        salaryController.clear();
      });
    }
  }

  void _editEmployee(int index) {
    nameController.text = employees[index]['name']!;
    positionController.text = employees[index]['position']!;
    salaryController.text = employees[index]['salary']!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Employee'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: positionController,
              decoration: InputDecoration(labelText: 'Position'),
            ),
            TextField(
              controller: salaryController,
              decoration: InputDecoration(labelText: 'Salary'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                employees[index] = {
                  'name': nameController.text,
                  'position': positionController.text,
                  'salary': salaryController.text,
                };
              });
              nameController.clear();
              positionController.clear();
              salaryController.clear();
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteEmployee(int index) {
    setState(() {
      employees.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employee Manager')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: positionController,
              decoration: InputDecoration(labelText: 'Position'),
            ),
            TextField(
              controller: salaryController,
              decoration: InputDecoration(labelText: 'Salary'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addEmployee,
              child: Text('Add Employee'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(employees[index]['name']!),
                    subtitle: Text(
                        'Position: ${employees[index]['position']} \nSalary: ${employees[index]['salary']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _editEmployee(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteEmployee(index),
                        ),
                      ],
                    ),
                  );
                },
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

EmployeeApp (StatelessWidget)
├── MaterialApp
│   ├── title: 'Employee Manager'
│   ├── theme → Uses blue color scheme
│   └── home → EmployeeScreen (StatefulWidget)

EmployeeScreen (StatefulWidget)
└── Scaffold
    ├── AppBar → Title: "Employee Manager"
    └── body: Padding (all sides: 16.0)
        └── Column (Main vertical layout)
            ├── TextField (nameController)
            │   └── For entering employee name
            ├── TextField (positionController)
            │   └── For entering employee position
            ├── TextField (salaryController)
            │   └── For entering employee salary (number input)
            ├── SizedBox → Adds vertical spacing before button
            ├── ElevatedButton → "Add Employee"
            │   └── onPressed → Adds new employee to the list
            └── Expanded
                └── ListView.builder
                    ├── Builds dynamic list of employees
                    └── For each employee:
                        └── ListTile
                            ├── title → Employee name
                            ├── subtitle → Position and Salary
                            ├── trailing → Row
                            │   ├── IconButton (edit)
                            │   │   └── Opens AlertDialog to edit employee
                            │   └── IconButton (delete)
                            │       └── Removes employee from the list

🔁 FUNCTIONALITY:
- _addEmployee(): Adds new employee using current values from text controllers
- _editEmployee(index): Opens a dialog to update selected employee’s info
- _deleteEmployee(index): Removes the employee at the given index

🧠 DATA STRUCTURE:
- List<Map<String, String>> employees
  Each map contains: name, position, salary (as strings)

🛠 UI INTERACTION FLOW:
1. User enters Name, Position, and Salary
2. Taps "Add Employee" → adds employee to the list
3. Taps ✏️ (edit) → shows dialog with pre-filled values → saves changes
4. Taps 🗑 (delete) → removes employee from list

📱 UI DESIGN:
- Minimal form layout at top
- Dynamic ListView for employee entries
- AlertDialog for in-place editing

*/
