import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// http: ^0.13.6
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter HTTP Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PostListScreen(),
    );
  }
}

class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  List<dynamic> posts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          posts = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts List")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(posts[index]['title']),
                  subtitle: Text(posts[index]['body']),
                );
              },
            ),
    );
  }
}
/*
🌳 WIDGET TREE STRUCTURE + PURPOSE

MyApp (StatelessWidget)
├── MaterialApp
│   ├── title → "Flutter HTTP Example"
│   ├── theme → Blue primary color
│   └── home → PostListScreen (StatefulWidget)

PostListScreen (StatefulWidget)
└── Scaffold
    ├── AppBar
    │   └── Text("Posts List") → App bar title
    └── body
        ├── if (isLoading)
        │   └── Center
        │       └── CircularProgressIndicator → Spinner shown while loading
        └── else
            └── ListView.builder
                ├── itemCount → posts.length
                └── itemBuilder → Builds UI for each post
                    └── ListTile
                        ├── title → post title (bold)
                        └── subtitle → post body text

🔁 FUNCTIONALITY FLOW:
1. App starts and shows `PostListScreen`.
2. `initState()` calls `fetchPosts()` to load data from JSONPlaceholder API.
3. While waiting, `isLoading = true` → spinner shown.
4. Once fetched:
   - JSON is decoded to a list and stored in `posts`.
   - `isLoading = false` → UI rebuilds and shows post list.
5. Each post is shown with its title and body in a `ListTile`.

📦 STATE MANAGEMENT:
- `posts` → Stores the list of posts from API.
- `isLoading` → Manages loading state.

🧠 DATA SOURCE:
- Uses `http.get()` to call: `https://jsonplaceholder.typicode.com/posts`
- Parses JSON response into a List of maps.

🎯 PURPOSE:
- Demonstrates how to:
  - Make HTTP requests in Flutter
  - Parse JSON
  - Display dynamic lists with `ListView.builder`
  - Manage UI based on asynchronous states (loading/done)

*/
