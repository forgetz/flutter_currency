import 'package:currency/screens/pages/converter_page.dart';
import 'package:currency/screens/pages/info_page.dart';
import 'package:currency/screens/pages/rates_page.dart';
import 'package:currency/screens/widgets/row_buttons.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageIndexHolder = 0;

  List<Widget> _listPages = [ConverterPage(), RatesPage(), InfoPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            RowButtons(
              onSave: (pageIndexValue) {
                if (mounted) {
                  setState(() {
                    _pageIndexHolder = pageIndexValue;
                  });
                }
              },
              activePageIndex: _pageIndexHolder,
            ),
            Expanded(child: _listPages[_pageIndexHolder])
          ],
        ),
      ),
    );
  }
}
