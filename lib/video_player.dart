import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(const VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  const VideoPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Video Player Demo',
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Butterfly Video')),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
/*
🌳 WIDGET TREE STRUCTURE + PURPOSE

VideoPlayerApp (StatelessWidget)
├── MaterialApp
│   ├── title → "Video Player Demo"
│   ├── home → VideoPlayerScreen (StatefulWidget)
│   └── Purpose: Sets up the base application with routing and theming

VideoPlayerScreen (StatefulWidget)
└── Scaffold
    ├── AppBar
    │   └── Text("Butterfly Video")
    │       └── Purpose: Displays the top navigation bar with title
    ├── body → FutureBuilder
    │   ├── future: _initializeVideoPlayerFuture
    │   ├── builder: (context, snapshot)
    │   │   ├── if (ConnectionState.done)
    │   │   │   └── AspectRatio
    │   │   │       ├── aspectRatio: _controller.value.aspectRatio
    │   │   │       └── child: VideoPlayer(_controller)
    │   │   │           └── Purpose: Displays the video within its correct aspect ratio
    │   │   └── else
    │   │       └── Center → CircularProgressIndicator
    │   │           └── Purpose: Shows a loading spinner while video initializes
    └── floatingActionButton
        ├── onPressed → Toggles play/pause via setState
        └── child: Icon
            ├── Icons.play_arrow if not playing
            └── Icons.pause if playing
            └── Purpose: Controls playback interaction dynamically

🎬 FUNCTIONALITY FLOW
- `_controller` is a `VideoPlayerController` that plays a network video.
- `_initializeVideoPlayerFuture` stores the initialization future.
- `initState()` sets up the controller and begins initializing it.
- `dispose()` cleans up the controller when the widget is removed.
- `FutureBuilder` listens to `_initializeVideoPlayerFuture`:
   - Shows loading spinner while loading
   - Once done, shows the video
- FAB toggles between playing and pausing the video

🧠 CONTROLLER USAGE
- `VideoPlayerController.networkUrl(...)` plays video from a given URL.
- `.initialize()` prepares the video.
- `.setLooping(true)` makes the video repeat.
- `.isPlaying` helps conditionally render the correct icon.

🎯 PURPOSE
- Demonstrates using the `video_player` package to:
   - Load video from a URL
   - Display it responsively
   - Control playback using a floating button
*/
