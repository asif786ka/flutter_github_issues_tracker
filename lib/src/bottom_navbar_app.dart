import 'package:FlutterIssuesGitTracker/src/theme_provider.dart';
import 'package:FlutterIssuesGitTracker/src/ui/flutter_issues_grid.dart';
import 'package:FlutterIssuesGitTracker/src/ui/flutter_issues_list.dart';
import 'package:FlutterIssuesGitTracker/src/ui/flutter_issues_settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blocs/flutter_bottom_navbar_bloc.dart';

class BottomNavBarApp extends StatefulWidget {
  createState() => _BottomNavBarAppState();
}

class _BottomNavBarAppState extends State<BottomNavBarApp> {
  late FlutterBottomNavBarBloc _bottomNavBarBloc;

  @override
  void initState() {
    super.initState();
    _bottomNavBarBloc = FlutterBottomNavBarBloc();
  }

  @override
  void dispose() {
    _bottomNavBarBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            title: "Flutter Provider",
            theme: notifier.darkTheme? dark : light,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: StreamBuilder<NavBarItem>(
                stream: _bottomNavBarBloc.itemStream,
                initialData: _bottomNavBarBloc.defaultItem,
                builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
                  switch (snapshot.data!) {
                    case NavBarItem.ISSUES:
                      return MovieListNew();
                    case NavBarItem.DEVPROFILES:
                      return FlutterIssuesGrid();
                    case NavBarItem.SETTINGS:
                      return FlutterIssuesSettings();
                  }
                },
              ),
              bottomNavigationBar: StreamBuilder(
                stream: _bottomNavBarBloc.itemStream,
                initialData: _bottomNavBarBloc.defaultItem,
                builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
                  return BottomNavigationBar(
                    fixedColor: Colors.blueAccent,
                    currentIndex: snapshot.data!.index,
                    onTap: _bottomNavBarBloc.pickItem,
                    items: [
                      BottomNavigationBarItem(
                        title: Text('Issues'),
                        icon: Icon(Icons.home),
                      ),
                      BottomNavigationBarItem(
                        title: Text('Profiles'),
                        icon: Icon(Icons.notifications),
                      ),
                      BottomNavigationBarItem(
                        title: Text('Settings'),
                        icon: Icon(Icons.settings),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );  }




Widget _alertArea() {
    return Center(
      child: Text(
        'Notifications Screen',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.red,
          fontSize: 25.0,
        ),
      ),
    );
  }

  Widget _settingsArea() {
    return Center(
      child: Text(
        'Settings Screen',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.blue,
          fontSize: 25.0,
        ),
      ),
    );
  }
}
