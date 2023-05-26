import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_cubit/bloc/temp_settings/temp_settings_bloc.dart';
import 'package:weather_cubit/bloc/theme/theme_bloc.dart';
import 'package:weather_cubit/bloc/weather/weather_bloc.dart';

import 'package:weather_cubit/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_cubit/repostories/weather_repository.dart';
import 'package:weather_cubit/services/weather_services.dart';
import 'package:http/http.dart' as http;

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
        weatherAPIServices: WeatherAPIServices(
          httpClient: http.Client(),
        ),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(
              weatherRepository: context.read<WeatherRepository>(),
            ),
          ),
          BlocProvider<TempSettingsBloc>(
            create: (context) => TempSettingsBloc(),
          ),
          BlocProvider<ThemeBloc>(
            create: (context) =>
                ThemeBloc(weatherBloc: context.read<WeatherBloc>()),
          ),
        ],
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {},
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                title: 'Weather Bloc',
                debugShowCheckedModeBanner: false,
                theme: state.appTheme == AppTheme.light
                    ? ThemeData.light()
                    : ThemeData.dark(),
                home: const HomePage(),
              );
            },
          ),
        ),
      ),
    );
  }
}
