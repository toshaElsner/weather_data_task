import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../events/weather_event.dart';
import '../states/weather_state.dart';
import '../utils/connectivity.dart';
import '../utils/snackbar.dart';

class WeatherBloc extends Bloc<CommonEvent, WeatherStates> {
  /// Stream controller for weather data
  StreamController<Map<String, dynamic>> weatherController =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get weather => weatherController.stream;

  WeatherBloc() : super(Initial()) {
    on<Weather>(fetchWeather);
  }

  /// API for fetch weather data
  fetchWeather(Weather event, Emitter<WeatherStates> emit) async {
    try {
      Response response;
      const apiKey = 'ddc8ddd941a89df28ebaa7df0df8a85a';
      final apiUrl =
          'https://api.openweathermap.org/data/2.5/weather?q=${event.city}&appid=$apiKey&units=metric';
      if (await hasConnectivity()) {
        emit(WeatherLoading());
        // API call
        response = await http.get(Uri.parse(apiUrl));
        var data = json.decode(response.body);
        print("Response - $data");
        if (response.statusCode == 200) {
          weatherController.sink.add(data);
          emit(WeatherSuccess());
          return data;
        } else if (response.statusCode == 404) {
          /// If city name is wrong
          showSnackBar(event.context, data['message'], 3);
          weatherController.sink.addError(data['message']);
          emit(WeatherFailure(errorMsg: data['message']));
        } else {}
      } else {
        showSnackBar(event.context, "Please check internet", 3);
      }
    } catch (exception) {
      print("Error --> ${exception.toString()}");
      weatherController.sink.addError(exception.toString());
      emit(WeatherFailure(errorMsg: exception.toString()));
    }
  }

  /// close stream
  void dispose() {
    weatherController.close();
  }
}
