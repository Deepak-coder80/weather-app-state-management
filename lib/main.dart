import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_cubit/cubits/temp_settings/temp_settings_cubit.dart';
import 'package:weather_cubit/cubits/weather/weather_cubit.dart';
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
          BlocProvider<WeatherCubit>(
            create: (context) => WeatherCubit(
              weatherRepository: context.read<WeatherRepository>(),
            ),
          ),
          BlocProvider<TempSettingsCubit>(
            create: (context)=>TempSettingsCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'Weather Cubit',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
