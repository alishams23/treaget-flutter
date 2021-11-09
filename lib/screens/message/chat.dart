import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:treaget/components/empty.dart';
import 'package:treaget/components/loading.dart';
import 'package:treaget/global.dart';
import 'package:treaget/services/message_service.dart';

import '../profile.dart';

class Messages extends StatefulWidget {
  Map user;
  Messages({
    @required this.user,
  });
  @override
  State<StatefulWidget> createState() => MessageState();
}

class MessageState extends State<Messages> {
  ScrollController listScrollController = ScrollController();
  List messages = [];
  Timer clockTimer;
  bool sendDataLoading = false;
  bool isLoading = false;
  var text;
  final formKey = GlobalKey<FormState>();

  getAllMessage(
      {int page: 1, bool refresh: false, bool sendData: false}) async {
    setState(() {
      if (refresh == false) isLoading = true;
    });
    var response =
        await MessageApi.getMessage(username: widget.user["username"]);

    setState(() {
      messages.clear();
      messages.addAll(response["data"]);
      isLoading = false;
      if (refresh == false || sendData == true)
        Timer(
            Duration(milliseconds: 100),
            () => listScrollController
                .jumpTo(listScrollController.position.maxScrollExtent));
    });

    // listScrollController.jumpTo(listScrollController.position.maxScrollExtent);
  }

  sendMessage() async {
    setState(() {
      sendDataLoading = true;
    });
    var response = await MessageApi.sendMessageData(
        receiver: widget.user["username"], text: text);
    setState(() {
      sendDataLoading = false;
    });
    if (response["result"] == true) {
      formKey.currentState.reset();
      getAllMessage(refresh: true, sendData: true);
      setState(() {
        text = null;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllMessage();
    clockTimer = Timer.periodic(new Duration(seconds: 3), (timer) {
      getAllMessage(refresh: true);
    });
  }

  @override
  void dispose() {
    clockTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: .4,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
              padding: EdgeInsets.only(right: 16, top: 2),
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => Scaffold(
                              body: Profile(username: widget.user['username']),
                              backgroundColor: Colors.white,
                            ))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        LineIcons.angleLeft,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      backgroundImage: widget.user["image"] != null
                          ? NetworkImage(widget.user["image"])
                          : AssetImage(("assets/images/avatar.png")),
                      maxRadius: 20,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Text(
                        widget.user["get_full_name"],
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Align(
            child: isLoading == true
                ? loadingViewCenter()
                : messages.length == 0
                    ? chatEmpty()
                    : Container(),
          ),
          Align(
            child: ListView.builder(
              itemCount: messages.length,
              padding: EdgeInsets.only(top: 10, bottom: 80),
              controller: listScrollController,
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 5),
                  child: Align(
                    alignment: (messages[index]["author"]["username"] ==
                            widget.user["username"]
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                              bottomRight: Radius.circular(messages[index]
                                          ["author"]["username"] ==
                                      widget.user["username"]
                                  ? 15
                                  : 5),
                              bottomLeft: Radius.circular(messages[index]
                                          ["author"]["username"] ==
                                      widget.user["username"]
                                  ? 5
                                  : 15)),
                          // borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                              colors: messages[index]["author"]["username"] ==
                                      widget.user["username"]
                                  ? [Colors.grey.shade200, Colors.grey.shade300]
                                  : [Color(0xffee0979), Color(0xffff6a00)]),
                        ),
                        padding: EdgeInsets.all(9),
                        child: PopupMenuButton(
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.zero,
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                    onTap: () {
                                      Clipboard.setData(ClipboardData(
                                        text: messages[index]["text"],
                                      ));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBarCopy);
                                    },
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.copy,
                                        color: Colors.black,
                                      ),
                                      title: Text(
                                        " کپی متن",
                                        style: TextStyle(color: Colors.black),
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                  ),
                                ],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  messages[index]["text"],
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: messages[index]["author"]
                                                  ["username"] ==
                                              widget.user["username"]
                                          ? Colors.black
                                          : Colors.white),
                                ),
                                Container(
                                  // padding: EdgeInsets.only(top: 5),
                                  width: 100,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      messages[index]["author"]["username"] !=
                                              widget.user["username"]
                                          ? Icon(
                                              messages[index]["read"] == false
                                                  ? LineIcons.check
                                                  : LineIcons.doubleCheck,
                                              size: 15,
                                              color: messages[index]["author"]
                                                          ["username"] ==
                                                      widget.user["username"]
                                                  ? Colors.grey
                                                  : Colors.white
                                                      .withOpacity(0.6))
                                          : Text(""),
                                      Text(
                                        messages[index]["createdadd"],
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: messages[index]["author"]
                                                        ["username"] ==
                                                    widget.user["username"]
                                                ? Colors.grey
                                                : Colors.white
                                                    .withOpacity(0.6)),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ))),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(left: 8, bottom: 6, right: 8),
              height: 50,
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey[100].withOpacity(0.95),
                        border: Border.all(color: Colors.grey.withOpacity(0.25))
                        // boxShadow: [
                        //   BoxShadow(
                        //     spreadRadius: 1,
                        //     blurRadius: 3,
                        //     color: Colors.black.withOpacity(.1),
                        //   )
                        // ],
                        ),
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        onSaved: (String value) {
                          setState(() {
                            if (value != null && value.isEmpty == false) {
                              text = value;
                            }
                          });
                        },
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                  )),
                  SizedBox(
                    width: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: FloatingActionButton(
                      onPressed: () {
                        formKey.currentState.save();
                        if (text != null && text.isEmpty == false && sendDataLoading == false) {
                          sendMessage();
                        }
                      },
                      child: sendDataLoading == false
                          ? Icon(
                              Icons.send_rounded,
                              color: Color(0xffff6a00),
                              size: 22,
                            )
                          : CircularProgressIndicator(
                              // minHeight: 2.0,
                              color: Colors.deepOrange,
                              backgroundColor: Colors.grey[100],
                            ),
                      backgroundColor: Colors.white,
                      elevation: 7,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
