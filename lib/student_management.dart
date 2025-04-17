import 'package:flutter/material.dart';

void main() {
  runApp(StudentManagementApp());
}

class StudentManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StudentListScreen(),
    );
  }
}

class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  final List<Map<String, String>> students = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();

  void _addStudent() {
    if (nameController.text.isNotEmpty &&
        idController.text.isNotEmpty &&
        gradeController.text.isNotEmpty) {
      setState(() {
        students.add({
          'name': nameController.text,
          'id': idController.text,
          'grade': gradeController.text,
        });
      });
      nameController.clear();
      idController.clear();
      gradeController.clear();
      Navigator.of(context).pop();
    }
  }

  void _showAddStudentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Student'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Student Name'),
            ),
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: 'Student ID'),
            ),
            TextField(
              controller: gradeController,
              decoration: InputDecoration(labelText: 'Grade'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _addStudent,
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void _updateStudent(int index) {
    nameController.text = students[index]['name']!;
    idController.text = students[index]['id']!;
    gradeController.text = students[index]['grade']!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Student'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Student Name'),
            ),
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: 'Student ID'),
            ),
            TextField(
              controller: gradeController,
              decoration: InputDecoration(labelText: 'Grade'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                students[index] = {
                  'name': nameController.text,
                  'id': idController.text,
                  'grade': gradeController.text,
                };
              });
              nameController.clear();
              idController.clear();
              gradeController.clear();
              Navigator.of(context).pop();
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Management')),
      body: students.isEmpty
          ? Center(child: Text('No students added yet.'))
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(students[index]['name']!,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text(
                      'ID: ${students[index]['id']} | Grade: ${students[index]['grade']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _updateStudent(index),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddStudentDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
/*
🌳 WIDGET TREE STRUCTURE + PURPOSE

StudentManagementApp (StatelessWidget)
├── MaterialApp
│   ├── title → "Student Management"
│   ├── theme → PrimarySwatch: Blue
│   └── home → StudentListScreen (StatefulWidget)

StudentListScreen (StatefulWidget)
└── Scaffold
    ├── AppBar
    │   └── Text('Student Management') → App title
    ├── body
    │   ├── if students list is empty
    │   │   └── Center → Text('No students added yet.') → Fallback view
    │   └── else → ListView.builder
    │       └── ListTile (for each student)
    │           ├── title → Student name (bold, large text)
    │           ├── subtitle → ID and Grade info (combined string)
    │           └── trailing → IconButton (edit icon)
    │               └── onPressed → Opens update dialog for student
    └── floatingActionButton
        └── Icon(Icons.add) → Opens form dialog to add new student

🔧 ADD STUDENT DIALOG:
- Triggered by `_showAddStudentDialog()` via FAB
- Contains:
  ├── TextFields (name, ID, grade)
  ├── Cancel → Closes dialog
  └── Add → Adds new student to the list (via _addStudent)

✏️ UPDATE STUDENT DIALOG:
- Triggered by tapping edit icon for a student
- Fields pre-filled with selected student data
- Save button updates list at specific index

🧠 STATE MANAGEMENT:
- `List<Map<String, String>> students` → Stores student records
- TextEditingControllers: `nameController`, `idController`, `gradeController` → Input fields
- All operations (add/update) modify `students` list via `setState`

💡 USER FLOW:
1. User taps ➕ FAB → opens add dialog
2. Fills in fields and taps "Add" → student is added to list
3. Taps ✏️ edit icon → opens update dialog with pre-filled info
4. Taps "Update" → student record gets updated

🎯 PURPOSE:
- Simple CRUD-like functionality for managing student entries
- Clean UI using ListTiles and AlertDialogs
- Efficient and readable state logic with `TextEditingControllers` and `setState`

*/
