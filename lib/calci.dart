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
  String expression = ""; // Stores "9+9"
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        output = "0";
        expression = "";
        num1 = 0;
        num2 = 0;
        operand = "";
      } else if (buttonText == "=") {
        num2 = double.parse(output);
        if (operand.isNotEmpty) {
          expression += output; // Show full expression before result
        }
        if (operand == "+") {
          output = (num1 + num2).toString();
        } else if (operand == "-") {
          output = (num1 - num2).toString();
        } else if (operand == "*") {
          output = (num1 * num2).toString();
        } else if (operand == "/") {
          output = (num1 / num2).toString();
        }
        num1 = 0;
        num2 = 0;
        operand = "";
      } else if (["+", "-", "*", "/"].contains(buttonText)) {
        num1 = double.parse(output);
        operand = buttonText;
        expression = output + buttonText; // Show "9+"
        output = "0";
      } else {
        output = output == "0" ? buttonText : output + buttonText;
      }
    });
  }

  Widget buildButton(String text, {Color color = Colors.blue}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: () => buttonPressed(text),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            backgroundColor: color,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          child: Text(text, style: const TextStyle(fontSize: 24)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(expression, style: const TextStyle(fontSize: 24, color: Colors.black54)), // Show "9+9"
                  Text(output, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(children: ["7", "8", "9", "/"].map((t) => buildButton(t, color: Colors.orange)).toList()),
              Row(children: ["4", "5", "6", "*"].map((t) => buildButton(t, color: Colors.orange)).toList()),
              Row(children: ["1", "2", "3", "-"].map((t) => buildButton(t, color: Colors.orange)).toList()),
              Row(children: ["C", "0", "=", "+"].map((t) => buildButton(t, color: t == "C" ? Colors.red : Colors.blue)).toList()),
            ],
          ),
        ],
      ),
    );
  }
}
