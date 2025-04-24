import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: NoteApp(),
  ));
}

class NoteApp extends StatefulWidget {
  const NoteApp({super.key});

  @override
  State<NoteApp> createState() => _NoteAppState();
}

class _NoteAppState extends State<NoteApp> {
  final List<Map<String, String>> notes = [];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  void _showNoteDialog({int? index}) {
    if (index != null) {
      titleController.text = notes[index]['title']!;
      contentController.text = notes[index]['content']!;
    } else {
      titleController.clear();
      contentController.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(index == null ? 'Add Note' : 'Edit Note'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: contentController,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final note = {
                'title': titleController.text,
                'content': contentController.text,
              };
              setState(() {
                if (index == null) {
                  notes.add(note);
                } else {
                  notes[index] = note;
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  void _viewNote(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(notes[index]['title']!),
        content: Text(notes[index]['content']!),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Notes")),
      body: notes.isEmpty
          ? const Center(child: Text("No notes yet. Tap + to add one."))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return ListTile(
                  title: Text(note['title'] ?? ''),
                  subtitle: Text(
                    note['content']!.length > 50
                        ? "${note['content']!.substring(0, 50)}..."
                        : note['content']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () => _viewNote(index),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showNoteDialog(index: index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteNote(index),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNoteDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
