import 'package:flutter/material.dart';

void main() {
  runApp(const EchoHabitApp());
}

class EchoHabitApp extends StatelessWidget {
  const EchoHabitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EchoHabit - Habit Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const EchoHabitHome(),
    );
  }
}

class Task {
  String name;
  int progress; // 25, 50, 75, 100

  Task({required this.name, this.progress = 0});
}

class EchoHabitHome extends StatefulWidget {
  const EchoHabitHome({super.key});

  @override
  State<EchoHabitHome> createState() => _EchoHabitHomeState();
}

class _EchoHabitHomeState extends State<EchoHabitHome> {
  final List<Task> tasks = [];
  final _controller = TextEditingController();

  void addTask(String name) {
    setState(() {
      tasks.add(Task(name: name));
    });
    _controller.clear();
  }

  void updateTaskProgress(Task task, int newProgress) {
    setState(() {
      task.progress = newProgress;
    });
  }

  Color getProgressColor(int percent) {
    if (percent < 40) return Colors.red;
    if (percent < 75) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EchoHabit'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter new habit/task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.trim().isNotEmpty) {
                      addTask(_controller.text.trim());
                    }
                  },
                  child: const Text("Add"),
                )
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: tasks.isEmpty
                  ? const Center(child: Text("No tasks yet. Add one!"))
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(task.name,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                LinearProgressIndicator(
                                  value: task.progress / 100,
                                  minHeight: 12,
                                  color: getProgressColor(task.progress),
                                  backgroundColor: Colors.grey.shade300,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Text("Progress: "),
                                    DropdownButton<int>(
                                      value: task.progress,
                                      items: [0, 25, 50, 75, 100]
                                          .map((val) => DropdownMenuItem(
                                              value: val, child: Text("$val%")))
                                          .toList(),
                                      onChanged: (newVal) {
                                        if (newVal != null) {
                                          updateTaskProgress(task, newVal);
                                        }
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}



// MaterialApp
// └── EchoHabitHome (StatefulWidget)
//     └── Scaffold
//         ├── AppBar
//         │   └── Text("EchoHabit")
//         └── Padding
//             └── Column
//                 ├── Row (Add Task Input Section)
//                 │   ├── Expanded
//                 │   │   └── TextField (User types a new task here)
//                 │   ├── SizedBox (spacing)
//                 │   └── ElevatedButton ("Add" button to add task)
//                 ├── SizedBox (spacing)
//                 └── Expanded (Task list or message)
//                     └── Conditional (if task list is empty)
//                         └── Center → Text("No tasks yet. Add one!")
//                      or └── ListView.builder (for each task)
//                             └── Card
//                                 └── Padding
//                                     └── Column
//                                         ├── Text (task name)
//                                         ├── SizedBox
//                                         ├── LinearProgressIndicator (colored by %)
//                                         ├── SizedBox
//                                         └── Row
//                                             ├── Text("Progress:")
//                                             └── DropdownButton<int> (editable %)
// MaterialApp	The root of your app. Applies global theme and routing logic.
// EchoHabitHome	The main screen. Manages task state using StatefulWidget.
// Scaffold	Provides the basic structure: app bar + body layout.
// AppBar	The top bar of the app displaying the title EchoHabit.
// TextField	User types the habit/task name here to add a new one.
// ElevatedButton ("Add")	Adds a new task to the list using the text entered.
// Expanded (TextField)	Ensures the input takes max horizontal space.
// SizedBox	Adds spacing between widgets (e.g., 10 or 20 pixels).
// Expanded (ListView)	Makes the task list take the rest of the screen height.
// ListView.builder	Dynamically builds UI for all tasks in the tasks list.
// Card	A visually separated container for each habit.
// Text (task.name)	Displays the name of the habit/task.
// LinearProgressIndicator	A horizontal bar showing progress visually.
// getProgressColor	Decides progress bar color based on percentage.
// DropdownButton<int>	Lets user select the task’s progress (0–100%).
// updateTaskProgress	Updates the selected task’s progress and refreshes the UI.