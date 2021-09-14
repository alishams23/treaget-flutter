import 'package:flutter/material.dart';
import 'package:treaget/components/loading.dart';
import 'package:treaget/components/notification.dart';
import 'package:treaget/services/notification_service.dart';

class NotificationApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StateNotification();
}

class StateNotification extends State {
  bool _isLoading;
  ScrollController _listScrollController = new ScrollController();
  List notifications = [];
  int _currentPage = 1;

  _getPost({int page: 1, bool refresh: false}) async {
    setState(() {
      _isLoading = true;
    });
    var response = await NotificationService.getNotification(page);
    setState(() {
      if (refresh) notifications.clear();
      if (response['results'] != null) {
        notifications.addAll(response['results']);
        _currentPage = page;
      }
      _isLoading = false;
    });
  }

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

  Future<Null> _handleRefresh() async {
    await _getPost(refresh: true);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        notifications != null
            ? RefreshIndicator(
                onRefresh: _handleRefresh,
                child: ListView.builder(
                    itemCount: notifications.length,
                    controller: _listScrollController,
                    itemBuilder: (BuildContext context, int index) {
                      return NotificationComponent(notifications[index]);
                    }),
              )
            : listIsEmpty(),
        _isLoading == true ? loadingView() : Container()
      ],
    );
  }

  listIsEmpty() {}
}
