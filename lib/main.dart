import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_demo/bloc/weather_bloc.dart';

import 'package:weather_demo/views/weather_check.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather Check App',
        home: MultiBlocProvider(
          /// To Add multiple bloc providers
          providers: [
            BlocProvider<WeatherBloc>(
              create: (context) => WeatherBloc(),
            )
          ],
          child: WeatherCheckPage(),
        ));
  }
}
