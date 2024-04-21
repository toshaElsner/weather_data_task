import 'package:flutter/material.dart';

/// Button style Mixin
mixin BlackContainerWhiteTextStyle {
  BoxDecoration blackContainerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
    );
  }

  TextStyle whiteTextStyle() {
    return const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
  }
}