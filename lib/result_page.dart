import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Kalkulator'),
      ),
      body: FutureBuilder(
        future: getSavedResult(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final result = snapshot.data?['result'];
            final operator = snapshot.data?['operator'];

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Hasil: $result'),
                  Text('Operasi: $operator'),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> getSavedResult() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = prefs.getDouble('result') ?? 0;
    final operator = prefs.getString('operator') ?? '';
    return {'result': result, 'operator': operator};
  }
}
