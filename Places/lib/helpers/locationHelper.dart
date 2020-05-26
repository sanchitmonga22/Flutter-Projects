import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'API_KEY';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    String url =
        'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
    return url;
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY";
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}