import 'package:flutter/material.dart';

void main() {
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsListScreen(),
    );
  }
}

class NewsListScreen extends StatelessWidget {
  final List<Map<String, String>> news = [
    {
      'title': 'Flutter 3.0 Released',
      'description':
          'Flutter 3.0 comes with exciting new features and improvements.'
    },
    {
      'title': 'AI Advances in 2025',
      'description':
          'Artificial Intelligence is transforming industries worldwide.'
    },
    {
      'title': 'SpaceX Mars Mission',
      'description': 'SpaceX announces plans to send humans to Mars by 2030.'
    },
    {
      'title': 'Climate Change Effects',
      'description':
          'Scientists warn about the increasing impacts of climate change.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News Headlines')),
      body: ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(news[index]['title']!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailScreen(
                      news[index]['title']!, news[index]['description']!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class NewsDetailScreen extends StatelessWidget {
  final String title;
  final String description;

  NewsDetailScreen(this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          description,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
/*
🌳 WIDGET TREE STRUCTURE + PURPOSE

NewsApp (StatelessWidget)
├── MaterialApp
│   ├── title → "News Reader"
│   ├── theme → Blue primary color scheme
│   └── home → NewsListScreen (StatelessWidget)

NewsListScreen (StatelessWidget)
└── Scaffold
    ├── AppBar
    │   └── Text('News Headlines') → Title of the news list screen
    └── body: ListView.builder
        └── Iterates over `news` list
            └── ListTile (for each news item)
                ├── title → News title (bold text)
                ├── trailing → Icon (forward arrow)
                └── onTap → Navigates to NewsDetailScreen with title & description

NewsDetailScreen (StatelessWidget)
└── Scaffold
    ├── AppBar
    │   └── Text(title) → Displays the news headline
    └── body: Padding (EdgeInsets.all(16.0))
        └── Text(description)
            └── Shows full article description with basic styling

🧠 DATA FLOW:
- `news` is a local list of maps containing title & description.
- On tapping a news item, its title and description are passed to `NewsDetailScreen`.

💡 USER FLOW:
1. User launches app and sees a list of headlines.
2. Taps a headline → navigates to a new screen showing the full description.
3. Back button returns to list.

🎯 DESIGN GOALS:
- Simple news reader layout
- List view of headlines with navigation to full article
- Stateless structure for minimal overhead and clear navigation flow

🚀 POTENTIAL ENHANCEMENTS:
- Use an API to fetch real news data (e.g., NewsAPI)
- Add images, timestamps, or categories
- Add a favorite/save feature for articles

*/
