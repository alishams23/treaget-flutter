import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

// ignore: must_be_immutable
class TimeLineProfile extends StatelessWidget {
  int index;
  Map data;
  TimeLineProfile({Key key, this.index, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build;

    return Container(
      alignment: Alignment.topLeft,
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TimelineTile(
              nodeAlign: TimelineNodeAlign.start,
              contents: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border:Border.all(color: Colors.grey[100]),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          offset: Offset(0.0, 3.0),
                          blurRadius: 2.0,
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
                            Text(
                              data["createdAdd"],
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Text(data["body"]),
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
