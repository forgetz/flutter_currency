import 'dart:math';
import 'package:currency/models/currency_rate_model.dart';
import 'package:get/get.dart';

class CurrencyRateController extends GetxController {
  var currencyRateModel = CurrencyRateModel().obs;
  var inputAmount = 0.0.obs;
  var result = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrency('', '', '');
  }

  void calculateAmout(String from, String to, double amount) {
    inputAmount.value = amount;
    result.value = amount * currencyRateModel?.value?.rates?.uSD;
  }

  void fetchCurrency(
    String from,
    String to,
    String amount,
  ) async {
    print('fetchCurrency');

    await Future.delayed(Duration(seconds: 5));

    final random = Random();
    final crm = CurrencyRateModel(
      success: true,
      base: 'usd',
      date: '2020-10-24',
      historical: true,
      rates: Rates(
        tHB: random.nextInt(30) + random.nextInt(10) + random.nextDouble(),
        uSD: random.nextInt(30) + random.nextInt(10) + random.nextDouble(),
      ),
    );

    currencyRateModel.value = crm;
    update();
  }
}
