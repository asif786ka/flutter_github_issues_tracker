import 'package:flutter/material.dart';
import 'flutter_issues_detail_bloc.dart';
export 'flutter_issues_detail_bloc.dart';

class IssuesDetailBlocProvider extends InheritedWidget {
  final FlutterIssuesDetailBloc bloc;

  IssuesDetailBlocProvider({Key? key, required Widget child})
      : bloc = FlutterIssuesDetailBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) {
    return true;
  }

  static FlutterIssuesDetailBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<IssuesDetailBlocProvider>()
    as IssuesDetailBlocProvider)
        .bloc;
  }
}