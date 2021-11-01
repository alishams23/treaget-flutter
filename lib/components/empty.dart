  import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

Widget listIsEmpty() {
    
        return Container(

            padding: EdgeInsets.only(top: 100,right: 20,left: 20),
            alignment: Alignment.center,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [Text('چیزی برای نمایش وجود ندارد') , Icon(LineIcons.exclamationCircle)],));
     
  }