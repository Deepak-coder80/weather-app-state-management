

// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_cubit/constants/constants.dart';


part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());

  void setTheme(double currentTemp){
    if(currentTemp > kWarmOrNot){
      emit(state.copyWith(appTheme: AppTheme.light));
    }else{
      emit(state.copyWith(appTheme: AppTheme.dark));
    }
  }
}
