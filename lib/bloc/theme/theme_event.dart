part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ChangeThemeEvent extends ThemeEvent {
  final AppTheme appTheme;
  const ChangeThemeEvent({
    required this.appTheme,
  });
}
