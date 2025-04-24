import 'package:flutter/material.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Akash | Full Stack Web Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/about': (context) => const AboutPage(),
        '/projects': (context) => const ProjectsPage(),
        '/blogs': (context) => const BlogsPage(),
        '/contact': (context) => const ContactPage(),
      },
    );
  }
}

// === Custom Navigation Button ===

Widget _navButton(
    BuildContext context, String title, String route, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, route),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      child: Text(title),
    ),
  );
}

PreferredSizeWidget buildAppBar(BuildContext context) {
  return AppBar(
    title: const Text("Akash | Portfolio"),
    backgroundColor: Colors.indigo.shade700,
    actions: [
      _navButton(context, "About", "/about", Colors.purple),
      _navButton(context, "Projects", "/projects", Colors.teal),
      _navButton(context, "Blogs", "/blogs", Colors.orange),
      _navButton(context, "Contact", "/contact", Colors.pink),
    ],
  );
}

// === Pages ===

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            "Hi, I'm Akash\nA Full Stack Web Developer crafting modern, scalable, and impactful applications.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          "I'm a passionate Full Stack Web Developer skilled in building robust web applications from frontend to backend. "
          "I specialize in JavaScript (React, Node.js), Python (FastAPI), and database systems like MongoDB and PostgreSQL. "
          "Currently exploring AI integrations, DevOps workflows, and mobile-friendly PWA architectures.",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          Text("Bus Route Optimization System",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(
              "Built with FastAPI + React. Integrates Google OR-Tools for real-time routing, cluster analysis, and bus capacity management.\n"),
          Text("Speech-to-Pictogram AAC Web App",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(
              "Speech and text inputs converted to pictograms using Whisper and ARASAAC. Includes offline caching, Docker deployment, and PWA support.\n"),
          Text("Image Captioning with HuggingFace",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(
              "FastAPI backend and React frontend. Upload images, generate captions, and map them to pictograms.\n"),
        ],
      ),
    );
  }
}

class BlogsPage extends StatelessWidget {
  const BlogsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          Text("Simplifying Complex Sentences for AI Pictogram Systems",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text("How I used NLP to make speech-based AAC apps smarter.\n\n"),
          Text("Merging DBSCAN and HAC for Route Clustering",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(
              "Insights from my bus route project to combine spatial clustering with hierarchy-based route merging.\n\n"),
          Text("Real-time Image Captioning using Xception and LSTM",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(
              "Explained with TensorFlow pipelines and tips for model performance in production."),
        ],
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            "Let's collaborate!\n\nEmail: akash@example.com\nGitHub: github.com/akash-dev\nLinkedIn: linkedin.com/in/akash-webdev",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}



// MaterialApp
// └── routes
//     ├── HomePage
//     │   └── Scaffold
//     │       ├── AppBar
//     │       │   ├── Text (title)
//     │       │   └── Row (actions)
//     │       │       ├── Padding → ElevatedButton ("About")
//     │       │       ├── Padding → ElevatedButton ("Projects")
//     │       │       ├── Padding → ElevatedButton ("Blogs")
//     │       │       └── Padding → ElevatedButton ("Contact")
//     │       └── Center
//     │           └── Padding
//     │               └── Text (intro message)
//     ├── AboutPage
//     │   └── Scaffold
//     │       ├── AppBar (same as above)
//     │       └── Padding
//     │           └── Text (about content)
//     ├── ProjectsPage
//     │   └── Scaffold
//     │       ├── AppBar (same as above)
//     │       └── ListView
//     │           └── Column of Text widgets (project titles & descriptions)
//     ├── BlogsPage
//     │   └── Scaffold
//     │       ├── AppBar (same as above)
//     │       └── ListView
//     │           └── Column of Text widgets (blog titles & summaries)
//     └── ContactPage
//         └── Scaffold
//             ├── AppBar (same as above)
//             └── Padding
//                 └── Center
//                     └── Text (contact info)
