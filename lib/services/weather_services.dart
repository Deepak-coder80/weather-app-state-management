import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_cubit/constants/constants.dart';
import 'package:weather_cubit/exceptions/weather_exceptions.dart';
import 'package:weather_cubit/models/direct_geocoding.dart';
import 'package:weather_cubit/models/weather.dart';
import 'package:weather_cubit/services/http_error_handler.dart';

class WeatherAPIServices {
  final http.Client httpClient;
  WeatherAPIServices({
    required this.httpClient,
  });

  Future<DirectGeocoding> getDirectGeoCoding(String city) async{
    final Uri uri = Uri(
      scheme: 'https',
      host: kApiHost,
      path: '/geo/1.0/direct',
      queryParameters: {
        'q':city,
        'limit': kLimit,
        'appid': '26f712f9fa9f526c0a977b77b69ae853'
      }
    );

    try {
      final http.Response response = await httpClient.get(uri);

      if(response.statusCode != 200){
        throw httpErrorHandler(response);
      }

      final responseBody = json.decode(response.body);

      if(responseBody.isEmpty){
        throw WeatherException('Cannot get the location of $city');
      }

      final directGeocoding = DirectGeocoding.fromJson(responseBody);

      return directGeocoding;

    } catch (e) {
      rethrow;
    }
  }

  Future<Weather> getWeather(DirectGeocoding directGeocoding) async{
    final Uri uri = Uri(
      scheme: 'https',
      host: kApiHost,
      path: '/data/2.5/weather',
      queryParameters: {
        'lat': '${directGeocoding.lat}',
        'lon': '${directGeocoding.lng}',
        'units': kUnit,
        'appid': "26f712f9fa9f526c0a977b77b69ae853"
      }
    );

    try {
      final http.Response response = await httpClient.get(uri);

      if(response.statusCode != 200){
        throw httpErrorHandler(response);
      }

      final weatherJson = json.decode(response.body);

      final Weather weather = Weather.fromJson(weatherJson);
      return weather;

    } catch (e) {
      rethrow;
    }

  }
}
