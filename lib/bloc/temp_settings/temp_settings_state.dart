part of 'temp_settings_bloc.dart';

enum TempUnit{
  celsius,
  fahrenheit,
}

class TempSettingState extends Equatable {
  final TempUnit tempUnit;
  const TempSettingState({
    this.tempUnit = TempUnit.celsius,
  });

  factory TempSettingState.initial(){
    return const TempSettingState();
  }

  @override
  List<Object> get props => [tempUnit];

  @override
  bool get stringify => true;

  TempSettingState copyWith({
    TempUnit? tempUnit,
  }) {
    return TempSettingState(
      tempUnit: tempUnit ?? this.tempUnit,
    );
  }
}

