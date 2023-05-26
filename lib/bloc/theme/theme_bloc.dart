// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_cubit/constants/constants.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial()) {
    on<ChangeThemeEvent>((event, emit) {
      emit(state.copyWith(appTheme: event.appTheme));
    });
  }

  void setTheme(double currentTemp){
    if(currentTemp>kWarmOrNot){
      add(const ChangeThemeEvent(appTheme: AppTheme.light));
    }else{
      add(const ChangeThemeEvent(appTheme: AppTheme.dark));
    }
  }
}
