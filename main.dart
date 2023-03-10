import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_grid_button/flutter_grid_button.dart';

void main() {
  runApp(const MyApp());
}

const TextStyle _myTextStyle = TextStyle(
  fontFamily: "Monospace",
  fontWeight: FontWeight.bold,
  fontSize: 50.0,
);

GridButtonItem _myCalcButton (String title) {
  return GridButtonItem(
    title: title,
    textStyle: _myTextStyle,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Trig-Calculator",
            style: TextStyle(
              fontFamily: "Monospace",
            ),
          ),
          centerTitle: true,
        ),
        body: const Calculator(),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final _myController = TextEditingController();
  bool isRadian = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Stack(
            children: [
              // to display input and output
              TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(50.0),
                ),
                controller: _myController,
                style: _myTextStyle,
                readOnly: true,
              ),
              // to indicate degree / radian
              Container(
                padding: const EdgeInsets.all(20.0),
                alignment: const Alignment(1,1),
                child: isRadian? const Text("R", style: TextStyle(fontSize: 20),) :
                const Text("D", style: TextStyle(fontSize: 20),),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 7,
          child: GridButton(
            onPressed: (value) {
              if (value == "<->") {
                setState(() {
                  isRadian = !isRadian;
                });
              }
              else if (value == "sin" || value == "cos" || value == "tan") {
                double angle = 0.0;
                try {
                  angle = double.parse(_myController.text);  // exception can occur if the text is empty
                  // if the mode is degree, convert angle to radian
                  isRadian? null : angle = angle * pi / 180;
                  if (value == "sin") {
                    _myController.text = sin(angle).toString();
                  }
                  else if (value == "cos") {
                    _myController.text = cos(angle).toString();
                  }
                  else {
                    _myController.text = tan(angle).toString();
                  }
                }
                catch(e) {
                  _myController.text = "Enter a valid number";
                }
              }
              else if (value == "C") {
                _myController.text = "";
              }
              else {
                _myController.text += value!;
              }
            },
            items: [
              [
                _myCalcButton("1"),
                _myCalcButton("2"),
                _myCalcButton("3"),
                _myCalcButton("C"),
              ],
              [
                _myCalcButton("4"),
                _myCalcButton("5"),
                _myCalcButton("6"),
                _myCalcButton("."),
              ],
              [
                _myCalcButton("7"),
                _myCalcButton("8"),
                _myCalcButton("9"),
                _myCalcButton("0"),
              ],
              [
                _myCalcButton("sin"),
                _myCalcButton("cos"),
                _myCalcButton("tan"),
                _myCalcButton("<->"),
              ],
            ],
          )
        )
      ],
    );
  }
}
