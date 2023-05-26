import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_cubit/cubits/temp_settings/temp_settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10,
        ),
        child: ListTile(
          title: const Text('Temperature Unit'),
          subtitle: const Text('Celsius/Fahrenheit (Defalut: Celsius)'),
          trailing: Switch(
            value: context.watch<TempSettingsCubit>().state.tempUnit == TempUnit.celsius,
            onChanged: (_){
                context.read<TempSettingsCubit>().toogleTempUnit();
            },
          ),
        ),
      ),
    );
  }
}
