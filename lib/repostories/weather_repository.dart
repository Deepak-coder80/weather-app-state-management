import 'dart:developer';

import 'package:weather_cubit/exceptions/weather_exceptions.dart';
import 'package:weather_cubit/models/custom_error.dart';
import 'package:weather_cubit/models/direct_geocoding.dart';
import 'package:weather_cubit/models/weather.dart';
import 'package:weather_cubit/services/weather_services.dart';

class WeatherRepository {
  final WeatherAPIServices weatherAPIServices;

  WeatherRepository({
    required this.weatherAPIServices,
  });

  Future<Weather> fetchWeather(String city) async {
    try {
      final DirectGeocoding directGeocoding =
          await weatherAPIServices.getDirectGeoCoding(city);

      log('directgeocoding : $directGeocoding');

      final Weather tempWeather =
          await weatherAPIServices.getWeather(directGeocoding);


      final Weather weather  = tempWeather.copyWith(
        name: directGeocoding.name,
        country: directGeocoding.country,
      );
      log('weather: $weather');

      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errorMsg: e.message);
    } catch (e) {
      throw CustomError(errorMsg: e.toString());
    }
  }
}
