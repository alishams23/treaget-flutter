import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:treaget/models/home_model.dart';
import 'package:treaget/services/request_service.dart';

class PopupMenuButtonPostRequest extends StatelessWidget {
  Post data;
  var userInfo;
   final snackBar = SnackBar(content: Text('کپی شد'));
  var result;
  PopupMenuButtonPostRequest(this.data,this.userInfo);
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Icon(
        Icons.more_horiz,
        color: Colors.black,
      ),
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        
        PopupMenuItem<String>(
          child: ListTile(
            leading: const Icon(
              Icons.share,
              color: Colors.black,
            ),
            title: Text(
              "اشتراک گذاری ",
              textDirection: TextDirection.rtl,
            ),
          ),
          onTap: (){
            Clipboard.setData(ClipboardData(text: "treaget.com/request/${data.id}/"));
             ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        ),
        const PopupMenuDivider(),
        userInfo["username"] == data.author["username"]?
        PopupMenuItem<String>(
          child: ListTile(
            leading: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            title: Text(
              "حذف",
              style: TextStyle(color: Colors.red),
              textDirection: TextDirection.rtl,
            ),
          ),onTap: () async{
            result = await RequestApi.remove(id:data.id );
            if(result["result"] == true)Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
          },
        ):null,
      ],
    );
  }
}
