/// id : 968420733
/// number : 88095
/// title : "feat: migrate fuchsia/application_package.dart to null-safe"
/// user : {"login":"wanglikun7342","id":10217632,"avatar_url":"https://avatars.githubusercontent.com/u/10217632?v=4","url":"https://api.github.com/users/wanglikun7342","html_url":"https://github.com/wanglikun7342","type":"User"}

class FlutterIssuesModel {
  late int _id;
  late int _number;
  late String _title;
  late User _user;

  int get id => _id;

  int get number => _number;

  String get title => _title;

  User get user => _user;

  FlutterIssuesModel(
      {required int id,
      required int number,
      required String title,
      required User user}) {
    _id = id;
    _number = number;
    _title = title;
    _user = user;
  }

  FlutterIssuesModel.fromJson(dynamic json) {
    _id = json["id"];
    _number = json["number"];
    _title = json["title"];
    _user = (json["user"] != null ? User.fromJson(json["user"]) : null)!;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["number"] = _number;
    map["title"] = _title;
    if (_user != null) {
      map["user"] = _user.toJson();
    }
    return map;
  }
}

/// login : "wanglikun7342"
/// id : 10217632
/// avatar_url : "https://avatars.githubusercontent.com/u/10217632?v=4"
/// url : "https://api.github.com/users/wanglikun7342"
/// html_url : "https://github.com/wanglikun7342"
/// type : "User"

class User {
  late String _login;
  late int _id;
  late String _avatarUrl;
  late String _url;
  late String _htmlUrl;
  late String _type;

  String get login => _login;

  int get id => _id;

  String get avatarUrl => _avatarUrl;

  String get url => _url;

  String get htmlUrl => _htmlUrl;

  String get type => _type;

  User(
      {required String login,
      required int id,
      required String avatarUrl,
      required String url,
      required String htmlUrl,
      required String type}) {
    _login = login;
    _id = id;
    _avatarUrl = avatarUrl;
    _url = url;
    _htmlUrl = htmlUrl;
    _type = type;
  }

  User.fromJson(dynamic json) {
    _login = json["login"];
    _id = json["id"];
    _avatarUrl = json["avatar_url"];
    _url = json["url"];
    _htmlUrl = json["html_url"];
    _type = json["type"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["login"] = _login;
    map["id"] = _id;
    map["avatar_url"] = _avatarUrl;
    map["url"] = _url;
    map["html_url"] = _htmlUrl;
    map["type"] = _type;
    return map;
  }
}
