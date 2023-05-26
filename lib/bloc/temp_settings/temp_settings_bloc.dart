// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'temp_settings_event.dart';
part 'temp_settings_state.dart';

class TempSettingsBloc extends Bloc<TempSettingsEvent, TempSettingState> {
  TempSettingsBloc() : super(TempSettingState.initial()) {
    on<ToogleTempUnitEvent>(_toogleTempUnit);
  }

  FutureOr<void> _toogleTempUnit(ToogleTempUnitEvent event, Emitter<TempSettingState> emit) {
    emit(state.copyWith(
      tempUnit: state.tempUnit == TempUnit.celsius?
                TempUnit.fahrenheit:TempUnit.celsius
    ));
    log('tempunit: $state');
  }
}
