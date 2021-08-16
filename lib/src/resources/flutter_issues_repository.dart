import 'dart:async';
import 'package:FlutterIssuesGitTracker/src/models/flutter_issues_model.dart';
import 'package:FlutterIssuesGitTracker/src/models/user_profile.dart';

import 'flutter_issues_provider.dart';
import 'package:http/http.dart' show Client;


class FlutterIssuesRepository {
  Client client = Client();
  final flutterIssuesProvider = FlutterIssuesProvider();

  Future<List<FlutterIssuesModel>> fetchFlutterIssues(int pages) => flutterIssuesProvider.fetchFlutterIssues(pages, client);

  Future<UserProfileModel> fetchUserProfiles(String userLoginName) => flutterIssuesProvider.fetchUserProfile(userLoginName, client);
}
