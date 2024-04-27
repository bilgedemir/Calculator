import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorHomePage());
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

// State class for CalculatorHomePage
class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _output = '0';
  String _currentInput = '';
  double _currentNumber = 0;
  String _operation = '';
  bool _isOperationClicked = false;
  bool _isResultClicked = false;

  // Function to handle button clicks
  void _handleButtonClick(String buttonText) {
    // Logic for button actions
    if (_isResultClicked && !_isOperation(buttonText)) {
      _clear();
    }
    setState(() {
      if (buttonText == 'C') {
        _clear();
      } else if (buttonText == '=') {
        _calculateResult();
        _isResultClicked = true;
      } else if (buttonText == 'DEL') {
        _deleteDigit();
      } else if (buttonText == '+/-') {
        if (_currentInput.isNotEmpty && _currentInput != '0') {
          if (_currentInput.startsWith('-')) {
            _currentInput = _currentInput.substring(1);
          } else {
            _currentInput = '-' + _currentInput;
          }
        } else if (_output != '0') {
          if (_output.startsWith('-')) {
            _output = _output.substring(1);
          } else {
            _output = '-' + _output;
          }
        }
      } else {
        if (_isOperation(buttonText)) {
          _isOperationClicked = true;
          _isResultClicked = false;
          _operation = buttonText;
          _currentNumber = double.parse(_currentInput);
          _currentInput = '';
        } else if (buttonText == '.') {
          if (!_currentInput.contains('.')) {
            _currentInput += '.';
          }
        } else {
          if (_currentInput == '0') {
            _currentInput = buttonText;
          } else {
            _currentInput += buttonText;
          }
        }
      }
      _output = _currentInput.isEmpty ? _currentNumber.toString() : _currentInput;
    });
  }

// Function to check if a button represents an operation
  bool _isOperation(String buttonText) {
    return buttonText == '+' || buttonText == '-' || buttonText == 'X' || buttonText == '/' || buttonText == '%';
  }
// Function to clear the calculator state
  void _clear() {
    _output = '0';
    _currentInput = '';
    _currentNumber = 0;
    _operation = '';
    _isOperationClicked = false;
    _isResultClicked = false;
  }
// Function to delete the last digit entered
  void _deleteDigit() {
    setState(() {
      if (_currentInput.isNotEmpty) {
        _currentInput = _currentInput.substring(0, _currentInput.length - 1);
        _output = _currentInput.isEmpty ? _currentNumber.toString() : _currentInput;
      }
    });
  }
// Function to calculate the result
  void _calculateResult() {
    double secondNumber = double.parse(_currentInput);
    double result = 0;
    switch (_operation) {
      case '+':
        result = _currentNumber + secondNumber;
        break;
      case '-':
        result = _currentNumber - secondNumber;
        break;
      case 'X':
        result = _currentNumber * secondNumber;
        break;
      case '/':
        result = _currentNumber / secondNumber;
        break;
      case '%':
        result = _currentNumber % secondNumber;
        break;
    }
    _output = result.toString();
    _currentInput = '';
    _currentNumber = result;
    _operation = '';
  }
// Function to build calculator buttons
  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      margin: EdgeInsets.all(0.25),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.black, width: 0.5),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          elevation: MaterialStateProperty.all<double>(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: Colors.black, width: 1.0),
            ),
          ),
        ),
        onPressed: () => _handleButtonClick(buttonText),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 29.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
// Build method to create the UI
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Simple Calculator',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: <Widget>[
            Container(
              color: Colors.grey[350],
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                ),
                child: Text(
                  _output,
                  style: TextStyle(fontSize: 48.0),
                ),
              ),
            ),

            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio: 1.0,
                padding: EdgeInsets.all(1.0),
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
                children: <Widget>[
                  buildButton('C', 1, Colors.lightBlueAccent),
                  buildButton('DEL', 1, Colors.lightBlueAccent),
                  buildButton('%', 1, Colors.lightBlueAccent),
                  buildButton('/', 1, Colors.lightBlueAccent),
                  buildButton('7', 1, Colors.lightBlueAccent),
                  buildButton('8', 1, Colors.lightBlueAccent),
                  buildButton('9', 1, Colors.lightBlueAccent),
                  buildButton('X', 1, Colors.lightBlueAccent),
                  buildButton('4', 1, Colors.lightBlueAccent),
                  buildButton('5', 1, Colors.lightBlueAccent),
                  buildButton('6', 1, Colors.lightBlueAccent),
                  buildButton('-', 1, Colors.lightBlueAccent),
                  buildButton('1', 1, Colors.lightBlueAccent),
                  buildButton('2', 1, Colors.lightBlueAccent),
                  buildButton('3', 1, Colors.lightBlueAccent),
                  buildButton('+', 1, Colors.lightBlueAccent),
                  buildButton('+/-', 1, Colors.lightBlueAccent),
                  buildButton('0', 1, Colors.lightBlueAccent),
                  buildButton('.', 1, Colors.lightBlueAccent),
                  buildButton('=', 1, Colors.lightBlueAccent),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


