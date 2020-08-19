import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/services.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  String _apiKey;

  Future<double> getExchangeRate({
    String baseCurrency = "BTC",
    String targetCurrency = "USD",
  }) async {
    if (_apiKey == null) await _loadKey();
    http.Response response = await http.get(
      "$coinAPIURL/$baseCurrency/$targetCurrency",
      headers: {"X-CoinAPI-Key": _apiKey},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)["rate"];
    } else {
      return null;
    }
  }

  Future<void> _loadKey() async {
    String data = await rootBundle.loadString("keys.json");
    _apiKey = jsonDecode(data)["COIN_API_KEY"];
    return;
  }
}
