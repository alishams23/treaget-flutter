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

Widget loadingViewCenter() {
  return Center(
    // alignment: Alignment.topCenter,
    child: new CircularProgressIndicator(
      // minHeight: 2.0,
      color: Colors.deepOrange,
      backgroundColor: Colors.grey[100],
    ),
  );
}

Widget loadingViewCenterWhite() {
  return Center(
    // alignment: Alignment.topCenter,
    child: new CircularProgressIndicator(
    
    strokeWidth: 2,
      color: Colors.white,
      backgroundColor: Colors.transparent,
    ),
  );
}

Widget loadingViewBottom() {
  return Align(
    alignment: Alignment.bottomCenter,
    child: new LinearProgressIndicator(
      minHeight: 2.0,
      color: Colors.deepOrange,
      backgroundColor: Colors.grey[100],
    ),
  );
}