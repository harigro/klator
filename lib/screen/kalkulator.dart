import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';
import 'package:intl/intl.dart';

String formatNumber(double number) {
  NumberFormat format = NumberFormat.decimalPattern('id');
  return format.format(number);
}

class KalkulatorScreen extends StatefulWidget {
  @override
  _KalkulatorScreenState createState() => _KalkulatorScreenState();
}

class _KalkulatorScreenState extends State<KalkulatorScreen> {
  String input = '';
  String result = '0';

  void onPressed(dynamic text) {
    setState(() {
      if (text == 'AC') {
        input = '';
        result = '0';
      } else if (text == '⌫') {
        input = input.isNotEmpty ? input.substring(0, input.length - 1) : '';
        result = input.isNotEmpty ? input : '0';
      } else if (text == '=') {
        // Ganti simbol yang dapat dipahami manusia dengan simbol yang dapat dipahami komputer
        String formattedInput = input
            .replaceAll('÷', '/')
            .replaceAll('×', '*')
            .replaceAll('−', '-')
            .replaceAll(',', '.'); // Ganti koma dengan titik untuk evaluasi

        try {
          Parser p = Parser();
          Expression exp = p.parse(formattedInput);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          // Format angka ke dalam format Indonesia
          result = formatNumber(eval).replaceAll('.', ',');
        } catch (e) {
          result = 'Error';
        }
      } else {
        // Simpan input dengan simbol yang lebih deskriptif
        if (text == '÷' || text == '×' || text == '−' || text == '+') {
          input += text;
        } else if (text == ',') {
          input += text; // Masukkan koma sebagai tanda desimal
        } else {
          input += text;
        }
        result = '0'; // Reset result each time a button is pressed
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 24, fontFamily: 'TexGyreAdventor');

    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              child: Text(
                input,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              child: Text(
                result,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Expanded(
              flex: 3,
              child: GridButton(
                textStyle: textStyle,
                borderColor: Colors.grey[300],
                borderWidth: 2,
                onPressed: onPressed,
                items: [
                  [
                    GridButtonItem(title: '7'),
                    GridButtonItem(title: '8'),
                    GridButtonItem(title: '9'),
                    GridButtonItem(title: '÷', color: Colors.orange),
                  ],
                  [
                    GridButtonItem(title: '4'),
                    GridButtonItem(title: '5'),
                    GridButtonItem(title: '6'),
                    GridButtonItem(title: '×', color: Colors.orange),
                  ],
                  [
                    GridButtonItem(title: '1'),
                    GridButtonItem(title: '2'),
                    GridButtonItem(title: '3'),
                    GridButtonItem(title: '−', color: Colors.orange),
                  ],
                  [
                    GridButtonItem(title: '0'),
                    GridButtonItem(title: '00'),
                    GridButtonItem(title: ','),
                    GridButtonItem(title: '+', color: Colors.orange),
                  ],
                  [
                    GridButtonItem(title: 'AC', color: Colors.red),
                    GridButtonItem(title: '⌫'),
                    GridButtonItem(title: '=', color: Colors.green, flex: 2),
                  ],
                ],
              ),
            ),
            SizedBox(height: 20), // Add some spacing at the bottom
          ],
        ),
      ),
    );
  }
}
