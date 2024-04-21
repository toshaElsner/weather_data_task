import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Show snackbar
showSnackBar(BuildContext context, String msg, time) {
  var snackBar = SnackBar(
    content: Text(msg),
    duration: Duration(seconds: time),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}