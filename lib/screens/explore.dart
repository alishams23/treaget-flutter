import 'dart:math';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:treaget/services/explore_service.dart';

// List<IntSize> _createSizes(int count) {
//   final rnd = Random();
//   return List.generate(
//       count, (i) => IntSize(rnd.nextInt(500) + 200, rnd.nextInt(800) + 200));
// }

// ignore: must_be_immutable
class Example08 extends StatefulWidget {
  // Example08() : _sizes = _createSizes(_kItemCount).toList();

  // static const int _kItemCount = 30;
  // final List<IntSize> _sizes;
  ScrollController _controller = ScrollController();
  @override
  _ViewPostScreenState createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<Example08> {
  List _products = [];
  int _currentPage = 1;
  bool _isLoading = true;
  ScrollController _listScrollController = new ScrollController();

  Widget listIsEmpty() {
    return Text('محصولی برای نمایش وجود ندارد');
  }

  Future<Null> _handleRefresh() async {
    await _getPost(refresh: true);
    return null;
  }

  Widget streamListView() {
    return _products.length == 0 && _isLoading
        ? loadingView()
        : _products.length == 0
            ? listIsEmpty()
            : new RefreshIndicator(
                child: Padding(
                  child: StaggeredGridView.countBuilder(
                    primary: false,
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemCount: _products.length,
                    // controller: widget._controller,
                    controller: _listScrollController,
                    itemBuilder: (context, index) {
                      return _Tile(index, _products[index]);
                    },
                    staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                ),
                onRefresh: _handleRefresh);
  }

  @override
  void initState() {
    super.initState();
    _getPost();

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

  _getPost({int page: 1, bool refresh: false}) async {
    setState(() {
      _isLoading = true;
    });

    var response = await PostExploreService.getPosts(page);
    setState(() {
      if (refresh) _products.clear();
      _products.addAll(response['products']);
      _currentPage = response["current_page"];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[200],
          foregroundColor: Colors.black,
          onPressed: () {},
          child: Icon(LineIcons.search),
        ),
        body: streamListView());
  }

  Widget _Tile(int index, productsData) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(18.0),
                  child: CachedNetworkImage(
                      imageUrl: "${productsData.image}",
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
            Positioned.fill(
                child: Container(
              // height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: EdgeInsets.all(10),
              alignment: Alignment.bottomCenter,

              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 26,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${productsData.author['username']}",
                          style: TextStyle(
                              color: Colors.white.withOpacity(1), fontSize: 10),
                          textDirection: TextDirection.rtl,
                        ),
                        Flexible(
                            child: Text("${productsData.alt}",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 10),
                                textDirection: TextDirection.rtl,
                                overflow: TextOverflow.ellipsis))
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.black.withOpacity(.25),
                    ),
                  ),
                ),
              ),
            )),
          ],
        ),
      ],
    );
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
}

class IntSize {
  const IntSize(this.width, this.height);
  final int width;
  final int height;
}
