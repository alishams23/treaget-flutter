import 'dart:math';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

List<IntSize> _createSizes(int count) {
  final rnd = Random();
  return List.generate(
      count, (i) => IntSize(rnd.nextInt(500) + 200, rnd.nextInt(800) + 200));
}

// ignore: must_be_immutable
class Example08 extends StatefulWidget {
  Example08() : _sizes = _createSizes(_kItemCount).toList();

  static const int _kItemCount = 30;
  final List<IntSize> _sizes;
  ScrollController _controller = ScrollController();
  @override
  _ViewPostScreenState createState() => _ViewPostScreenState();
  // @override
  // State<StatefulWidget> createState() {
  //   Widget build(BuildContext context) {
  //     return Scaffold(
  //       body: StaggeredGridView.countBuilder(
  //         primary: false,
  //         crossAxisCount: 4,
  //         mainAxisSpacing: 4,
  //         crossAxisSpacing: 4,
  //         controller: _controller,
  //         // ignore: missing_return
  //         itemBuilder: (context, index) {
  //           if (_sizes.length > index) {
  //             return _Tile(index, _sizes[index]);
  //           }
  //         },
  //         staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
  //       ),
  //     );
  //   }
  // }
}

class _ViewPostScreenState extends State<Example08> {
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
        body: Padding(
          child: StaggeredGridView.countBuilder(
            primary: false,
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            controller: widget._controller,

            // ignore: missing_return
            itemBuilder: (context, index) {
              if (widget._sizes.length > index) {
                return _Tile(index, widget._sizes[index]);
              }
            },
            staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
        ));
  }
}

class IntSize {
  const IntSize(this.width, this.height);

  final int width;
  final int height;
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
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 26,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "alishams",
                          style: TextStyle(
                              color: Colors.white.withOpacity(1), fontSize: 10),
                          textDirection: TextDirection.rtl,
                        ),
                        Text(
                          "طراحی لوگو شرکت..",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 10),
                          textDirection: TextDirection.rtl,
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.black.withOpacity(.3),
                    ),
                  ),
                ),
              ),
            )),
          ],
        ),
        // Padding(
        //   padding: const EdgeInsets.all(4),
        //   child: Column(
        //     children: <Widget>[
        //       Text(
        //         'Image number $index',
        //         style: const TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //       Text(
        //         'Width: ${size.width}',
        //         style: const TextStyle(color: Colors.grey),
        //       ),
        //       Text(
        //         'Height: ${size.height}',
        //         style: const TextStyle(color: Colors.grey),
        //       ),
        //     ],
        //   ),
        // )
      ],
    );
  }
}
