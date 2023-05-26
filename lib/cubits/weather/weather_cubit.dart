// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:weather_cubit/models/custom_error.dart';
import 'package:weather_cubit/models/weather.dart';
import 'package:weather_cubit/repostories/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherCubit({
    required this.weatherRepository,
  }) : super(WeatherState.initial());

  Future<void> fetchWeather(String city) async {
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final Weather weather = await weatherRepository.fetchWeather(city);
      emit(state.copyWith(
        status: WeatherStatus.loaded,
        weather: weather,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        status: WeatherStatus.error,
        error: e,
      ));
    }
    log('state: $state');
  }
}
