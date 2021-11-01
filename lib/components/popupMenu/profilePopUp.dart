import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:treaget/global.dart';
import 'package:treaget/screens/add/addOrder.dart';
import 'package:treaget/screens/message/chat.dart';

class PopupMenuButtonProfile extends StatelessWidget {
  var currentUser;
  var userInfo;
  PopupMenuButtonProfile({this.userInfo, this.currentUser});
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
        currentUser["username"] != userInfo["username"]
            ? PopupMenuItem<String>(
                onTap: () => Future(
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => Messages(
                              user: userInfo,
                            )),
                  ),
                ),
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
              )
            : null,
        currentUser["ServiceProvider"] ==false ?PopupMenuItem<String>(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(snackBarUpdate);
          },
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
        ):null,
        currentUser["ServiceProvider"] ==false ?PopupMenuItem<String>(
          child: ListTile(
            onTap: () => Future(
              () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AddOrder(userInfo["username"]),
                ),
              ),
            ),
            leading: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
            ),
            title: Text(
              'ثبت سفارش',
              textDirection: TextDirection.rtl,
            ),
          ),
        ):null,
        // const PopupMenuDivider(),
        PopupMenuItem<String>(
          onTap: () {
            Clipboard.setData(
                ClipboardData(text: "treaget.com/p/${userInfo['username']}/"));
            ScaffoldMessenger.of(context).showSnackBar(snackBarCopy);
          },
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
