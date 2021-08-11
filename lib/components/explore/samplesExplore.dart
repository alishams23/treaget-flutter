import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget samplesExplore(int index, productsData) {
  return Column(
    children: <Widget>[
      // Stack(
      //   children: <Widget>[
      Container(
        padding: (index == 0 || index == 1)
            ? EdgeInsets.only(right: 2, left: 2, bottom: 2, top: 20)
            : EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
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
      //     Container(
      //       width: 110,
      //       alignment: Alignment.bottomCenter,
      //       // height: 100,
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(10),
      //       ),
      //       padding: (index == 0 || index == 1)
      //           ? EdgeInsets.only(right: 10, left: 10, bottom: 10, top: 28)
      //           : EdgeInsets.all(10),

      //       child: ClipRRect(
      //           child: BackdropFilter(
      //         filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      //         child: Container(
      //           padding: EdgeInsets.symmetric(horizontal: 15),
      //           height: 22,
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Flexible(
      //                 child: Text("${productsData.author['username']}",
      //                     style: TextStyle(
      //                         color: Colors.white,
      //                         fontSize: 11,
      //                         fontWeight: FontWeight.bold),
      //                     overflow: TextOverflow.ellipsis),
      //               ),
      //               // Padding(padding: EdgeInsets.only(right: 10)),
      //               // Flexible(
      //               //   child: productsData.alt != null
      //               //       ? Text("${productsData.alt}",
      //               //           textDirection: TextDirection.rtl,
      //               //           style: TextStyle(
      //               //             color: Colors.white,
      //               //             fontSize: 8,
      //               //           ),
      //               //           overflow: TextOverflow.ellipsis)
      //               //       : Container(),
      //               // )
      //             ],
      //           ),
      //           decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(10),
      //               color: Colors.black.withOpacity(0.25)),
      //         ),
      //       )),
      //     ),
      //   ],
      // ),
    ],
  );
}
