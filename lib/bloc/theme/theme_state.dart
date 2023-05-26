part of 'theme_bloc.dart';

enum AppTheme{
  light,
  dark,
}

class ThemeState extends Equatable {
  final AppTheme appTheme;
  const ThemeState({
     this.appTheme = AppTheme.light,
  });

  factory ThemeState.initial(){
    return const ThemeState();
  }

  @override
  List<Object> get props => [appTheme];

  ThemeState copyWith({
    AppTheme? appTheme,
  }) {
    return ThemeState(
      appTheme: appTheme ?? this.appTheme,
    );
  }

  @override
  bool get stringify => true;
}

