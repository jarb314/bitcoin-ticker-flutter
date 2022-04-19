import 'dart:convert';
import 'package:http/http.dart' as http;

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

const bitcoinAverageURL =
    'https://apiv2.bitcoinaverage.com/indices/global/ticker';

class CoinData {
  Future getCoinData(String currency, String coin) async {
    String requestURL = '$bitcoinAverageURL/$coin$currency';

    http.Response responce = await http.get(requestURL);

    if (responce.statusCode == 200) {
      var decodeData = jsonDecode(responce.body);

      var lastPrice = decodeData['last'];

      return lastPrice;
    } else {
      print(responce.statusCode);
      print(requestURL);
      throw 'Problem with the get request';
    }
  }
}
