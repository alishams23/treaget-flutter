class Post {
  String item;
  int id;
  List subcategories;
  Map author;
  String title;
  String body;
  int price;
  String createdAdd;
  String alt;
  int likeCount;
  List category;
  String image;

  Post.fromJson(Map<String, dynamic> parsedJson) {
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
      author = data['author'];
      category = data['category'];
      alt = data['alt'];
      image = data['image'];
      createdAdd = data['createdAdd'];
    }
  }
}
