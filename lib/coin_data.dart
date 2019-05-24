import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

class CoinData {
  String currency = 'USD';

  CoinData({this.currency});

  getCoinData() async {
    Map<String, double> prices = {};
    for (String crypto in cryptoList) {
      http.Response dataBtc = await http.get(
          'https://apiv2.bitcoinaverage.com/indices/global/ticker/$crypto$currency');
      Map decodedBtcData = jsonDecode(dataBtc.body);
      prices[crypto] = decodedBtcData['last'];
    }
    print(prices);
    return prices;
  }
}
