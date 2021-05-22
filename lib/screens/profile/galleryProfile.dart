import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

List<IntSize> _createSizes(int count) {
  final rnd = Random();
  return List.generate(
      count, (i) => IntSize(rnd.nextInt(500) + 200, rnd.nextInt(800) + 200));
}

// ignore: must_be_immutable
class GalleryProfile extends StatefulWidget {
  GalleryProfile() : _sizes = _createSizes(_kItemCount).toList();
  static const int _kItemCount = 30;
  ScrollController scrollController;
  final List<IntSize> _sizes;

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

class _ViewPostScreenState extends State<GalleryProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.deepOrange[700],
        //   child: Icon(LineIcons.search),
        // ),
        body: Padding(
          padding: EdgeInsets.only(right: 20, left: 10),
          child: StaggeredGridView.countBuilder(
            primary: false,
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            controller: widget.scrollController,

            // ignore: missing_return
            itemBuilder: (context, index) {
              if (widget._sizes.length > index) {
                if ((index == 0) | (index == 1)) {
                  return Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 30)),
                      _Tile(index, widget._sizes[index])
                    ],
                  );
                }
                return _Tile(index, widget._sizes[index]);
              }
            },
            staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
          ),
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
                  child: FadeInImage.assetNetwork(
                    image:
                        'https://picsum.photos/${size.width}/${size.height}/',
                    placeholder: "assets/images/Ajax-Preloader.gif",
                  )),
            ),
            // Positioned.fill(
            //     child: Container(
            //   child: Row(children: [Text("fvbd")]),
            // )),
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
