import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(AnimatedBallApp());
}

class AnimatedBallApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animated Ball',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AnimatedBallScreen(),
    );
  }
}

class AnimatedBallScreen extends StatefulWidget {
  @override
  _AnimatedBallScreenState createState() => _AnimatedBallScreenState();
}

class _AnimatedBallScreenState extends State<AnimatedBallScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isAnimating = false;
  double speed = 1.0;
  Color ballColor = Colors.red;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });

    _animation = Tween<double>(begin: 0, end: 200).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _toggleAnimation() {
    if (isAnimating) {
      _controller.stop();
    } else {
      _controller.repeat(reverse: true);
    }
    setState(() {
      isAnimating = !isAnimating;
    });
  }

  void _updateSpeed(double value) {
    setState(() {
      speed = value;
      _controller.duration = Duration(milliseconds: (2000 ~/ speed));
      if (isAnimating) {
        _controller.repeat(reverse: true);
      }
    });
  }

  void _changeColor(String color) {
    setState(() {
      switch (color) {
        case 'Red':
          ballColor = Colors.red;
          break;
        case 'Blue':
          ballColor = Colors.blue;
          break;
        case 'Green':
          ballColor = Colors.green;
          break;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animated Ball')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Transform.scale(
                scale: 1 + (_animation.value / 200),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: ballColor,
                    shape: BoxShape.circle,
                  ),
                  margin: EdgeInsets.only(left: _animation.value),
                ),
              ),
            ),
          ),
          Slider(
            value: speed,
            min: 0.5,
            max: 3.0,
            divisions: 5,
            label: speed.toStringAsFixed(1),
            onChanged: _updateSpeed,
          ),
          DropdownButton<String>(
            value: ballColor == Colors.red
                ? 'Red'
                : ballColor == Colors.blue
                    ? 'Blue'
                    : 'Green',
            onChanged: (value) => _changeColor(value!),
            items: ['Red', 'Blue', 'Green'].map((String color) {
              return DropdownMenuItem<String>(
                value: color,
                child: Text(color),
              );
            }).toList(),
          ),
          ElevatedButton(
            onPressed: _toggleAnimation,
            child: Text(isAnimating ? 'Stop' : 'Start'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
/*
🌳 WIDGET TREE STRUCTURE + PURPOSE

AnimatedBallApp (StatelessWidget)
├── MaterialApp
│   ├── title: 'Animated Ball'
│   ├── theme → Blue theme
│   └── home → AnimatedBallScreen

AnimatedBallScreen (StatefulWidget)
└── Scaffold
    ├── AppBar → Displays title "Animated Ball"
    └── body: Column
        ├── Expanded
        │   └── Center
        │       └── Transform.scale
        │           └── Container
        │               ├── Circular shape (ball)
        │               ├── Color → ballColor (Red/Blue/Green)
        │               ├── Margin left → based on animation value
        │               └── Scales up/down using animation value (visual bounce effect)
        ├── Slider (Speed control)
        │   ├── min: 0.5, max: 3.0
        │   └── onChanged: _updateSpeed → changes animation duration dynamically
        ├── DropdownButton<String> (Color selector)
        │   ├── Items: Red, Blue, Green
        │   └── onChanged: _changeColor → updates ball color
        ├── ElevatedButton (Start/Stop toggle)
        │   └── onPressed: _toggleAnimation → controls play/pause of animation
        └── SizedBox → Adds bottom spacing

ANIMATION FLOW:
- _controller drives the animation
- _animation.value animates margin left and scaling of the ball
- _controller.repeat(reverse: true) creates back-and-forth motion
- Duration is dynamically updated with `_updateSpeed` using a slider

USER INTERACTION:
- Slider changes speed of bounce
- Dropdown changes ball color
- Button toggles animation on/off

PURPOSE:
- Demonstrates animation using `AnimationController` and `Tween`
- Adds interactivity with speed and color adjustments
- Great example for learning basic Flutter animation patterns

*/
