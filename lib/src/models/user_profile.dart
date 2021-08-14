class UserProfileModel {
  late String _login;
  late int _id;
  late String _url;
  late String _htmlUrl;
  late String _name;
  late String _company;
  late String _location;

  UserProfileModel(
      {required String login,
      required int id,
      required String htmlUrl,
      required String receivedEventsUrl,
      required String name,
      required String company,
      required String location}) {
    this._login = login;
    this._id = id;
    this._url = url;
    this._htmlUrl = htmlUrl;
    this._name = name;
    this._company = company;
    this._location = location;
  }

  String get login => _login;

  set login(String login) => _login = login;

  int get id => _id;

  set id(int id) => _id = id;

  String get url => _url;

  set url(String url) => _url = url;

  String get htmlUrl => _htmlUrl;

  set htmlUrl(String htmlUrl) => _htmlUrl = htmlUrl;

  String get name => _name;

  set name(String name) => _name = name;

  String get company => _company;

  set company(String company) => _company = company;

  String get location => _location;

  set location(String value) => _location = value;

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    _login = json['login'];
    _id = json['id'];
    _url = json['url'];
    _htmlUrl = json['html_url'];
    _name = json['name'];
    _company = json['company'];
    _location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this._login;
    data['id'] = this._id;
    data['url'] = this._url;
    data['html_url'] = this._htmlUrl;
    data['name'] = this._name;
    data['company'] = this._company;
    data['location'] = this._location;
    return data;
  }
}
