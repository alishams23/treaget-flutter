import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

// class PostCard extends StatefulWidget {
//   @override
//   PostCardState createState() => PostCardState();
// }

// class PostCardState extends State<PostCard> {
//   @override
//   Widget build(BuildContext context) {
//     bool _isVisible = false;
//     return Padding(
//       padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 15.0),
//       child: Container(
//         // width: double.infinity,
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20.0),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.15),
//                 spreadRadius: 1,
//                 blurRadius: 5,
//                 offset: Offset(0, 2),
//               )
//             ]),
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 5.0),
//           child: Column(
//             children: <Widget>[
//               ListTile(
//                 leading: Container(
//                   width: 50.0,
//                   : 50.0,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     // boxShadow: [
//                     //   BoxShadow(
//                     //     color: Colors.black45,
//                     //     offset: Offset(0.0, 2.0),
//                     //     blurRadius: 6.0,
//                     //   ),
//                     // ],
//                   ),
//                   child: CircleAvatar(
//                     backgroundColor: Colors.grey[300],
//                     child: ClipOval(
//                       child: Image(
//                         width: 50.0,
//                         height: 50.0,
//                         image: NetworkImage(
//                             "https://picsum.photos/seed/picsum/200/300"),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 title: Text(
//                   posts[index].authorName,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 subtitle: Text(
//                   posts[index].timeAgo,
//                 ),
//                 trailing: IconButton(
//                   icon: Icon(Icons.more_horiz),
//                   color: Colors.black,
//                   onPressed: () => print('More'),
//                 ),
//               ),
//               InkWell(
//                   onDoubleTap: () => print('Like post'),
//                   onTap: () {
//                     setState(() {
//                       _isVisible = !_isVisible;
//                     });
//                   },
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           width: double.infinity,
//                           margin: EdgeInsets.all(10.0),
//                           child: Stack(
//                             alignment: Alignment.center,
//                             fit: StackFit.passthrough,
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 child: CachedNetworkImage(
//                                     imageUrl: "https://picsum.photos/700/700",
//                                     fit: BoxFit.fitHeight,
//                                     placeholder: (context, url) {
//                                       return Shimmer.fromColors(
//                                         baseColor: Colors.grey[400],
//                                         highlightColor: Colors.white,
//                                         enabled: true,
//                                         child: Container(
//                                           height: 200,
//                                           color: Colors.grey.withOpacity(0.2),
//                                           // width: 100,
//                                         ),
//                                       );
//                                     }),
//                               ),
//                               Visibility(
//                                 visible: _isVisible,
//                                 child: Positioned.fill(
//                                     child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20.0),
//                                   ),
//                                   padding: EdgeInsets.all(20),
//                                   alignment: Alignment.bottomCenter,
//                                   child: ClipRect(
//                                     child: BackdropFilter(
//                                       filter: ImageFilter.blur(
//                                           sigmaX: 5, sigmaY: 5),
//                                       child: Container(
//                                         padding: EdgeInsets.all(20),
//                                         height: double.infinity,
//                                         child: SingleChildScrollView(
//                                           child: Row(
//                                             // mainAxisAlignment:
//                                             //     MainAxisAlignment.end,
//                                             children: [
//                                               Flexible(
//                                                 child: Text(
//                                                   "لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد. کتابهای زیادی در شصت و سه درصد گذشته، حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی و فرهنگ پیشرو در زبان فارسی ایجاد کرد. در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.",
//                                                   style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontSize: 14),
//                                                   textDirection:
//                                                       TextDirection.rtl,
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(8.0),
//                                           color: Colors.black.withOpacity(.3),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 )),
//                               )
//                             ],
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.grey[100],
//                             borderRadius: BorderRadius.circular(8.0),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.14),
//                                 offset: Offset(0.0, 7.0),
//                                 blurRadius: 9.0,
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   )),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Row(
//                       children: <Widget>[
//                         IconButton(
//                           icon: Icon(LineIcons.heart),
//                           iconSize: 30.0,
//                           onPressed: () => print('Like post'),
//                         ),
//                         Text(
//                           '2,515',
//                           style: TextStyle(
//                             fontSize: 14.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(width: 20.0),
//                       ],
//                     ),
//                     IconButton(
//                       icon: Icon(LineIcons.bookmark),
//                       iconSize: 30.0,
//                       onPressed: () => print('Save post'),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
