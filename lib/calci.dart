import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  String _output = "0";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        num1 = 0;
        num2 = 0;
        operand = "";
      } else if (buttonText == "=") {
        num2 = double.parse(output);
        switch (operand) {
          case "+": _output = (num1 + num2).toString(); break;
          case "-": _output = (num1 - num2).toString(); break;
          case "*": _output = (num1 * num2).toString(); break;
          case "/": _output = (num1 / num2).toString(); break;
        }
        num1 = 0;
        num2 = 0;
        operand = "";
      } else if (["+", "-", "*", "/"].contains(buttonText)) {
        num1 = double.parse(output);
        operand = buttonText;
        _output = "0";
      } else {
        _output = _output == "0" ? buttonText : _output + buttonText;
      }
      output = _output;
    });
  }

  Widget buildButton(String buttonText, {Color? color}) {
    return ElevatedButton(
      onPressed: () => buttonPressed(buttonText),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20),
        backgroundColor: color ?? Colors.grey[900],
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(32),
              child: Text(
                output,
                style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: [
                  buildButton("C", color: Colors.red),
                  buildButton("/", color: Colors.orange),
                  buildButton("*", color: Colors.orange),
                  buildButton("-", color: Colors.orange),
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("+", color: Colors.orange),
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("=", color: Colors.green),
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("0"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
