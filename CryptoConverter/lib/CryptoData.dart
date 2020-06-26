import 'dart:convert';
import 'package:http/http.dart' as http;
import 'coin_data.dart';

class Crypto {
  Future<dynamic> getData({String to, String from}) async {
    String key = "";
    String url =
        "https://rest.coinapi.io/v1/exchangerate/$from/$to?apikey=$key";
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['rate'].toStringAsFixed(2);
    } else {
      return null;
    }
  }

  Future<dynamic> getExchangedList(String to) async {
    final exchanges = ['', '', ''];
    for (int i = 0; i < 3; i++) {
      String data = await getData(to: to, from: cryptoList[i]);
      exchanges[i] = data;
    }
    return exchanges;
  }
}
