import 'dart:async';
import 'dart:convert';

import 'package:FlutterIssuesGitTracker/src/models/flutter_issues_model.dart';
import 'package:FlutterIssuesGitTracker/src/models/user_profile.dart';
import 'package:http/http.dart' show Client;

class FlutterIssuesProvider {
  Client client = Client();
  final _baseUrl = "https://api.github.com/repos/flutter/flutter";
  final _baseUrlUser = "https://api.github.com/users";

  Future<List<FlutterIssuesModel>> fetchFlutterIssues(int _pages) async {
    List<FlutterIssuesModel> myModels;
    Uri url = Uri.parse("$_baseUrl/issues?page=$_pages");
    //print("Github flutter issues request:" + url.toString());
    final response = await client.get(url);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      myModels = (json.decode(response.body) as List)
          .map((i) => FlutterIssuesModel.fromJson(i))
          .toList();
      return myModels;

    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load Github flutter issues');
    }
  }

  Future<UserProfileModel> fetchUserProfile(String userLoginName) async {
    Uri uri = Uri.parse("$_baseUrlUser/$userLoginName");
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return UserProfileModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Github user details');
    }
  }
}
