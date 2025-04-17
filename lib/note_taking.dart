import 'package:flutter/material.dart';

void main() {
  runApp(NoteApp());
}

class NoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotesScreen(),
    );
  }
}

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<Map<String, String>> notes = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  void _addNote() {
    if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
      setState(() {
        notes.add({
          'title': titleController.text,
          'content': contentController.text,
        });
        titleController.clear();
        contentController.clear();
      });
    }
  }

  void _editNote(int index) {
    titleController.text = notes[index]['title']!;
    contentController.text = notes[index]['content']!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Content'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                notes[index] = {
                  'title': titleController.text,
                  'content': contentController.text,
                };
              });
              titleController.clear();
              contentController.clear();
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Content'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addNote,
              child: Text('Add Note'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(notes[index]['title']!),
                    subtitle: Text(notes[index]['content']!),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _editNote(index),
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

NoteApp (StatelessWidget)
├── MaterialApp
│   ├── title: 'Notes App'
│   ├── theme → Blue primary color
│   └── home → NotesScreen (main UI)

NotesScreen (StatefulWidget)
└── Scaffold
    ├── AppBar
    │   └── Text → Displays the title "Notes App"
    └── body: Padding (EdgeInsets.all(16.0))
        └── Column (Main vertical layout)
            ├── TextField (titleController)
            │   └── Input field to enter note title
            ├── TextField (contentController)
            │   └── Input field to enter note content
            ├── SizedBox(height: 10)
            │   └── Adds spacing before the button
            ├── ElevatedButton → "Add Note"
            │   └── onPressed → Calls _addNote() to add the new note
            └── Expanded
                └── ListView.builder
                    └── ListTile (for each note)
                        ├── title → Note title
                        ├── subtitle → Note content
                        └── trailing: IconButton (edit)
                            └── onPressed → Opens AlertDialog to edit note

📦 STATE MANAGEMENT:
- List<Map<String, String>> notes → Holds all added notes
- TextEditingControllers manage title/content input

🧠 FUNCTIONALITY:
- _addNote() → Adds a note if both fields are filled, clears inputs
- _editNote(index) → Populates dialog with existing note, allows editing and saving
- TextFields are reused both in main screen and dialog
- Dialog is built using AlertDialog inside `showDialog()`

🎯 USER INTERACTION FLOW:
1. User enters title + content
2. Taps "Add Note" → new note is added to list
3. Taps ✏️ (edit icon) → opens AlertDialog to update existing note
4. Edited note replaces the previous one

*/
