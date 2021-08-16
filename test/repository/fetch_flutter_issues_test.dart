import 'package:FlutterIssuesGitTracker/src/models/flutter_issues_model.dart';
import 'package:FlutterIssuesGitTracker/src/resources/flutter_issues_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_flutter_issues_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('fetchFlutter issues from Github', () {
    test('returns list of flutter issues if the http call completes successfully', () async {
      final client = MockClient();

      /*List<FlutterIssuesModel> list = [];
      User user1 = User(login: "aawhitfield", id: 7103590, avatarUrl: "https://avatars.githubusercontent.com/u/7103590?v=4", url: "https://api.github.com/users/aawhitfield", htmlUrl: "https://github.com/aawhitfield", type: "User");
      FlutterIssuesModel issue1 = FlutterIssuesModel(id: 971055163, number: 88231, title: "[image_picker] Android App crash after taking picture with camera", user: user1);
      list.add(issue1);*/

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client
          .get(Uri.parse('https://api.github.com/repos/flutter/flutter/issues?page=1')))
          .thenAnswer((_) async =>
          http.Response(''
              '[ {"id": 971528726,"number": 88270,"title": "TextAlign justify doesnt work with HTML web renderer", '
              '"user": {"login": "sdabet-orpheo","id": 79854215,"avatar_url": "https://avatars.githubusercontent.com/u/79854215?v=4","url": "https://api.github.com/users/sdabet-orpheo","html_url": "https://github.com/sdabet-orpheo","type": "User"}}'
              ', {"id": 966566382,"number": 88032,"title": "Flutter team cannot make further progress on this issue until the original reporter responds.", '
              '"user": {"login": "JumanDhaher","id": 79854215,"avatar_url": "https://avatars.githubusercontent.com/u/46423160?v=4","url": "https://api.github.com/users/JumanDhaher","html_url": "https://github.com/JumanDhaher","type": "User"}}'
              ',{"id": 966434634,"number": 88030,"title": "Deferred components integration test app", '
              '"user": {"login": "GaryQian","id": 1887398,"avatar_url": "https://avatars.githubusercontent.com/u/1887398?v=4","url": "https://api.github.com/users/GaryQian","html_url": "https://github.com/GaryQian","type": "User"}}]', 200));


      final issueslist = await FlutterIssuesProvider().fetchFlutterIssues(1, client);

      expect(issueslist, isA<List<FlutterIssuesModel>>());
      expect(issueslist.toList().first.title, "TextAlign justify doesnt work with HTML web renderer");
      expect(issueslist.toList()[1].title, "Flutter team cannot make further progress on this issue until the original reporter responds.");
      expect(issueslist.toList()[2].title, "Deferred components integration test app");

    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client
          .get(Uri.parse('https://api.github.com/repos/flutter/flutter/issues?page=1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(FlutterIssuesProvider().fetchFlutterIssues(1, client), throwsException);
    });
  });
}