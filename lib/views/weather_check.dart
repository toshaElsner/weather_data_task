import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_demo/events/weather_event.dart';
import 'package:weather_demo/states/weather_state.dart';
import 'package:weather_demo/utils/button_mixin.dart';
import 'package:weather_demo/utils/colors.dart';
import 'package:weather_demo/utils/common_widget.dart';

import '../bloc/weather_bloc.dart';
import '../utils/snackbar.dart';

class WeatherCheckPage extends StatefulWidget {
  @override
  _WeatherCheckPageState createState() => _WeatherCheckPageState();
}

class _WeatherCheckPageState extends State<WeatherCheckPage>
    with BlackContainerWhiteTextStyle {
  WeatherBloc? _bloc;
  final _cityController = TextEditingController();
  var weatherData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = BlocProvider.of<WeatherBloc>(context);

    /// Listen stream data
    _bloc!.weatherController.stream.asBroadcastStream().listen((data) {
      print("Listen Data  - $data");
      weatherData = data;
    });
  }

  @override
  void dispose() {
    _bloc!.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,

      /// Button to get data
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            if (_cityController.text.isEmpty || _cityController.text == "") {
              showSnackBar(context, "Please enter city", 3);
            } else {
              _bloc!.add(Weather(_cityController.text, context));
            }
          },
          child: Container(
            height: 60,
            decoration: blackContainerDecoration(),
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            alignment: Alignment.center,
            child: Text(
              'Get Weather',
              style: whiteTextStyle(),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        title: const Text(
          'Weather App',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 20, // Adjust the size as needed
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter city name to check weather data',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            CommonWidgets.sizedBox10,

            /// Enter city name field
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: AppColors.lightBlueColorAccent[100],
              ),
              child: TextField(
                controller: _cityController,
                decoration: const InputDecoration(
                  hintText: 'Enter city name',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
            ),
            const Spacer(),

            /// Displaying weather data Widget
            displayData(),
            CommonWidgets.sizedBox20
          ],
        ),
      ),
    );
  }

  /// Displaying weather data Widget
  Widget displayData() {
    return BlocBuilder<WeatherBloc, WeatherStates>(builder: (context, state) {
      if (state is WeatherLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is WeatherSuccess) {
        /// API Success
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Weather Details',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 20, // Adjust the size as needed
              ),
            ),
            CommonWidgets.sizedBox20,
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.lightBlueColorAccent, AppColors.lightBlueColor],
                ),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Temperature: ${weatherData!['main']['temp'].toDouble()}°C',
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CommonWidgets.sizedBox10,
                  Text(
                    'Weather: ${weatherData['weather'][0]['main']}',
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      } else {
        /// API Failure - error will be displayed in snackbar
        return Container();
      }
    });
  }
}
