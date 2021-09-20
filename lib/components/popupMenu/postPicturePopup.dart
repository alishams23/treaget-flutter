import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class PopupMenuButtonPostPicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Icon(
        Icons.more_horiz,
        color: Colors.black,
      ),
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        
        PopupMenuItem<String>(
          child: ListTile(
            leading: const Icon(
              Icons.share,
              color: Colors.black,
            ),
            title: Text(
              "اشتراک گذاری ",
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          child: ListTile(
            leading: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            title: Text(
              "حذف",
              style: TextStyle(color: Colors.red),
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
      ],
    );
  }
}
