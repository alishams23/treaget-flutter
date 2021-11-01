import 'dart:async';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:treaget/components/empty.dart';
import 'package:treaget/components/loading.dart';
import 'package:treaget/services/message_service.dart';

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
  bool isLoading = false;
  var text;
  final formKey = GlobalKey<FormState>();

  getAllMessage({int page: 1, bool refresh: false}) async {
    setState(() {
      if (refresh == false) isLoading = true;
    });
    var response =
        await MessageApi.getMessage(username: widget.user["username"]);

    setState(() {
      messages.clear();
      messages.addAll(response["data"]);
      isLoading = false;
      if (refresh == false) Timer(
          Duration(milliseconds: 100),
          () => listScrollController
              .jumpTo(listScrollController.position.maxScrollExtent));
    });

    // listScrollController.jumpTo(listScrollController.position.maxScrollExtent);
  }

  sendMessage() async {
    var response = await MessageApi.sendMessageData(
        receiver: widget.user["username"], text: text);
    if (response["result"] == true) {
      formKey..currentState.reset();
      getAllMessage(refresh: true);
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
        elevation: 0.3,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: widget.user["image"] != null
                      ? NetworkImage(widget.user["image"])
                      : AssetImage(("assets/images/avatar.png")),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.user["get_full_name"],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          widget.user["bio"] == null
                              ? "..."
                              : widget.user["bio"],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Align(
            child: isLoading == true
                ? loadingViewCenter()
                : messages.length == 0
                    ? listIsEmpty()
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
                      EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (messages[index]["author"]["username"] ==
                            widget.user["username"]
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                              colors: messages[index]["author"]["username"] ==
                                      widget.user["username"]
                                  ? [Colors.grey.shade200, Colors.grey.shade300]
                                  : [Colors.deepOrange, Colors.orange[800]]),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              messages[index]["text"],
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: messages[index]["author"]
                                              ["username"] ==
                                          widget.user["username"]
                                      ? Colors.black
                                      : Colors.white),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5),
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
                                              ? Colors.black
                                              : Colors.white,
                                        )
                                      : Text(""),
                                  Text(
                                    messages[index]["createdadd"],
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: messages[index]["author"]
                                                    ["username"] ==
                                                widget.user["username"]
                                            ? Colors.black
                                            : Colors.white),
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    color: Colors.black.withOpacity(.2),
                  )
                ],
              ),
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
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
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      formKey.currentState.save();
                      if (text != null && text.isEmpty == false) {
                        sendMessage();
                      }
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.black,
                    elevation: 0,
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
