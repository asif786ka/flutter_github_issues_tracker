import 'dart:async';

import 'package:FlutterIssuesGitTracker/src/models/flutter_issues_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import '../resources/flutter_issues_repository.dart';

class FlutterIssuesBloc {
  final _flutterRepository = FlutterIssuesRepository();
  final _flutterIssues = PublishSubject<List<FlutterIssuesModel>>();
  Stream<List<FlutterIssuesModel>> get allIssues => _flutterIssues.stream;

  final StreamController<List<FlutterIssuesModel>> _issuesController = BehaviorSubject<List<FlutterIssuesModel>>();
  List<FlutterIssuesModel> _issues = [];
  Stream<List<FlutterIssuesModel>> get issuesStream => _issuesController.stream;

  fetchAllFlutterIssues(int page) async {
    await Future.delayed(Duration(seconds: 2));
    List<FlutterIssuesModel> itemModel = await _flutterRepository.fetchFlutterIssues(page);
    _issues.addAll(itemModel);
    _issuesController.sink.add(_issues);
  }


  List<FlutterIssuesModel> sortAllIssuesByTittle(List<FlutterIssuesModel> _userDetails) {
    _userDetails.sort((a, b) => a.title.compareTo(b.title));
     return _userDetails;
  }

  List<FlutterIssuesModel> sortAllIssuesByLogin(List<FlutterIssuesModel> _userDetails) {
    _userDetails.sort((a, b) => a.user.login.compareTo(b.user.login));
    return _userDetails;
  }

  dispose() async {
    await _flutterIssues.drain();
    _flutterIssues.close();
    _issuesController.close();
    _issues.clear();
  }
}

final bloc = FlutterIssuesBloc();