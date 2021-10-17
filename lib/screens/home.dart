 
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/components/loading.dart';
// import 'package:treaget/screens/view_post_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:treaget/components/popupMenu/postPicturePopup.dart';
import 'package:treaget/components/popupMenu/postRequestPopup.dart';
import 'package:treaget/components/request.dart';
import 'package:treaget/screens/add/addRequest.dart';
import 'package:treaget/screens/profile.dart';
import 'package:treaget/services/global_service.dart';
import 'package:treaget/services/home_services.dart';
import 'package:validators/validators.dart';
import 'PostPicture.dart';
import 'add/addPicture.dart';
import 'add/addResume.dart';
import 'add/addService.dart';

// ignore: must_be_immutable
class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final snackBar = SnackBar(content: Text('متاسفانه این پست لایک نشد'));
  List _products = [];
  int _currentPage = 1;
    final ImagePicker _picker = ImagePicker();
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
      padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 15.0),
      child: Container(
        // width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(23.0),
            border: Border.all(color: Colors.grey[200]),
         boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3),
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
              onDoubleTap: () async {
                var likeTest = await LikePost.likePost(productsData.id);

                likeTest == true
                    ? setState(() {
                        productsData.likePost();
                      })
                    : ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => PostPicture(
                        data: productsData,
                      ),
                    ));
              },
              child: Container(
                width: double.infinity,
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
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
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                          padding: EdgeInsets.only(bottom: 10, right: 10),
                          alignment: Alignment.topRight,
                          width: 120,
                          height: 60,
                          child: Container(
                              child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(19.0),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: Container(
                                  width: 100,
                                  padding: EdgeInsets.all(0),
                                  child: Row(
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
                                        iconSize: 24.0,
                                        onPressed: () async {
                                          var likeTest =
                                              await LikePost.likePost(
                                                  productsData.id);
                                          // ignore: unrelated_type_equality_checks
                                          likeTest == true
                                              ? setState(() {
                                                  productsData.likePost();
                                                })
                                              : ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(LineIcons.bookmark),
                                        iconSize: 27.0,
                                        onPressed: () => print(productsData.id ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white.withOpacity(0.2)),
                                    borderRadius: BorderRadius.circular(19.0),
                                    color: Colors.white.withOpacity(.2),
                                  ),
                                ),
                              ),
                            ),
                          ))),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 10, left: 10),
                        alignment: Alignment.topLeft,
                        width: 100,
                        height: 60,
                        child: Container(
                            child: Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(13.0),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                padding: EdgeInsets.all(4),
                                child:  userInfo != null  ? PopupMenuButtonPostPicture(productsData,userInfo ) :Text(""),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.1)),
                                  borderRadius: BorderRadius.circular(13.0),
                                  color: Colors.white.withOpacity(.2),
                                ),
                              ),
                            ),
                          ),
                        )))
                  ],
                ),
              ),
            ),
            productsData.alt != null
                ? Container(
                    padding: EdgeInsets.only(top: 12, right: 20),
                    child: Text(
                      productsData.alt,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 17),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  )
                : Text(""),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          child: CircleAvatar(
                            radius: 21,
                            backgroundColor: Colors.grey[300],
                            child: ClipOval(
                              child: productsData.author["image"] != null
                                  ? Image(
                                      image: NetworkImage(
                                          "${productsData.author['image']}"),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                          ),
                          onTap: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => Scaffold(
                                        body: Profile(
                                            username: productsData
                                                .author['username']),
                                        backgroundColor: Colors.white,
                                      )))),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                      ),
                      Column(
                        children: [
                          Text(
                            productsData.author["username"],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            productsData.createdAdd,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 17, vertical: 7),
                    child: Row(
                      children: [
                        productsData.likeUser.length >=3 ?
                        Stack(
                          children: [
                            Positioned(
                                right: 7,
                                child: CircleAvatar(
                                  backgroundImage: productsData
                                              .likeUser.length >=
                                          3
                                      ? productsData.likeUser[2]["image"] !=
                                              null
                                          ? NetworkImage(
                                              productsData.likeUser[2]["image"])
                                          : null
                                      : null,
                                  radius: 14,
                                  backgroundColor: Colors.grey[200],
                                )),
                            Positioned(
                                right: 21,
                                child: CircleAvatar(
                                  backgroundImage: productsData
                                              .likeUser.length >=2
                                      ? productsData.likeUser[1]["image"] !=
                                              null
                                          ? NetworkImage(
                                              productsData.likeUser[1]["image"])
                                          : null
                                      : null,
                                  radius: 14,
                                  backgroundColor: Colors.orange[200],
                                )),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 32)),
                            Positioned(
                                child: CircleAvatar(
                              backgroundImage: productsData.likeUser.length >= 1
                                  ? productsData.likeUser[0]["image"] != null
                                      ? NetworkImage(
                                          productsData.likeUser[0]["image"])
                                      : null
                                  : null,
                              radius: 14,
                              backgroundColor: Colors.deepOrange[400],
                            ))
                          ],
                        ):Container(),
                        Padding(padding: EdgeInsets.only(right: 1)),
                        CircleAvatar(
                          child: Text(
                            "${productsData.likeUser.length}",
                            style: TextStyle(fontSize: 13),
                          ),
                          radius: 14,
                          backgroundColor: Colors.orange[50],
                          foregroundColor: Colors.deepOrange,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }



  Widget drawerTop() {
    return Column(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(40.0), //or 15.0
        child: Container(
            height: 90.0,
            width: 90.0,
            color: Colors.black,
            child: userInfo['image'] != null
                ? Image.network(
                    "${userInfo['image']}",
                    fit: BoxFit.cover,
                  )
                : Image.asset("assets/images/avatar.png")),
      ),
      Padding(
          padding: EdgeInsets.only(bottom: 0, top: 50, left: 10, right: 10),
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
        ? RequestCardComponent(productsData,userInfo)
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

  Widget listIsEmpty() {
    return Text('محصولی برای نمایش وجود ندارد');
  }

  Future<Null> _handleRefresh() async {
    await _getPost(refresh: true);
    return null;
  }

  Widget streamListView() {
    return Stack(
      children: [
        _products.length == 0 && _isLoading
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
                    onRefresh: _handleRefresh),
        _products.length != 0 && _isLoading ? loadingView() : Text("")
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      // extendBodyBehindAppBar: true,

      drawer: Drawer(
        // elevation: 80,
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
              color: Colors.white,
              height: 250,
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
        elevation: 0.5,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(right: 0),
          child: Builder(
              builder: (context) => Row(
                    children: [
                      GestureDetector(
                        child: Icon(
                          LineIcons.bars,
                          size: 24,
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
        // animatedIcon: AnimatedIcons,
        animatedIconTheme: IconThemeData(size: 22.0),

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
        overlayOpacity: 0.9,
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
        childMarginTop: 2,
        children: userInfo != null ? userInfo["ServiceProvider"] == true ? [
          SpeedDialChild(
            child: Icon(
              Icons.store_outlined,
              color: Colors.deepOrange,
            ),
            // backgroundColor: Colors.grey.shade700.withOpacity(0.5),
            label: '  افزودن خدمات     ',
            // labelStyle: TextStyle(fontSize: 18.0),
            onTap: () =>  Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => AddService())),
            onLongPress: () => print('FIRST CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: Icon(
              Icons.assignment_ind_outlined,
              color: Colors.deepOrange,
            ),
            // backgroundColor: Colors.white,
            label: '  افزودن رزومه   ',
            // labelStyle: TextStyle(fontSize: 18.0),
            onTap: () =>  Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => AddResume())),
            
          ),
          SpeedDialChild(
            child: Icon(
              Icons.dashboard_outlined,
              color: Colors.deepOrange,
            ),
            // backgroundColor: ,
            label: '  افزودن نمونه کار',
            // labelStyle: TextStyle(fontSize: 18.0),
            onTap: () async{ var imageAdd =await _picker.pickImage(source: ImageSource.gallery);
           
            imageAdd != null ? await Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => AddPicture(imageFile:imageAdd))):print("");
                      },
                      
            onLongPress: () => print('THIRD CHILD LONG PRESS'),
          ),
        ]:[ SpeedDialChild(
            child: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.deepOrange,
            ),
            // backgroundColor: ,
            label: 'افزودن درخواست     ',
            // labelStyle: TextStyle(fontSize: 18.0),
            onTap: () { 
           
           Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => AddRequest()));
                      },
          ),]:[],
      ),
    );
  }
}
