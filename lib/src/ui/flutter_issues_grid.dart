import 'package:FlutterIssuesGitTracker/src/blocs/issues_detail_bloc_provider.dart';
import 'package:FlutterIssuesGitTracker/src/ui/custom_progress_loader.dart';
import 'package:flutter/material.dart';

import '../blocs/flutter_issues_bloc.dart';
import '../models/flutter_issues_model.dart';
import 'issues_detail.dart';

class FlutterIssuesGrid extends StatefulWidget {
  @override
  State<FlutterIssuesGrid> createState() => _FlutterIssuesGridState();
}

class _FlutterIssuesGridState extends State<FlutterIssuesGrid> {
  int page = 1;
  Color mainColor = const Color(0xff3C3261);
  List<FlutterIssuesModel> _searchIssues = [];
  List<FlutterIssuesModel> _flutterIssues = [];
  TextEditingController controller = new TextEditingController();
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    bloc.fetchAllFlutterIssues(page);
    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    page++;
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      bloc.fetchAllFlutterIssues(page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Github User Profiles'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.sort,
            ),
            tooltip: 'Theme selector',
            onPressed: () {
              setState(() {
                bloc.sortAllIssuesByLogin(_flutterIssues);
              });
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: bloc.issuesStream,
        builder: (context, AsyncSnapshot<List<FlutterIssuesModel>> snapshot) {
          if (snapshot.hasData) {
            return _buildBody(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildUsersGrid(AsyncSnapshot<List<FlutterIssuesModel>> snapshot) {
    _flutterIssues = snapshot.data!;
    //print("Github list size:" + _flutterIssues.length.toString());
    return new GridView.builder(
      physics: ScrollPhysics(),
      itemCount: _flutterIssues.length + 1,
      controller: _controller,
      itemBuilder: (context, index) {
        return index >= snapshot.data!.length
            ? CustomProgressLoader(25, 25)
            : InkWell(
                onTap: () {
                  openDetailPage(_flutterIssues, index);
                },
                child: new Card(
                  child: new Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(top: 2.0, bottom: 2.0)),
                        new CircleAvatar(
                          radius: 30.0,
                          backgroundImage: new NetworkImage(
                            _flutterIssues[index].user.avatarUrl,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 2.0, bottom: 2.0)),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                          child: Text(
                            "Profile Username:",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 2.0, right: 2.0, top: 2.0, bottom: 2.0),
                            child: Text(
                              _flutterIssues[index].user.login,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        )
                      ],
                    ),
                  ),
                  margin: const EdgeInsets.all(8.0),
                ),
              );
      },
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    );
  }

  Widget _buildSearchIssues() {
    return new ListView.builder(
      itemCount: _searchIssues.length,
      itemBuilder: (context, i) {
        return new Card(
          child: new ListTile(
            leading: new CircleAvatar(
              backgroundImage:
              new NetworkImage(_searchIssues[i].user.avatarUrl),
            ),
            title: new Text(_searchIssues[i].user.login),
          ),
          margin: const EdgeInsets.all(8.0),
        );
      },
    );
  }
  Widget _buildSearchBox() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Card(
        child: new ListTile(
          leading: new Icon(Icons.search),
          title: new TextField(
            controller: controller,
            decoration: new InputDecoration(
                hintText: 'Filter users by profilename',
                border: InputBorder.none),
            onChanged: (value) => onSearchTextChanged(_flutterIssues, value),
          ),
          trailing: new IconButton(
            icon: new Icon(Icons.cancel),
            onPressed: () {
              //print(controller.text);
              controller.clear();
              (value) => onSearchTextChanged(_flutterIssues, value);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(AsyncSnapshot<List<FlutterIssuesModel>> snapshot) {
    return new Column(
      children: <Widget>[
        new Container(
            color: Theme.of(context).primaryColor, child: _buildSearchBox()),
        new Expanded(
            child: _searchIssues.length != 0 || controller.text.isNotEmpty
                ? _buildSearchIssues()
                : _buildUsersGrid(snapshot)),
      ],
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  openDetailPage(List data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return IssuesDetailBlocProvider(
          child: IssuesDetail(
            title: data[index].title,
            avatarUrl: data[index].user.avatarUrl,
            description: data[index].user.login,
            creationDate: data[index].title,
            issueId: data[index].user.id,
          ),
        );
      }),
    );
  }

  onSearchTextChanged(List<FlutterIssuesModel> originalList, String text) {
    //print("inside search" + text);
    _searchIssues.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    originalList.forEach((userDetail) {
      //print(userDetail.title);
      //print(text);
      if (userDetail.user.login.toLowerCase().contains(text))
        _searchIssues.add(userDetail);
    });

    if (_searchIssues.length > 0) {
      //print("search length greater than 0" + _searchResult.length.toString());
      setState(() {});
      return;
    }
  }
}
