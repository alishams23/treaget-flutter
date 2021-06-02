import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

// ignore: must_be_immutable
class TimeLineProfile extends StatelessWidget {
  int index;
  TimeLineProfile({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build

    return Container(
      alignment: Alignment.topLeft,
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TimelineTile(
              nodeAlign: TimelineNodeAlign.start,
              // oppositeContents: Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text('opposite\ncontents'),
              // ),
              contents: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          offset: Offset(0.0, 7.0),
                          blurRadius: 13.0,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                              left: 10,
                            )),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     gradient: LinearGradient(
                            //         begin: Alignment.topRight,
                            //         colors: [
                            //           Colors.grey[300],
                            //           Colors.grey[200]
                            //         ]),
                            //     borderRadius: BorderRadius.circular(9.0),
                            //   ),
                            //   height: 20,
                            //   width: 2,
                            // ),

                            Text(
                              "1400/8/9  -  1400/10/4",
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Text(
                            'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است.صلی و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.'),
                      ],
                    )),
              ),

              node: TimelineNode(
                // theme: TimelineThemeData(color: Colors.orange),

                startConnector: SizedBox(
                  // height: 20.0,
                  child: DecoratedLineConnector(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.grey[300],
                          index == 0
                              ? Colors.grey[200].withOpacity(0.0)
                              : Colors.grey[200]
                        ],
                      ),
                    ),
                  ),
                ),
                indicator: OutlinedDotIndicator(
                  color: Colors.deepOrange,
                ),
                endConnector: SizedBox(
                  // height: 20.0,
                  child: DecoratedLineConnector(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.grey[300], Colors.grey[200]]),
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
