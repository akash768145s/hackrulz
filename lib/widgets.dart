import 'package:flutter/material.dart';

void main() {
  runApp(const WidgetaryDemoApp());
}

/// This is the root widget of the application.
/// [MaterialApp] sets up app-wide settings like themes, routes, and title.
/// It's the starting point of any Material Design-based app.
class WidgetaryDemoApp extends StatelessWidget {
  const WidgetaryDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widgetary',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const WidgetShowcaseScreen(),
    );
  }
}

/// This screen contains a scrollable list of the most commonly used widgets.
/// Each widget is accompanied by a description and live usage.
class WidgetShowcaseScreen extends StatelessWidget {
  const WidgetShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // [Scaffold] gives you the basic visual layout structure.
      appBar: AppBar(
        title: const Text('Most Used Flutter Widgets'),
      ),

      // Optional drawer menu for side navigation.
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(child: Text('Navigation Header')),
            ListTile(title: Text('Menu Option 1')),
            ListTile(title: Text('Menu Option 2')),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        // A circular button floating above content. Usually for primary action.
        onPressed: () {},
        child: const Icon(Icons.add),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle('Text'),
            widgetExplanation(
              context,
              description: 'Displays a string of text with optional styling.',
              child: const Text(
                'Hello, Widgetary!',
                style: TextStyle(fontSize: 20),
              ),
            ),

            sectionTitle('ElevatedButton'),
            widgetExplanation(
              context,
              description: 'A button with elevation and shadow. Best for primary actions.',
              child: ElevatedButton(onPressed: () {}, child: const Text('Click Me')),
            ),

            sectionTitle('TextButton'),
            widgetExplanation(
              context,
              description: 'A button without elevation. Used for flat UI elements or links.',
              child: TextButton(onPressed: () {}, child: const Text('Tap Me')),
            ),

            sectionTitle('OutlinedButton'),
            widgetExplanation(
              context,
              description: 'A border-only button. Use for secondary or neutral actions.',
              child: OutlinedButton(onPressed: () {}, child: const Text('Outline Me')),
            ),

            sectionTitle('Icon'),
            widgetExplanation(
              context,
              description: 'Displays a vector icon from Material Icons library.',
              child: Row(
                children: const [Icon(Icons.star), Icon(Icons.favorite)],
              ),
            ),

            sectionTitle('Image.network'),
            widgetExplanation(
              context,
              description: 'Loads and displays an image from the internet.',
              child: Image.network(
                'https://picsum.photos/200',
                height: 100,
              ),
            ),

            sectionTitle('TextField'),
            widgetExplanation(
              context,
              description: 'Basic input box for user text entry.',
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Enter text',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            sectionTitle('Switch'),
            widgetExplanation(
              context,
              description: 'A toggle button that switches on/off.',
              child: StatefulBuilder(
                builder: (context, setState) {
                  bool value = false;
                  return Switch(
                    value: value,
                    onChanged: (val) => setState(() => value = val),
                  );
                },
              ),
            ),

            sectionTitle('Slider'),
            widgetExplanation(
              context,
              description: 'A horizontal draggable control to pick a numeric value.',
              child: StatefulBuilder(
                builder: (context, setState) {
                  double val = 0.5;
                  return Slider(
                    value: val,
                    onChanged: (v) => setState(() => val = v),
                  );
                },
              ),
            ),

            sectionTitle('Card + ListTile'),
            widgetExplanation(
              context,
              description: 'Cards are used for grouping content. Often contain ListTiles.',
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('John Doe'),
                  subtitle: const Text('Flutter Developer'),
                ),
              ),
            ),

            sectionTitle('Stack'),
            widgetExplanation(
              context,
              description: 'Stacks widgets on top of each other. Used for overlays and positioning.',
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(width: 100, height: 100, color: Colors.blue),
                  const Text('Centered'),
                ],
              ),
            ),

            sectionTitle('ListView.builder'),
            widgetExplanation(
              context,
              description: 'Efficient scrollable list that builds items lazily as needed.',
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) => ListTile(
                    title: Text('Item $index'),
                  ),
                ),
              ),
            ),

            sectionTitle('GridView.count'),
            widgetExplanation(
              context,
              description: 'Creates a grid layout with a fixed number of tiles per row.',
              child: SizedBox(
                height: 120,
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(
                    4,
                    (i) => Container(
                      margin: const EdgeInsets.all(4),
                      color: Colors.teal,
                      child: Center(child: Text('Tile $i')),
                    ),
                  ),
                ),
              ),
            ),

            sectionTitle('Expanded + Row'),
            widgetExplanation(
              context,
              description: 'Expanded fills the available space inside a Row or Column.',
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      color: Colors.red,
                      child: const Center(child: Text('Half 1')),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      color: Colors.green,
                      child: const Center(child: Text('Half 2')),
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

  /// Builds a section title with spacing
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// Builds a block showing the widget along with a helpful explanation
  Widget widgetExplanation(BuildContext context,
      {required String description, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          description,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 6),
        child,
        const Divider(height: 24, color: Colors.grey),
      ],
    );
  }
}
