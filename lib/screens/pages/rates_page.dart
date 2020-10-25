import 'package:flutter/material.dart';

class RatesPage extends StatefulWidget {
  @override
  _RatesPageState createState() => _RatesPageState();
}

class _RatesPageState extends State<RatesPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Table(
              border: TableBorder.all(
                color: Colors.black26,
                width: 1.0,
                style: BorderStyle.none,
              ),
              children: [
                TableRow(
                  children: [
                    TableCell(child: Center(child: Text('Currency'))),
                    TableCell(child: Center(child: Text('Rate'))),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
