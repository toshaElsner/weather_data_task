import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class CommonEvent extends Equatable {

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return super.toString();
  }
}

/// Event to listen data
class Weather extends CommonEvent {
  final String city;
  final BuildContext context;

  Weather(this.city,this.context);
}

