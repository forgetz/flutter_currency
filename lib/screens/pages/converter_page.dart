import 'package:currency/controllers/currency_rate_controller.dart';
import 'package:currency/screens/widgets/chart_widget.dart';
import 'package:currency_pickers/country.dart';
import 'package:currency_pickers/currency_pickers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConverterPage extends StatefulWidget {
  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  final currencyRateController = Get.put(CurrencyRateController());

  String _fromISO3 = 'USA';
  String _toISO3 = 'THA';
  String inputAmount = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
            child: Column(
              children: [
                inputTextWidget(),
                SizedBox(height: 20.0),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // fromCurrencyItemWidget(),
                      GestureDetector(
                        onTap: () {
                          _openCurrencyPickerDialogFrom();
                        },
                        child: fromCurrencyItemWidget(),
                      ),
                      iconWidget(),
                      GestureDetector(
                        onTap: () {
                          _openCurrencyPickerDialogTo();
                        },
                        child: toCurrencyItemWidget(),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (inputAmount?.isEmpty ?? true) {
                            print('no');
                          } else {
                            print('ok $inputAmount');
                            currencyRateController.calculateAmout(
                                _fromISO3, _toISO3, double.parse(inputAmount));
                          }
                        },
                        child: buttonWidget(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                resultWidget(),
                SizedBox(height: 20.0),
                fromResultWidget(),
                SizedBox(height: 20.0),
                daysRowItem(),
                SizedBox(height: 20.0),
                ChartWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fromCurrencyItemWidget() {
    return Row(
      children: [
        Icon(Icons.keyboard_arrow_down),
        Text(_fromISO3),
      ],
    );
  }

  Widget toCurrencyItemWidget() {
    return Row(
      children: [
        Icon(Icons.keyboard_arrow_down),
        Text(_toISO3),
      ],
    );
  }

  Widget _buildDropDownItems(Country country) {
    return Container(
      child: Row(
        children: [
          CurrencyPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 10.0),
          Text('${country.currencyCode} (${country.isoCode})'),
        ],
      ),
    );
  }

  void _openCurrencyPickerDialogFrom() {
    showDialog(
      context: context,
      builder: (_) => CurrencyPickerDialog(
        itemBuilder: _buildDropDownItems,
        title: Text('Convert from'),
        isSearchable: true,
        onValuePicked: (Country country) {
          print(country.iso3Code);
          if (mounted) {
            setState(() {
              _fromISO3 = country.iso3Code;
            });
          }
        },
      ),
    );
  }

  void _openCurrencyPickerDialogTo() {
    showDialog(
      context: context,
      builder: (_) => CurrencyPickerDialog(
        itemBuilder: _buildDropDownItems,
        title: Text('Convert to'),
        isSearchable: true,
        onValuePicked: (Country country) {
          print(country.iso3Code);
          if (mounted) {
            setState(() {
              _toISO3 = country.iso3Code;
            });
          }
        },
      ),
    );
  }

  Widget iconWidget() {
    return Container(
      child: Stack(
        children: [
          Container(
            width: 45.0,
            height: 45.0,
            child: Image.asset('assets/convert.png'),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text('To'),
            ),
          )
        ],
      ),
    );
  }

  Widget buttonWidget() {
    return Container(
      width: 100.0,
      height: 50.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        color: Colors.deepPurple,
      ),
      child: Text(
        'Convert',
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );
  }

  Widget inputTextWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: TextField(
        onChanged: (value) => inputAmount = value,
        style: TextStyle(fontSize: 30.0),
        textAlign: TextAlign.center,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Amount',
          hintStyle: TextStyle(fontSize: 30.0),
        ),
      ),
    );
  }

  Widget resultWidget() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetX<CurrencyRateController>(builder: (controller) {
            return Text(
              '${controller?.result?.toStringAsFixed(4)} $_toISO3',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget fromResultWidget() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetX<CurrencyRateController>(builder: (controller) {
            return (controller?.currencyRateModel?.value?.rates?.isNull ?? true)
                ? Text('Loading data...')
                : Text(
                    '1 $_fromISO3 = ${controller?.currencyRateModel?.value?.rates?.uSD?.toStringAsFixed(4)} $_toISO3',
                    style: TextStyle(fontSize: 20.0),
                  );
          }),
        ],
      ),
    );
  }

  Widget daysRowItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _singleDay(text: '30 days'),
        _singleDay(text: '60 days'),
        _singleDay(text: '90 days'),
      ],
    );
  }

  Widget _singleDay({String text}) {
    return Row(
      children: [
        Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: Colors.white,
            border: Border.all(color: Colors.purple, width: 2.0),
          ),
        ),
        SizedBox(width: 8.0),
        Text(
          text,
          style: TextStyle(fontSize: 16.0),
        )
      ],
    );
  }
}
