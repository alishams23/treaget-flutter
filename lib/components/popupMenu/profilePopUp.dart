import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class PopupMenuButtonProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            )),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.2)),
          ),
          
          child: Icon(
            LineIcons.horizontalEllipsis,
            color: Colors.black,
          )),
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          child: ListTile(
            leading: const Icon(
              Icons.chat_bubble_outline,
              color: Colors.black,
            ),
            title: Text(
              "ارسال پیام",
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
        PopupMenuItem<String>(
          child: ListTile(
            leading: const Icon(
              Icons.payment,
              color: Colors.black,
            ),
            title: Text(
              "پرداخت امن",
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
        PopupMenuItem<String>(
          child: ListTile(
            leading: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
            ),
            title: Text(
              'ثبت سفارش',
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          child: ListTile(
            leading: const Icon(
              Icons.share,
              color: Colors.blue,
            ),
            title: Text(
              "اشتراک گذاری پروفایل",
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
      ],
    );
  }
}
