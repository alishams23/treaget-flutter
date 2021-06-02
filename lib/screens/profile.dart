// import 'dart:html';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:treaget/screens/profile/services.dart';
import 'package:treaget/screens/profile/timeLine.dart';

class IntSize {
  const IntSize(this.width, this.height);

  final int width;
  final int height;
}

List<IntSize> _createSizes(int count) {
  final rnd = Random();
  return List.generate(
      count, (i) => IntSize(rnd.nextInt(500) + 200, rnd.nextInt(800) + 200));
}

class Profile extends StatelessWidget {
  Profile() : _sizes = _createSizes(_kItemCount).toList();
  static const int _kItemCount = 30;
  final List<IntSize> _sizes;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 9),
                      child: Icon(
                        LineIcons.horizontalEllipsis,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 9),
                      child: Icon(
                        LineIcons.angleLeft,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
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
                                      "Ali shams",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "alishams",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 50),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 0),
                                                child: TextButton(
                                                    style: ButtonStyle(
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18.0),
                                                      )),
                                                      foregroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  Colors.white),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(Colors
                                                                  .grey
                                                                  .withOpacity(
                                                                      0.2)),
                                                    ),
                                                    onPressed: () {},
                                                    child: Icon(
                                                      LineIcons
                                                          .horizontalEllipsis,
                                                      color: Colors.black,
                                                    )),
                                              )),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(right: 6)),
                                          Expanded(
                                              flex: 7,
                                              child: Container(
                                                child: ElevatedButton(
                                                  onPressed: () {},
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
                                                            .all(EdgeInsets.all(
                                                                0)),
                                                  ),
                                                  child: Container(
                                                    width: 300,
                                                    decoration:
                                                        new BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Color(0xff004e92),
                                                          Color(0xff0664bb)
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.2),
                                                          spreadRadius: 1,
                                                          blurRadius: 19,
                                                          offset: Offset(0, 9),
                                                        )
                                                      ],
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Text(
                                                      "دنبال کردن",
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
                                  ],
                                ),
                                textDirection: TextDirection.ltr,
                              )),
                        )),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(right: 30),
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
                                    child: Image.network(
                                      "https://treaget.com/media/profile/2021/01/03/66708141_2379602192358271_7304296654685244567_n.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ))),
                        )),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40, right: 20, left: 20),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Text(
                          "1000",
                          style: TextStyle(fontSize: 18),
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
                          "1000",
                          style: TextStyle(fontSize: 18),
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
                          "1000",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "دنبال کننده",
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
        DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.55,
            maxChildSize: 0.91,
            builder: (BuildContext context, ScrollController scrollController) {
              return DefaultTabController(
                length: 3,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  floatingActionButton: FloatingActionButton.extended(
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                    label: Text("سفارش"),
                    icon: Icon(Icons.shopping_bag_outlined),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.grey[200],
                  ),
                  appBar: AppBar(
                      elevation: 0,
                      flexibleSpace: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TabBar(
                            isScrollable: false,
                            indicatorColor: Colors.transparent,
                            indicatorSize: TabBarIndicatorSize.tab,
                            unselectedLabelColor: Colors.grey[400],
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.withOpacity(0.2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 25,
                                  offset: Offset(0, 15),
                                ),
                              ],
                            ),
                            tabs: <Widget>[
                              Tab(
                                icon: Icon(Icons.dashboard_outlined),
                              ),
                              Tab(
                                icon: Icon(Icons.assignment_ind_outlined),
                              ),
                              Tab(
                                icon: Icon(Icons.store_outlined),
                              ),
                            ],
                          ),
                        ],
                      )),
                  body: TabBarView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 20, left: 20),
                        child: StaggeredGridView.countBuilder(
                          primary: false,
                          crossAxisCount: 4,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          controller: scrollController,

                          // ignore: missing_return
                          itemBuilder: (context, index) {
                            if (_sizes.length > index) {
                              if ((index == 0) | (index == 1)) {
                                return Column(
                                  children: [
                                    Padding(padding: EdgeInsets.only(top: 30)),
                                    _Tile(index, _sizes[index])
                                  ],
                                );
                              }
                              return _Tile(index, _sizes[index]);
                            }
                          },
                          staggeredTileBuilder: (index) =>
                              const StaggeredTile.fit(2),
                        ),
                      ),
                      ListView.builder(
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return TimeLineProfile(index: index);
                        },
                        controller: scrollController,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return Services();
                          },
                          controller: scrollController,
                        ),
                      )
                    ],
                  ),
                ),
              );
            })
      ]),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile(this.index, this.size);

  final IntSize size;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            //Center(child: CircularProgressIndicator()),
            Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(18.0),
                  child: CachedNetworkImage(
                      imageUrl:
                          'https://picsum.photos/${size.width}/${size.height}/',
                      placeholder: (context, url) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[400],
                          highlightColor: Colors.white,
                          enabled: true,
                          child: Container(
                            height: 200,
                            color: Colors.grey.withOpacity(0.2),
                            // width: 900,
                          ),
                        );
                      })),
            ),
          ],
        ),
      ],
    );
  }
}
