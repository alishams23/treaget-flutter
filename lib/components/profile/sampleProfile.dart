import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SampleProfile extends StatelessWidget {
  const SampleProfile(this.index, this.productsData);

  final productsData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          // fit: StackFit.passthrough,
          children: <Widget>[
            Container(
              // height: double.infinity,
              width: 250,
              // heigsht: 170,
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(right: 4, left: 4, bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child:
                  // height: double.infinity,

                  ClipRRect(
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
          ],
        ),
      ],
    );
  }
}
