import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:line_icons/line_icons.dart';
import 'package:treaget/models/post_model.dart';
import 'package:treaget/screens/view_post_screen.dart';

// ignore: must_be_immutable
class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool _isVisible = true;

  void showDescription() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  Widget _buildPost(int index) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 15.0),
      child: Container(
        // width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 2),
              )
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black45,
                    //     offset: Offset(0.0, 2.0),
                    //     blurRadius: 6.0,
                    //   ),
                    // ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: ClipOval(
                      child: Image(
                        width: 50.0,
                        height: 50.0,
                        image: NetworkImage(
                            "https://picsum.photos/seed/picsum/200/300"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  posts[index].authorName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  posts[index].timeAgo,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.more_horiz),
                  color: Colors.black,
                  onPressed: () => print('More'),
                ),
              ),
              InkWell(
                  onDoubleTap: () => print('Like post'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ViewPostScreen(post: posts[index]),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  "https://picsum.photos/300",
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: Offset(0.0, 7.0),
                                blurRadius: 9.0,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(LineIcons.heart),
                          iconSize: 30.0,
                          onPressed: () => print('Like post'),
                        ),
                        Text(
                          '2,515',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 20.0),
                      ],
                    ),
                    IconButton(
                      icon: Icon(LineIcons.bookmark),
                      iconSize: 30.0,
                      onPressed: () => print('Save post'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPosts() {
    // ignore: deprecated_member_use
    List<Widget> postWidgets = List<Widget>();
    for (int i = 0; i < posts.length; i++) {
      postWidgets.add(_buildPost(i));
    }
    return postWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // extendBodyBehindAppBar: true,
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
              color: Colors.white,
              height: 300,
              child: DrawerHeader(
                  child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(33.0), //or 15.0
                    child: Container(
                        height: 90.0,
                        width: 90.0,
                        color: Colors.black,
                        child: Image.network(
                          "https://treaget.com/media/profile/2021/01/03/66708141_2379602192358271_7304296654685244567_n.jpg",
                          fit: BoxFit.cover,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 9, top: 50, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("دنبال کننده"),
                            Text("2000",
                                style: TextStyle(color: Colors.grey[600]))
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "بازدید",
                              style: TextStyle(color: Colors.grey[900]),
                            ),
                            Text("2000",
                                style: TextStyle(color: Colors.grey[600]))
                          ],
                        ),
                        Column(
                          children: [
                            Text("دنبال شونده"),
                            Text("2000",
                                style: TextStyle(color: Colors.grey[600]))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )),
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(0.0)),
          Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListTile(
                    leading: Icon(LineIcons.values["cog"]),
                    title: Text('تنظیمات'),
                  ),
                  ListTile(
                    leading: Icon(LineIcons.values["userPlus"]),
                    title: Text('دعوت از دوستان'),
                  ),
                  ListTile(
                    leading: Icon(LineIcons.values["questionCircle"]),
                    title: Text('درباره ی ما'),
                  ),
                  Stack(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Icon(LineIcons.fileExport),
                        title: Text('خروج'),
                      ),
                    ],
                  )
                ],
              )),
        ],
      )),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('treaget'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              icon: Icon(
                Icons.chat_bubble_outline,
                size: 25,
              ),
              onPressed: () {
                print("press");
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 5.0),
                    Column(
                      children: _buildPosts(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        /// both default to 16
        marginEnd: 18,
        marginBottom: 20,
        // animatedIcon: AnimatedIcons.menu_close,
        // animatedIconTheme: IconThemeData(size: 22.0),
        /// This is ignored if animatedIcon is non null
        icon: Icons.add,
        activeIcon: Icons.remove,
        // iconTheme: IconThemeData(color: Colors.grey[50], size: 30),
        /// The label of the main button.
        // label: Text("Open Speed Dial"),
        /// The active label of the main button, Defaults to label if not specified.
        // activeLabel: Text("Close Speed Dial"),
        /// Transition Builder between label and activeLabel, defaults to FadeTransition.
        // labelTransitionBuilder: (widget, animation) => ScaleTransition(scale: animation,child: widget),
        /// The below button size defaults to 56 itself, its the FAB size + It also affects relative padding and other elements
        buttonSize: 56.0,
        visible: true,

        /// If true user is forced to close dial manually
        /// by tapping main button and overlay is not rendered.
        closeManually: false,

        /// If true overlay will render no matter what.
        renderOverlay: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.white,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        // tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.deepOrange[700],
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(),
        // orientation: SpeedDialOrientation.Up,
        // childMarginBottom: 2,
        // childMarginTop: 2,
        children: [
          SpeedDialChild(
            child: Icon(
              Icons.accessibility,
              color: Colors.white,
            ),
            backgroundColor: Colors.grey.shade700.withOpacity(0.5),
            label: 'First',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('FIRST CHILD'),
            onLongPress: () => print('FIRST CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: Icon(
              Icons.brush,
              color: Colors.white,
            ),
            backgroundColor: Colors.grey.shade700.withOpacity(0.5),
            label: 'Second',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('SECOND CHILD'),
            onLongPress: () => print('SECOND CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: Icon(
              Icons.keyboard_voice,
              color: Colors.white,
            ),
            backgroundColor: Colors.grey.shade700.withOpacity(0.5),
            label: 'Third',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
            onLongPress: () => print('THIRD CHILD LONG PRESS'),
          ),
        ],
      ),
    );
  }
}
