import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'temp_settings_state.dart';

class TempSettingsCubit extends Cubit<TempSettingState> {
  TempSettingsCubit() : super(TempSettingState.initial());

  void toogleTempUnit(){
    emit(state.copyWith(
      tempUnit: state.tempUnit == TempUnit.celsius?
                TempUnit.fahrenheit:TempUnit.celsius
    ));
    log('tempunit: $state');
  }

}
