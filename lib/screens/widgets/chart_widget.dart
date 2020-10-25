import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartWidget extends StatefulWidget {
  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: charts.TimeSeriesChart(
        _createSampleData(),
        animate: true,
        dateTimeFactory: charts.LocalDateTimeFactory(),
      ),
    );
  }

  static List<charts.Series<TimeRates, DateTime>> _createSampleData() {
    final data = [
      TimeRates(DateTime(2020, 2, 19), 500),
      TimeRates(DateTime(2020, 3, 26), 55),
      TimeRates(DateTime(2020, 5, 3), 100),
      TimeRates(DateTime(2020, 6, 10), 400),
      TimeRates(DateTime(2020, 7, 10), 195),
      TimeRates(DateTime(2020, 8, 10), 275),
    ];

    return [
      charts.Series<TimeRates, DateTime>(
        id: 'Rates',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeRates rate, _) => rate.time,
        measureFn: (TimeRates rate, _) => rate.rate,
        data: data,
      )
    ];
  }
}

class TimeRates {
  final DateTime time;
  final int rate;

  TimeRates(this.time, this.rate);
}
