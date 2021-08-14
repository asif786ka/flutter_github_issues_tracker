import 'dart:async';

import 'package:rxdart/rxdart.dart';
import '../models/user_profile.dart';
import '../resources/flutter_issues_repository.dart';

class FlutterIssuesDetailBloc {
  final _flutterRepository = FlutterIssuesRepository();
  final _userProfiles = PublishSubject<UserProfileModel>();
  Stream<UserProfileModel> get allUserProfiles => _userProfiles.stream;

  FlutterIssuesDetailBloc() {

  }

  fetchUserProfiles(String userLoginName) async {
   UserProfileModel itemModel = await _flutterRepository.fetchUserProfiles(userLoginName);
    _userProfiles.sink.add(itemModel);
  }

  dispose() async {
    await _userProfiles.drain();
    _userProfiles.close();
  }

}