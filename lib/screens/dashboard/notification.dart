import 'package:flutter/material.dart';
import 'package:treaget/components/notification.dart';

class NotificationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
        ListView.builder(itemCount: 3,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return NotificationComponent();}
                        
    );
  }
}
