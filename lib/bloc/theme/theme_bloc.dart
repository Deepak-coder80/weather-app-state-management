import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_cubit/bloc/weather/weather_bloc.dart';
import 'package:weather_cubit/constants/constants.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  late StreamSubscription weatherSubscription;
  final WeatherBloc weatherBloc;
  ThemeBloc({required this.weatherBloc}) : super(ThemeState.initial()) {
    weatherSubscription = weatherBloc.stream.listen((WeatherState weatherState){
      if(weatherState.weather.temp> kWarmOrNot){
        add(const ChangeThemeEvent(appTheme: AppTheme.light));
      }else{
        add(const ChangeThemeEvent(appTheme: AppTheme.dark));
      }
    });
    on<ChangeThemeEvent>((event,emit){
      emit(state.copyWith(appTheme: event.appTheme));
    });
  }

  @override
  Future<void> close() {
    weatherSubscription.cancel();
    return super.close();
  }
}
