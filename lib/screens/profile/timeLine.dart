import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class TimeLineProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
          alignment: Alignment.topLeft,
          child: TimelineTile(
            nodeAlign: TimelineNodeAlign.basic,
            oppositeContents: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('opposite\ncontents'),
            ),
            contents: Card(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Text('contents'),
              ),
            ),
            node: FixedTimeline(
              theme: TimelineThemeData(color: Colors.orange),
              children: [
                SizedBox(
                  height: 20.0,
                  child: SolidLineConnector(),
                ),
                OutlinedDotIndicator(),
                SizedBox(
                  height: 20.0,
                  child: DecoratedLineConnector(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blue, Colors.lightBlueAccent[100]],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
