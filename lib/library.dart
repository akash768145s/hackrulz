import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SimpleLibraryApp(),
  ));
}

class SimpleLibraryApp extends StatefulWidget {
  const SimpleLibraryApp({super.key});

  @override
  State<SimpleLibraryApp> createState() => _SimpleLibraryAppState();
}

class _SimpleLibraryAppState extends State<SimpleLibraryApp> {
  final List<Map<String, String>> books = [];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();

  void _showBookDialog({int? index}) {
    if (index != null) {
      titleController.text = books[index]['title']!;
      authorController.text = books[index]['author']!;
    } else {
      titleController.clear();
      authorController.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(index == null ? 'Add Book' : 'Edit Book'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: authorController,
              decoration: const InputDecoration(labelText: 'Author'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final newBook = {
                'title': titleController.text,
                'author': authorController.text
              };

              setState(() {
                if (index == null) {
                  books.add(newBook);
                } else {
                  books[index] = newBook;
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

  void _deleteBook(int index) {
    setState(() {
      books.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Library Manager")),
      body: books.isEmpty
          ? const Center(child: Text("No books added yet."))
          : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return ListTile(
                  title: Text(book['title'] ?? ''),
                  subtitle: Text(book['author'] ?? ''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showBookDialog(index: index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteBook(index),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBookDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}



// MaterialApp
// └── SimpleLibraryApp (StatefulWidget)
//     └── Scaffold
//         ├── AppBar
//         │   └── Text("Library Manager")
//         ├── body (Conditional)
//         │   ├── if empty
//         │   │   └── Center → Text("No books added yet.")
//         │   └── else
//         │       └── ListView.builder
//         │           └── ListTile (for each book)
//         │               ├── Text (Title)
//         │               ├── Text (Author)
//         │               └── Row (Trailing Buttons)
//         │                   ├── IconButton (Edit)
//         │                   └── IconButton (Delete)
//         └── FloatingActionButton (Add)
//             └── Icon(Icons.add)

// Dialog (_showBookDialog)
// └── AlertDialog
//     ├── Text (title)
//     ├── Column
//     │   ├── TextField (titleController)
//     │   └── TextField (authorController)
//     └── Row
//         ├── TextButton ("Save")
//         └── TextButton ("Cancel")
