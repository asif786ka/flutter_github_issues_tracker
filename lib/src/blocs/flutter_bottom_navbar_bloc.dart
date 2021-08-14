import 'dart:async';

enum NavBarItem { ISSUES, DEVPROFILES, SETTINGS }

class FlutterBottomNavBarBloc {
  final StreamController<NavBarItem> _navBarController =
      StreamController<NavBarItem>.broadcast();

  NavBarItem defaultItem = NavBarItem.ISSUES;

  Stream<NavBarItem> get itemStream => _navBarController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(NavBarItem.ISSUES);
        break;
      case 1:
        _navBarController.sink.add(NavBarItem.DEVPROFILES);
        break;
      case 2:
        _navBarController.sink.add(NavBarItem.SETTINGS);
        break;
    }
  }

  close() {
    _navBarController.close();
  }
}
