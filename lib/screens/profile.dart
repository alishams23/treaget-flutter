import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treaget/components/indicator_tab.dart';
import 'package:treaget/components/indicator_tab_circle.dart';
import 'package:treaget/components/loading.dart';
import 'package:treaget/components/popupMenu/profilePopUp.dart';
import 'package:treaget/components/profile/sampleProfile.dart';
import 'package:treaget/components/request.dart';
import 'package:treaget/screens/profile/services.dart';
import 'package:treaget/screens/profile/timeLine.dart';
import 'package:treaget/screens/setting.dart';
import 'package:treaget/services/Picture_service.dart';
import 'package:treaget/services/auth_services.dart';
import 'package:treaget/services/profile_service.dart';
import 'package:treaget/services/request_service.dart';

import 'PostPicture.dart';
import 'add/addOrder.dart';
import 'add/addOrderService.dart';
import 'add/addPicture.dart';
import 'message/chat.dart';

class Profile extends StatefulWidget {
  String username;
  Profile({Key key, this.username: ""}) : super(key: key);

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  List _products = [];
  List favorite = [];
  List resume = [];
  List service = [];
  List request = [];
  Map info = {};
  Map currentUser = {};
  
  final ImagePicker _picker = ImagePicker();

  int _currentPage = 1;
  bool _isLoading = true;

  ScrollController _scrollController;

  Future<Null> _handleRefresh() async {
    await _getPost(refresh: true);
    return null;
  }

  Future<Null> _handleRefreshFavorite() async {
    await getFavorite(refresh: true);
    return null;
  }

  Future<Null> _handleRefreshRequest() async {
    await getRequest(refresh: true);
    return null;
  }

  Future<Null> _handleRefreshService() async {
    await getService();
    return null;
  }

  Future<Null> _handleRefreshResume() async {
    await _getResume();
    return null;
  }

  _getPost({int page: 1, bool refresh: false}) async {
    setState(() {
      _isLoading = true;
    });

    var response = await PictureApi.getListPosts(
        username: widget.username != "" ? widget.username : "");
    setState(() {
      if (refresh) _products.clear();
      _products.addAll(response['products']);
      _currentPage = response["current_page"];
      _isLoading = false;
    });
  }

  _getInformaion({bool refresh: false}) async {
    setState(() {
      _isLoading = true;
    });
    var response = await InformationProfileService.getInfo(
        username: widget.username != "" ? widget.username : "");
    setState(() {
      info.clear();
      info.addAll(response);
      _isLoading = false;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var currentUserUsername = prefs.getString('user.username');
    currentUser =
        await InformationProfileService.getInfo(username: currentUserUsername);
    if (info["ServiceProvider"] == true) {
      _getPost(refresh: refresh);
      _getResume(refresh: refresh);
      getService(refresh: refresh);
    } else {
      getFavorite(refresh: refresh);
      getRequest(refresh: refresh);
    }
  }

  getService({bool refresh: false}) async {
    setState(() {
      _isLoading = true;
    });
    var response = await ServiceProfileService.getService(
        username: widget.username != "" ? widget.username : "");
    setState(() {
      service.clear();
      service.addAll(response['data']);
      _isLoading = false;
    });
  }

  getRequest({bool refresh: false}) async {
    setState(() {
      _isLoading = true;
    });
    var response = await RequestApi.getListRequest(
        username: widget.username != "" ? widget.username : "");
    setState(() {
      request.clear();
      request.addAll(response['data']);
      _isLoading = false;
    });
  }

  getFavorite({bool refresh: false}) async {
    setState(() {
      _isLoading = true;
    });

    var response = await PictureApi.getListFavorite(
        username: widget.username != "" ? widget.username : "");

    setState(() {
      favorite.clear();
      favorite.addAll(response['picture']);
      _isLoading = false;
    });
  }

  _getResume({bool refresh: false}) async {
    setState(() {
      _isLoading = true;
    });
    var response = await TimelineProfileService.getResume(
        username: widget.username != "" ? widget.username : "");
    setState(() {
      resume.clear();
      resume.addAll(response['data']);
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getInformaion();
  }

  Widget listIsEmpty() {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            padding: EdgeInsets.only(top: 40),
            alignment: Alignment.center,
            child: Text('چیزی برای نمایش وجود ندارد'));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        body: Container(
          child: DefaultTabController(
            length:
                (info.length != 0 && info["ServiceProvider"] == true) ? 3 : 2,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: info.length != 0
                        ? [
                            TabBar(
                              isScrollable: false,
                              unselectedLabelColor: Colors.grey[400],
                              indicator: MD2Indicator(
                                indicatorSize: MD2IndicatorSize.normal,
                                indicatorHeight: 3,
                                indicatorColor: Colors.black,
                              ),
                              tabs: (info.length != 0 &&
                                      info["ServiceProvider"] == true)
                                  ? [
                                      Tab(
                                        icon: Icon(Icons.dashboard_outlined),
                                      ),
                                      Tab(
                                        icon:
                                            Icon(Icons.assignment_ind_outlined),
                                      ),
                                      Tab(
                                        icon: Icon(Icons.store_outlined),
                                      ),
                                    ]
                                  : [
                                      Tab(
                                        icon: Icon(Icons.shopping_bag),
                                      ),
                                      Tab(
                                        icon: Icon(LineIcons.heartAlt),
                                      ),
                                    ],
                            ),
                            Divider(height: 0, color: Colors.grey[300])
                          ]
                        : [],
                  )),
              body: TabBarView(
                children: (info.length != 0 && info["ServiceProvider"] == true)
                    ? [
                        _products.length == 0 && _isLoading
                            ? loadingView()
                            : _products.length == 0
                                ? RefreshIndicator(
                                    onRefresh: _handleRefresh,
                                    child: listIsEmpty())
                                : Scaffold(
                                    backgroundColor: Colors.white,
                                    floatingActionButton: currentUser[
                                                "ServiceProvider"] ==
                                            false
                                        ? FloatingActionButton.extended(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                      builder: (context) =>
                                                          AddOrder(info[
                                                              "username"])));
                                            },
                                            label: Text("سفارش"),
                                            icon: Icon(
                                                Icons.shopping_bag_outlined),
                                            foregroundColor: Colors.black,
                                            backgroundColor: Colors.grey[200],
                                          )
                                        : currentUser["username"] ==
                                                info["username"]
                                            ? FloatingActionButton.extended(
                                                onPressed: () async {
                                                  var imageAdd =
                                                      await _picker.pickImage(
                                                          source: ImageSource
                                                              .gallery);

                                                  imageAdd != null
                                                      ? await Navigator.push(
                                                          context,
                                                          CupertinoPageRoute(
                                                              builder: (context) =>
                                                                  AddPicture(
                                                                      imageFile:
                                                                          imageAdd)))
                                                      : print("");
                                                },
                                                label: Text("افزودن نمونه کار"),
                                                icon: Icon(
                                                  Icons.dashboard_outlined,
                                                ),
                                                foregroundColor: Colors.black,
                                                backgroundColor:
                                                    Colors.grey[200],
                                              )
                                            : Container(),
                                    body: RefreshIndicator(
                                        onRefresh: _handleRefresh,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 0, left: 10, right: 10),
                                          child: StaggeredGridView.countBuilder(
                                            crossAxisCount: 4,
                                            mainAxisSpacing: 4,
                                            crossAxisSpacing: 4,
                                            itemCount: _products.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                        builder: (context) =>
                                                            PostPicture(
                                                          data:
                                                              _products[index],
                                                        ),
                                                      ));
                                                },
                                                child: (index == 0 ||
                                                        index == 1)
                                                    ? Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 15),
                                                        child: SampleProfile(
                                                            index,
                                                            _products[index]),
                                                      )
                                                    : SampleProfile(index,
                                                        _products[index]),
                                              );
                                            },
                                            staggeredTileBuilder: (index) =>
                                                const StaggeredTile.fit(2),
                                          ),
                                        )),
                                  ),
                        RefreshIndicator(
                            onRefresh: _handleRefreshResume,
                            child: resume.length == 0 && _isLoading
                                ? loadingView()
                                : resume.length == 0
                                    ? listIsEmpty()
                                    : Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: ListView.builder(
                                          itemCount: resume.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return TimeLineProfile(
                                                index: index,
                                                data: resume[index]);
                                          },
                                        ))),
                        RefreshIndicator(
                            onRefresh: _handleRefreshService,
                            child: service.length == 0 && _isLoading
                                ? loadingView()
                                : service.length == 0
                                    ? listIsEmpty()
                                    : Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: ListView.builder(
                                          itemCount: service.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Services(
                                                service[index],
                                                currentUser,
                                                _handleRefreshService);
                                          },
                                        ),
                                      ))
                      ]
                    : [
                        RefreshIndicator(
                            onRefresh: _handleRefreshRequest,
                            child: request.length == 0 && _isLoading
                                ? loadingView()
                                : request.length == 0
                                    ? listIsEmpty()
                                    : Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: ListView.builder(
                                          itemCount: request.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return RequestCardComponent(
                                                request[index], currentUser);
                                          },
                                        ))),
                        favorite.length == 0 && _isLoading
                            ? loadingView()
                            : favorite.length == 0
                                ? RefreshIndicator(
                                    onRefresh: _handleRefreshFavorite,
                                    child: listIsEmpty())
                                : Scaffold(
                                    backgroundColor: Colors.white,
                                    body: RefreshIndicator(
                                        onRefresh: _handleRefreshFavorite,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 0, left: 10, right: 10),
                                          child: StaggeredGridView.countBuilder(
                                            crossAxisCount: 4,
                                            mainAxisSpacing: 4,
                                            crossAxisSpacing: 4,
                                            itemCount: favorite.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                        builder: (context) =>
                                                            PostPicture(
                                                          data: favorite[index],
                                                        ),
                                                      ));
                                                },
                                                child: (index == 0 ||
                                                        index == 1)
                                                    ? Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 15),
                                                        child: SampleProfile(
                                                            index,
                                                            favorite[index]),
                                                      )
                                                    : SampleProfile(
                                                        index, favorite[index]),
                                              );
                                            },
                                            staggeredTileBuilder: (index) =>
                                                const StaggeredTile.fit(2),
                                          ),
                                        )),
                                  )
                      ],
              ),
            ),
          ),
        ),
        controller: _scrollController,
        headerSliverBuilder: (context, value) {
          return [topPage(info, currentUser, context, _getInformaion)];
        });
  }
}

Widget topPage(Map info, currentUser, context, _getInformaion) {
  return SliverToBoxAdapter(
    child: Container(
      child: Column(
        children: [
          AppBar(
            elevation: 0,
            title: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 8,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                          padding: EdgeInsets.only(right: 30),
                          child: Directionality(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  info.length != 0 ? info['get_full_name'] : '',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  info.length != 0 ? info['username'] : ' ',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                                info.length != 0
                                    ? Padding(
                                        padding: EdgeInsets.only(left: 50),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 0),
                                                    child:
                                                        PopupMenuButtonProfile(
                                                         
                                                           userInfo: info,
                                                           currentUser: currentUser))),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 6)),
                                            Expanded(
                                                flex: 7,
                                                child: Container(
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      if (currentUser.length !=
                                                              0 &&
                                                          info["username"] ==
                                                              currentUser[
                                                                  "username"]) {
                                                        Navigator.push(
                                                            context,
                                                            CupertinoPageRoute(
                                                                builder: (context) => Directionality(
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
                                                                    child:
                                                                        Setting())));
                                                      } else {
                                                        var resultFollow =
                                                            await ProfileService
                                                                .follow(
                                                                    username: info[
                                                                        "username"]);
                                                        if (resultFollow[
                                                                "data"] ==
                                                            true)
                                                          _getInformaion(
                                                              refresh: true);
                                                      }
                                                    },
                                                    style: ButtonStyle(
                                                      shadowColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .transparent),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .transparent),
                                                      padding:
                                                          MaterialStateProperty
                                                              .all(EdgeInsets
                                                                  .all(0)),
                                                    ),
                                                    child: Container(
                                                      width: 300,
                                                      decoration:
                                                          new BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors:
                                                              info["is_followed"] ==
                                                                      true
                                                                  ? [
                                                                      Colors
                                                                          .black,
                                                                      Colors.grey[
                                                                          800]
                                                                    ]
                                                                  : [
                                                                      Color(
                                                                          0xff004e92),
                                                                      Color(
                                                                          0xff0664bb)
                                                                    ],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
                                                            spreadRadius: 1,
                                                            blurRadius: 19,
                                                            offset:
                                                                Offset(0, 9),
                                                          )
                                                        ],
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Text(
                                                        (currentUser.length !=
                                                                    0 &&
                                                                info["username"] ==
                                                                    currentUser[
                                                                        "username"])
                                                            ? "تنظیمات"
                                                            : info["is_followed"] ==
                                                                    true
                                                                ? "لغو دنبال کردن"
                                                                : "دنبال کردن",
                                                        style: TextStyle(
                                                            fontSize: 13),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                            textDirection: TextDirection.ltr,
                          )),
                    )),
                Expanded(
                  flex: 4,
                  child: Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: GestureDetector(
                        onTap: () async {
                          if (info["username"] == currentUser["username"]) {
                            final picker = ImagePicker();
                            var pickedFile = await picker.pickImage(
                                source: ImageSource.gallery);
                            File croppedFile = await ImageCropper.cropImage(
                                sourcePath: pickedFile.path,
                                aspectRatioPresets: [
                                  CropAspectRatioPreset.square,
                                ],
                                androidUiSettings: AndroidUiSettings(
                                    toolbarTitle: 'Cropper',
                                    toolbarColor: Colors.white,
                                    toolbarWidgetColor: Colors.black,
                                    initAspectRatio:
                                        CropAspectRatioPreset.original,
                                    lockAspectRatio: false),
                                iosUiSettings: IOSUiSettings(
                                  title: 'Cropper',
                                ));
                            var resultUpload =
                                await AuthService.addPictureProfile(
                                    image: croppedFile);
                            if (resultUpload["result"] == true)
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "/profile", (_) => false);
                          }
                        },
                        child: Container(
                            child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(43.0),
                                  child: Container(
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        spreadRadius: 1,
                                        blurRadius: 19,
                                        offset: Offset(0, 9),
                                      )
                                    ]),
                                    child: info.length != 0
                                        ? info['image'] != null
                                            ? Image.network(
                                                info['image'],
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                "assets/images/avatar.png",
                                                fit: BoxFit.cover,
                                              )
                                        : Image.asset(
                                            "assets/images/avatar.png",
                                            fit: BoxFit.cover,
                                          ),
                                  ))),
                        )),
                      )),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 40, right: 40, top: 20),
            child: Text(
              (info.length != 0 && info['bio'] != null) ? info['bio'] : ' ',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      info.length != 0 ? '${info["followers"].length}' : '0',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "دنبال کننده",
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                )),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.0),
                      color: Colors.grey[100]),
                  height: 37,
                  width: 2,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      info.length != 0 ? '${info["following"].length}' : '0',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "دنبال شونده",
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
