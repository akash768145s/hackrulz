import 'package:flutter/material.dart';

void main() {
  runApp(RecipeApp());
}

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Manager',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: RecipeScreen(),
    );
  }
}

class RecipeScreen extends StatefulWidget {
  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  final List<Map<String, String>> recipes = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController directionsController = TextEditingController();

  void _addRecipe() {
    if (nameController.text.isNotEmpty &&
        ingredientsController.text.isNotEmpty &&
        directionsController.text.isNotEmpty) {
      setState(() {
        recipes.add({
          'name': nameController.text,
          'ingredients': ingredientsController.text,
          'directions': directionsController.text,
        });
        nameController.clear();
        ingredientsController.clear();
        directionsController.clear();
      });
    }
  }

  void _editRecipe(int index) {
    nameController.text = recipes[index]['name']!;
    ingredientsController.text = recipes[index]['ingredients']!;
    directionsController.text = recipes[index]['directions']!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Recipe'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Recipe Name'),
            ),
            TextField(
              controller: ingredientsController,
              decoration: InputDecoration(labelText: 'Ingredients'),
            ),
            TextField(
              controller: directionsController,
              decoration: InputDecoration(labelText: 'Directions'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                recipes[index] = {
                  'name': nameController.text,
                  'ingredients': ingredientsController.text,
                  'directions': directionsController.text,
                };
              });
              nameController.clear();
              ingredientsController.clear();
              directionsController.clear();
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
      appBar: AppBar(title: Text('Recipe Manager')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Recipe Name'),
            ),
            TextField(
              controller: ingredientsController,
              decoration: InputDecoration(labelText: 'Ingredients'),
            ),
            TextField(
              controller: directionsController,
              decoration: InputDecoration(labelText: 'Directions'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addRecipe,
              child: Text('Add Recipe'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(recipes[index]['name']!),
                    subtitle:
                        Text('Ingredients: ${recipes[index]['ingredients']}'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _editRecipe(index),
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

RecipeApp (StatelessWidget)
├── MaterialApp
│   ├── title: 'Recipe Manager'
│   ├── theme → Uses green primary color
│   └── home → RecipeScreen (StatefulWidget)

RecipeScreen (StatefulWidget)
└── Scaffold
    ├── AppBar
    │   └── Title: "Recipe Manager"
    └── body: Padding (EdgeInsets.all(16.0))
        └── Column (Main vertical layout)
            ├── TextField (nameController)
            │   └── Input for Recipe Name
            ├── TextField (ingredientsController)
            │   └── Input for Ingredients
            ├── TextField (directionsController)
            │   └── Input for Directions
            ├── SizedBox(height: 10)
            │   └── Adds spacing before the button
            ├── ElevatedButton → "Add Recipe"
            │   └── onPressed → Adds new recipe to the list if fields are filled
            └── Expanded
                └── ListView.builder
                    └── ListTile (for each recipe)
                        ├── title → Recipe name
                        ├── subtitle → Ingredients (summary)
                        └── trailing → IconButton (edit)
                            └── onPressed → Opens AlertDialog to edit selected recipe

🔁 FUNCTIONALITY:
- _addRecipe(): Adds a new recipe from the inputs
- _editRecipe(index): Loads existing data into controllers and shows AlertDialog for editing
- TextFields are reused both for adding and editing (via dialog)

🧠 STATE:
- List<Map<String, String>> recipes → stores all recipes (name, ingredients, directions)
- TextEditingControllers → manage form input

📱 USER FLOW:
1. User enters name, ingredients, directions
2. Taps "Add Recipe" → recipe added to list
3. Taps ✏️ icon → opens dialog with pre-filled fields → edits and saves

🎯 DESIGN GOALS:
- Simple CRUD for recipes
- Text-based editable recipe entries
- Clean and compact UI with minimal interaction steps

*/
