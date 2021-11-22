import 'package:flutter/material.dart';
import 'package:treaget/components/loading.dart';
import 'package:treaget/components/notification.dart';
import 'package:treaget/services/Rules_service.dart';

class Rules extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RulesState();
}

class RulesState extends State {
  bool _isLoading;
  List rules = [];

  _getPost({bool refresh: false}) async {
    setState(() {
      _isLoading = true;
    });
    var response = await RulesApi.listRules();
    setState(() {
      if (refresh) rules.clear();
      if (response['results'] != null) {
        rules.addAll(response['results']);
      }
      _isLoading = false;
    });
  }

  void initState() {
    super.initState();
    _getPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(padding: EdgeInsets.only(top: 10),child: Stack(
        children: [
          rules != null
              ? ListView.builder(
                  itemCount: rules.length,
                  itemBuilder: (BuildContext context, int index) {
                    var body = rules[index]["body"].replaceAll("<br>", " ");
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(15)),
                          margin: EdgeInsets.only(right: 30),
                          padding: EdgeInsets.only(
                              left: 10, right: 25, top: 10, bottom: 10),
                          child: Text(
                            rules[index]["title"],
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20, right: 20, left: 10, bottom: 20),
                          child: Text(
                            body,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                      ],
                    );
                  })
              : listIsEmpty(),
          _isLoading == true ? loadingView() : Container()
        ],
      ),)
    );
  }

  listIsEmpty() {}
}
