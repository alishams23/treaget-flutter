import 'package:flutter/material.dart';

Widget loadingView() {
  return Align(
    alignment: Alignment.topCenter,
    child: new LinearProgressIndicator(
      minHeight: 2.0,
      color: Colors.deepOrange,
      backgroundColor: Colors.grey[100],
    ),
  );
}
