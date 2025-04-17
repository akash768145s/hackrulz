import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// http: ^0.13.6
void main() => runApp(const AlbumListApp());

class AlbumListApp extends StatelessWidget {
  const AlbumListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Album List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AlbumListScreen(),
    );
  }
}

// 📦 Model class for Album
class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

// 🔁 Function to fetch album list
Future<List<Album>> fetchAlbums() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => Album.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load albums');
  }
}

// 📱 Main Screen
class AlbumListScreen extends StatefulWidget {
  const AlbumListScreen({super.key});

  @override
  State<AlbumListScreen> createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  late Future<List<Album>> futureAlbums;

  @override
  void initState() {
    super.initState();
    futureAlbums = fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Albums')),
      body: FutureBuilder<List<Album>>(
        future: futureAlbums,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final albums = snapshot.data!;
            return ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];
                return ListTile(
                  leading: CircleAvatar(child: Text('${album.id}')),
                  title: Text(album.title),
                  subtitle: Text('User ID: ${album.userId}'),
                );
              },
            );
          } else {
            return const Center(child: Text('No albums found.'));
          }
        },
      ),
    );
  }
}
/*
🌳 WIDGET TREE STRUCTURE + PURPOSE

AlbumListApp (StatelessWidget)
├── MaterialApp
│   ├── title → "Album List"
│   ├── debugShowCheckedBanner → false
│   ├── theme → Blue primary color
│   └── home → AlbumListScreen (StatefulWidget)

AlbumListScreen (StatefulWidget)
└── Scaffold
    ├── AppBar
    │   └── Text("Albums") → App bar title
    └── body → FutureBuilder<List<Album>>
        ├── future → futureAlbums (calls fetchAlbums())
        └── builder → Displays based on snapshot state:
            ├── if waiting → CircularProgressIndicator
            ├── if error → Text("Error: ...")
            ├── if hasData → ListView.builder
            │   └── itemBuilder (for each album):
            │       └── ListTile
            │           ├── leading → CircleAvatar
            │           │   └── Displays album.id
            │           ├── title → Displays album.title
            │           └── subtitle → Displays "User ID: {userId}"
            └── else → Text("No albums found")

🔁 FUNCTIONALITY FLOW
1. `AlbumListScreen` is shown.
2. In `initState()`, `futureAlbums = fetchAlbums()` is called.
3. `fetchAlbums()` makes a GET request to JSONPlaceholder API.
4. Response is parsed into a list of `Album` objects.
5. `FutureBuilder` reacts based on the data or error:
   - If loading → shows spinner
   - If success → shows album list
   - If error → shows error message

📦 Album Model
- Represents each album with `userId`, `id`, and `title`
- `fromJson()` factory parses JSON response to Dart object

🎯 PURPOSE
- Demonstrates basic REST API data fetching in Flutter
- Uses `FutureBuilder` to manage asynchronous state
- Renders network data into scrollable list

*/
