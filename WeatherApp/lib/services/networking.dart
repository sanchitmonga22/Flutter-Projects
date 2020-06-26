import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;
  NetworkHelper(this.url);

  Future<Map<String, dynamic>> getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
