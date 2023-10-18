import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'result_page.dart';

class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();
  final TextEditingController operatorController = TextEditingController();

  double result = 0.0;

  void calculate() {
    final num1 = double.tryParse(num1Controller.text) ?? 0.0;
    final num2 = double.tryParse(num2Controller.text) ?? 0.0;
    final operator = operatorController.text;

    double calculatedResult = 0.0;

    switch (operator) {
      case '+':
        calculatedResult = num1 + num2;
        break;
      case '-':
        calculatedResult = num1 - num2;
        break;
      case '*':
        calculatedResult = num1 * num2;
        break;
      case '/':
        calculatedResult = num1 / num2;
        break;
      default:
        break;
    }

    // Simpan hasil ke shared preferences
    saveResult(calculatedResult, operator);

    setState(() {
      result = calculatedResult;
    });
  }

  void saveResult(double result, String operator) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('result', result);
    prefs.setString('operator', operator);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator Sederhana'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: num1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Bilangan 1'),
            ),
            TextField(
              controller: operatorController,
              decoration: InputDecoration(labelText: 'Operasi (+,-,:,x)'),
            ),
            TextField(
              controller: num2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Bilangan 2'),
            ),
            ElevatedButton(
              onPressed: calculate,
              child: Text('Hitung'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(),
                  ),
                );
              },
              child: Text('Lihat Hasil'),
            ),
          ],
        ),
      ),
    );
  }
}
