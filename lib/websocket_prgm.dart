import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

//  web_socket_channel: ^2.4.0

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'WebSocket Demo';
    return const MaterialApp(
      title: title,
      home: MyHomePage(
        title: title,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.events'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}
/*
MyApp (StatelessWidget)
├── MaterialApp
│   ├── title → "WebSocket Demo"
│   └── home → MyHomePage(title: "WebSocket Demo")

MyHomePage (StatefulWidget)
└── Scaffold
    ├── AppBar
    │   └── Text → Displays the page title
    └── body: Padding (EdgeInsets.all(20.0))
        └── Column (Main layout)
            ├── Form
            │   └── TextFormField
            │       ├── controller: _controller
            │       └── Input field to type a message
            ├── SizedBox(height: 24)
            └── StreamBuilder (Listens to WebSocket stream)
                └── Text → Displays incoming message if snapshot has data

    └── floatingActionButton
        ├── IconButton (Send)
        └── onPressed: _sendMessage() → Sends the typed message to the server

🔁 FUNCTIONALITY
- _controller → Gets input from user
- _channel → Connects to `wss://echo.websocket.events`
- _sendMessage() → Sends the message to WebSocket server
- StreamBuilder → Listens to `_channel.stream` and displays incoming data

🧠 STATE MANAGEMENT
- StatefulWidget is used to:
  - Manage the text controller
  - Keep the connection live
  - Display updates as they stream in real-time

📦 STREAM MECHANISM
- `StreamBuilder` listens to the server’s response stream
- When a message is received, it rebuilds the widget to show the result

*/
