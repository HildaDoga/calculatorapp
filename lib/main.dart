import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _history = '';
  String _expression = '';

  void numClick(String text) {
    setState(() {
      if (text == 'x') {
        _expression += '*';
      } else {
        _expression += text;
      }
    });
  }

  void allClear(String text) {
    setState(() {
      _history = '';
      _expression = '';
    });
  }

  void clear(String text) {
    setState(() {
      _expression = '';
    });
  }

  void evaluate(String text) {
    Parser p = Parser();
    Expression exp = p.parse(_expression);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    setState(() {
      _history = _expression;
      _expression = eval.toString();
    });
  }

  Widget buildButton(String text, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () {
            if (text == 'AC') {
              allClear(text);
            } else if (text == 'C') {
              clear(text);
            } else if (text == '=') {
              evaluate(text);
            } else {
              numClick(text);
            }
          },
          child: Text(
            text,
            style: TextStyle(fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
            primary: color,
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Text(
              _history,
              style: TextStyle(fontSize: 24),
            ),
            alignment: Alignment(1, 1),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Text(
              _expression,
              style: TextStyle(fontSize: 48),
            ),
            alignment: Alignment(1, 1),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton('AC', Colors.grey),
              SizedBox(width: 12),
              buildButton('C', Colors.grey),
              SizedBox(width: 12),
              buildButton('%', Colors.grey),
              SizedBox(width: 12),
              buildButton('/', Colors.orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton('7', Colors.black54),
              SizedBox(width: 12),
              buildButton('8', Colors.black54),
              SizedBox(width: 12),
              buildButton('9', Colors.black54),
              SizedBox(width: 12),
              buildButton('x', Colors.orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton('4', Colors.black54),
              SizedBox(width: 12),
              buildButton('5', Colors.black54),
              SizedBox(width: 12),
              buildButton('6', Colors.black54),
              SizedBox(width: 12),
              buildButton('-', Colors.orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton('1', Colors.black54),
              SizedBox(width: 12),
              buildButton('2', Colors.black54),
              SizedBox(width: 12),
              buildButton('3', Colors.black54),
              SizedBox(width: 12),
              buildButton('+', Colors.orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton('0', Colors.black54),
              SizedBox(width: 12),
              buildButton('.', Colors.black54),
              SizedBox(width: 12),
              buildButton('00', Colors.black54),
              SizedBox(width: 12),
              buildButton('=', Colors.orange),
            ],
          ),
        ],
      ),
    );
  }
}
