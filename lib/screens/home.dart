import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/global.dart';
import 'package:treaget/models/post_model.dart';
// import 'package:treaget/screens/view_post_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:treaget/services/global_service.dart';
import 'package:treaget/services/home_services.dart';

// ignore: must_be_immutable
class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final snackBar = SnackBar(content: Text('متاسفانه این پست لایک نشد'));
  List _products = [];
  int _currentPage = 1;
  // bool _viewStream = true;
  bool _isLoadingInfo = true;
  Map userInfo;
  bool _isLoading = true;
  ScrollController _listScrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _getPost();
    _getCurrentUserInfo();

    _listScrollController.addListener(() {
      double maxScroll = _listScrollController.position.maxScrollExtent;
      double currentScroll = _listScrollController.position.pixels;

      if (maxScroll - currentScroll <= 200) {
        if (!_isLoading) {
          _getPost(page: _currentPage + 1);
        }
      }
    });
  }

  Widget pictureCard(int index, productsData) {
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
                            productsData.author["username"] != null
                                ? "${productsData.author['image']}"
                                : "assets/images/Gradient.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  productsData.author["username"],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  productsData.createdAdd,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.more_horiz),
                  color: Colors.black,
                  onPressed: () => print('More'),
                ),
              ),
              InkWell(
                  onDoubleTap: () async {
                    var likeTest = await LikePost.likePost(productsData.id);

                    likeTest == true
                        ? setState(() {
                            productsData.likePost();
                          })
                        : ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  onTap: () {
                    setState(() {
                      productsData.visiblity();
                    });
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(10.0),
                          child: Stack(
                            alignment: Alignment.center,
                            fit: StackFit.passthrough,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: CachedNetworkImage(
                                    imageUrl: "${productsData.image}",
                                    fit: BoxFit.fitHeight,
                                    placeholder: (context, url) {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey[400],
                                        highlightColor: Colors.white,
                                        enabled: true,
                                        child: Container(
                                          height: 200,
                                          color: Colors.grey.withOpacity(0.2),
                                          // width: 100,
                                        ),
                                      );
                                    }),
                              ),
                              Visibility(
                                visible: productsData.visible,
                                child: Positioned.fill(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  padding: EdgeInsets.all(20),
                                  alignment: Alignment.bottomCenter,
                                  child: ClipRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 5, sigmaY: 5),
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        height: double.infinity,
                                        child: SingleChildScrollView(
                                          child: Row(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.end,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  "لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد. کتابهای زیادی در شصت و سه درصد گذشته، حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی و فرهنگ پیشرو در زبان فارسی ایجاد کرد. در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                  textDirection:
                                                      TextDirection.rtl,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: Colors.black.withOpacity(.3),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.14),
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
                          icon: Icon(
                            productsData.like == true
                                ? LineIcons.heartAlt
                                : LineIcons.heart,
                            color: productsData.like == true
                                ? Colors.red
                                : Colors.black,
                          ),
                          iconSize: 30.0,
                          onPressed: () async {
                            var likeTest =
                                await LikePost.likePost(productsData.id);
                            // ignore: unrelated_type_equality_checks
                            likeTest == true
                                ? setState(() {
                                    productsData.likePost();
                                  })
                                : ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                          },
                        ),
                        Text(
                          "${productsData.likeCount}",
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

  Widget drawerTop() {
    return Column(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(33.0), //or 15.0
        child: Container(
            height: 90.0,
            width: 90.0,
            color: Colors.black,
            child: Image.network(
              "${userInfo['image']}",
              fit: BoxFit.cover,
            )),
      ),
      Padding(
          padding: EdgeInsets.only(bottom: 9, top: 50, left: 10, right: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              children: [
                Text("دنبال کننده"),
                Text("${userInfo['followers'].length}",
                    style: TextStyle(color: Colors.grey[600]))
              ],
            ),
            Column(
              children: [
                Text(
                  "بازدید",
                  style: TextStyle(color: Colors.grey[900]),
                ),
                Text("${userInfo['visitorCount']}",
                    style: TextStyle(color: Colors.grey[600]))
              ],
            ),
            Column(
              children: [
                Text("دنبال شونده"),
                Text("${userInfo['following'].length}",
                    style: TextStyle(color: Colors.grey[600]))
              ],
            )
          ]))
    ]);
  }

  Widget _buildPost(int index, productsData) {
    print(productsData.item);
    return productsData.item == "request"
        ? Text("data")
        : pictureCard(index, productsData);
  }

  _getPost({int page: 1, bool refresh: false}) async {
    setState(() {
      _isLoading = true;
    });

    var response = await PostService.getPosts(page);
    setState(() {
      if (refresh) _products.clear();
      _products.addAll(response['products']);
      _currentPage = response["current_page"];
      _isLoading = false;
    });
  }

  _getCurrentUserInfo() async {
    var response = await CurrentUserService.information();
    if (response["result"] != false) {
      setState(() {
        _isLoadingInfo = false;
        userInfo = response["result"];
      });
    }
  }

  Widget loadingView() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: new LinearProgressIndicator(
        color: Colors.black,
        backgroundColor: Colors.grey[100],
      ),
    );
  }

  Widget listIsEmpty() {
    return Text('محصولی برای نمایش وجود ندارد');
  }

  Future<Null> _handleRefresh() async {
    await _getPost(refresh: true);
    return null;
  }

  Widget streamListView() {
    print(_products);
    return _products.length == 0 && _isLoading
        ? loadingView()
        : _products.length == 0
            ? listIsEmpty()
            : new RefreshIndicator(
                child: new ListView.builder(
                    controller: _listScrollController,
                    padding: const EdgeInsets.only(top: 0),
                    itemCount: _products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildPost(index, _products[index]);
                    }),
                onRefresh: _handleRefresh);
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
                  _isLoadingInfo != false ? loadingView() : drawerTop()
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
                        onTap: () async {
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          await preferences.remove('user.api_token');
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (_) => false);
                        },
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
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(right: 0),
          child: Builder(
              builder: (context) => Row(
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.clear_all,
                          size: 28,
                        ),
                        onTap: () => Scaffold.of(context).openDrawer(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text("treaget"),
                      )
                    ],
                  )),
        ),
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
      body: streamListView(),

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
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.black,
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
