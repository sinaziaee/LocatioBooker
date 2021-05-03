class ItemModel{
  int _userId;
  int _id;
  String _title;
  String _body;
  ItemModel.fromJson(Map<String,dynamic> parsedJson){
    _userId = parsedJson['userId'];
    _id = parsedJson['id'];
    _title = parsedJson['title'];
    _body = parsedJson['body'];
  }

  String get body => _body;

  String get title => _title;

  int get id => _id;

  int get userId => _userId;

}

class Doc{
  String doc;
  Doc.fromJson(Map<String,dynamic> parsedJson){
    doc = parsedJson['doc'];
  }
}

class Gallery{
  String imageId;
  Gallery.fromJson(Map<String,dynamic> parsedJson){
    imageId = parsedJson['imageId'];
  }
}

class Info{
  String status;
  Info.fromJson(Map<String,dynamic> parsedJson){
    status = parsedJson['status'];
  }
}