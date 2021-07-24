class Post {
  // TODO:delete extra variable
  String item;
  int id;
  List subcategories;
  Map author;
  // var likeUser;
  String title;
  String body;
  int price;
  String createdAdd;
  String alt;
  bool likeAuthor;
  int likeCount;
  List category;
  String image;
  bool visible = false;
  bool like = false;
  List likeUser;
  Post.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    likeCount = parsedJson['like_count'];
    likeUser = parsedJson['like'];
    like = parsedJson['likeAuthor'];
    author = parsedJson['author'];
    category = parsedJson['category'];
    alt = parsedJson['alt'];
    image = parsedJson['image'];
    createdAdd = parsedJson['createdAdd'];
  }
  void visiblity() {
    visible == true ? visible = false : visible = true;
  }

  void likePost() {
    if (like == true) {
      like = false;
      likeCount -= 1;
    } else {
      like = true;
      likeCount += 1;
    }
  }
}
