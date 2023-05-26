// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_cubit/cubits/weather/weather_cubit.dart';
import 'package:weather_cubit/pages/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _city;
  // @override
  // void initState() {
  //   _fetchWeather();
  //   super.initState();
  // }

  // void _fetchWeather() {
  //   context.read<WeatherCubit>().fetchWeather('london');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              _city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
              log('city: $_city');
              if (_city != null) {
                context.read<WeatherCubit>().fetchWeather(_city!);
              }
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: showWeather(),
    );
  }

  String showTemp(double temperature) {
    return '${temperature.toStringAsFixed(2)}℃';
  }

  Widget showWeather() {
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (context, state) {
        if (state.status == WeatherStatus.error) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text(state.error.errorMsg),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'OK',
                    ),
                  )
                ],
              );
            },
          );
        }
      },
      builder: (context, state) {
        if (state.status == WeatherStatus.initial) {
          return const Center(
            child: Text(
              'Select a city',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          );
        }
        if (state.status == WeatherStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == WeatherStatus.error && state.weather.name == '') {
          return const Center(
            child: Text(
              'Select a city',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          );
        }

        return ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            Text(
              state.weather.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  TimeOfDay.fromDateTime(state.weather.lastUpdated)
                      .format(context),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '(${state.weather.country})',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  showTemp(state.weather.temp),
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text(
                      showTemp(state.weather.tempMax),
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      showTemp(state.weather.tempMin),
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
