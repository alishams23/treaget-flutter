import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/services.dart';
import 'package:treaget/models/home_model.dart';
import 'package:treaget/services/Picture_service.dart';



// ignore: must_be_immutable
class PopupMenuButtonPostPicture extends StatefulWidget {
  Post data;
  var userInfo;
  PopupMenuButtonPostPicture({this.data,this.userInfo});

  @override
  State<StatefulWidget> createState() {
    
    return PopupMenuButtonPostPictureState();
  }
 
}


class PopupMenuButtonPostPictureState extends State <PopupMenuButtonPostPicture>{
  final snackBar = SnackBar(content: Text('کپی شد'));
  var result;
 @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(padding: EdgeInsets.all(8),child: Icon(
        Icons.more_horiz,
        color: Colors.black,
      ),),
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
            Clipboard.setData(ClipboardData(text: "treaget.com/account/post/${widget.data.id}/"));
             ScaffoldMessenger.of(context).showSnackBar(snackBar);

          },
        ),
        // const PopupMenuDivider(),
        (widget.userInfo != null && widget.userInfo["username"] == widget.data.author["username"]) ?
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
          ),
          onTap: () async{
            result = await PictureApi.removePicture(id:widget.data.id );
            if(result["result"] == true)Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
          },
        ):null,
      ],
    );
  }
}