import 'package:FlutterIssuesGitTracker/src/models/flutter_issues_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const _json = {
    "id": 971528727,
    "number": 88271,
    "title": "TextAlign justify doesnt work with HTML web renderer",
    "user": {
      "login": "sdabet-orpheo",
      "id": 79854215,
      "avatar_url": "https://avatars.githubusercontent.com/u/79854215?v=4",
      "url": "https://api.github.com/users/sdabet-orpheo",
      "html_url": "https://github.com/sdabet-orpheo",
      "type": "User"
    }
  };

  final _id = 971528726;
  final _number = 88270;

  final _title =
      "[image_picker] Android App crash after taking picture with camera";

  User _user = User(
      login: "sdabet-orpheo",
      id: 79854215,
      avatarUrl: "https://avatars.githubusercontent.com/u/79854215?v=4",
      url: "https://api.github.com/users/sdabet-orpheo",
      htmlUrl: "https://github.com/sdabet-orpheo",
      type: "User");

  final _idJson = 971528727;
  final _numberJson = 88271;

  final _titleJson = "TextAlign justify doesnt work with HTML web renderer";

  User _userJson = User(
      login: "sdabet-orpheo",
      id: 79854215,
      avatarUrl: "https://avatars.githubusercontent.com/u/79854215?v=4",
      url: "https://api.github.com/users/sdabet-orpheo",
      htmlUrl: "https://github.com/sdabet-orpheo",
      type: "User");

  test(
      'When construct a model '
      'Should present the correct atributes', () {
    final model = FlutterIssuesModel(
        id: _id, number: _number, title: _title, user: _user);

    expect(model.id, _id);
    expect(model.number, _number);
    expect(model.title, _title);
    expect(model.user, _user);
  });

  test(
      'When construct a model from a JSON '
      'Should present the correct atributes', () {
    final model = FlutterIssuesModel.fromJson(_json);

    expect(model.id, _idJson);
    expect(model.number, _numberJson);
    expect(model.title, _titleJson);
  });
}
