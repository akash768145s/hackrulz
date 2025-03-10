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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => buttonPressed(buttonText),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
          backgroundColor: color ?? Colors.grey[800],
          foregroundColor: Colors.white,
        ),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
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
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(32),
              child: Text(
                output,
                style: const TextStyle(fontSize: 64, fontWeight: FontWeight.w500, color: Colors.white),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10)],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ["C", "/", "*", "-"]
                      .map((text) => buildButton(text, color: text == "C" ? Colors.red : Colors.orange))
                      .toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ["7", "8", "9"]
                      .map((text) => buildButton(text, color: Colors.blueGrey))
                      .toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ["4", "5", "6"]
                      .map((text) => buildButton(text, color: Colors.blueGrey))
                      .toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ["1", "2", "3"]
                      .map((text) => buildButton(text, color: Colors.blueGrey))
                      .toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton("0", color: Colors.blueGrey),
                    buildButton(".", color: Colors.blueGrey),
                    buildButton("=", color: Colors.greenAccent),
                    buildButton("+", color: Colors.orange),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
