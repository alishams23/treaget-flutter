import 'package:flutter/material.dart';
import 'package:treaget/screens/profile.dart';

class NotificationComponent extends StatelessWidget {
  var data;
  NotificationComponent(this.data);
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 1,
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.04)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 3),
            )
          ]),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  child: data["user"] != null
                      ? Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: ()=> Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Scaffold(
                                      body: Profile(
                                          username: data["user"]['username']),
                                      backgroundColor: Colors.white,
                                    ))),
                            child: CircleAvatar(
                              backgroundImage: data["user"]["image"] != null
                                  ? NetworkImage(data["user"]["image"])
                                  : AssetImage(("assets/images/avatar.png")),
                              backgroundColor: Colors.grey[300],
                              radius: 25,
                            ),
                          ))
                      : Text(""),
                )),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topRight,
                              colors: [Colors.red, Colors.deepOrange]),
                        ),
                        height: 20,
                        width: 3,
                      ),
                      Padding(padding: EdgeInsets.only(right: 5)),
                      GestureDetector(
                        child: Text(
                          data["user"]["full_name"],
                          style: TextStyle(fontSize: 15),
                        ),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Scaffold(
                                      body: Profile(
                                          username: data["user"]['username']),
                                      backgroundColor: Colors.white,
                                    ))),
                      ),
                      Padding(padding: EdgeInsets.only(right: 5)),
                      Text(
                        data["user"]['username'],
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8, right: 10),
                    child: Text(
                      data["title"],
                      style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                    ),
                  ),
                ],
              ),
              flex: 8,
            ),
          ],
        ),
      ),
    );
  }
}
