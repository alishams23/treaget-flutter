class Post {
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
    item = parsedJson['item'];
    var data = parsedJson["data"];
    if (parsedJson['item'] == "request") {
      id = data['id'];
      subcategories = data['subcategories'];
      author = data['author'];
      title = data['title'];
      body = data['body'];
      price = data['price'];
      createdAdd = data['createdAdd'];
    } else if (parsedJson['item'] == "picture") {
      id = data['id'];
      likeCount = data['like_count'];
      likeUser = data['like'];
      like = data['likeAuthor'];
      author = data['author'];
      category = data['category'];
      alt = data['alt'];
      image = data['image'];
      createdAdd = data['createdAdd'];
    }
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
