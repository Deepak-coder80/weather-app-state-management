import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_cubit/repostories/weather_repository.dart';
import 'package:weather_cubit/services/weather_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        elevation: 0,
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
