import 'package:equatable/equatable.dart';

abstract class WeatherStates extends Equatable {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return super.toString();
  }
}

/// Initial state
class Initial extends WeatherStates {
  Initial();
  @override
  String toString() {
    return super.toString();
  }
}

/// Loading state
class WeatherLoading extends WeatherStates {
  WeatherLoading();
  @override
  String toString() {
    return super.toString();
  }
}

/// Success state
class WeatherSuccess extends WeatherStates {
  WeatherSuccess();
  @override
  String toString() {
    return super.toString();
  }
}

/// Failure state with error message
class WeatherFailure extends WeatherStates {
  String? errorMsg;
  WeatherFailure({
    this.errorMsg,
  });
  @override
  String toString() {
    return super.toString();
  }
}
