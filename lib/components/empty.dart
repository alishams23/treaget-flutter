import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

Widget listIsEmpty() {
  return Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('چیزی برای نمایش وجود ندارد'),
          Icon(LineIcons.exclamationCircle)
        ],
      ));
}

Widget chatEmpty() {
  return Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [Text('گفتگو را آغاز کنید'), Icon(Icons.chat_outlined)],
      ));
}
