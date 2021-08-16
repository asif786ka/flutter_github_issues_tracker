import 'package:FlutterIssuesGitTracker/src/blocs/issues_detail_bloc_provider.dart';
import 'package:FlutterIssuesGitTracker/src/ui/custom_progress_loader.dart';
import 'package:flutter/material.dart';

import '../blocs/flutter_issues_bloc.dart';
import '../models/flutter_issues_model.dart';
import 'issues_detail.dart';

class FlutterIssuesList extends StatefulWidget {
  @override
  State<FlutterIssuesList> createState() => _FlutterIssuesListState();
}

class _FlutterIssuesListState extends State<FlutterIssuesList> {
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
        title: Text('Flutter Github Trending Issues'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.sort,
            ),
            tooltip: 'Theme selector',
            onPressed: () {
              setState(() {
                bloc.sortAllIssuesByTittle(_flutterIssues);
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

  Widget _buildFlutterIssuesList(
      AsyncSnapshot<List<FlutterIssuesModel>> snapshot) {
    _flutterIssues = snapshot.data!;
    //print("Github list size:" + _flutterIssues.length.toString());

    return new ListView.builder(
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
                  child: new ListTile(
                    leading: new CircleAvatar(
                      backgroundImage: new NetworkImage(
                        _flutterIssues[index].user.avatarUrl,
                      ),
                    ),
                    title: new Text(_flutterIssues[index].title),
                  ),
                  margin: const EdgeInsets.all(8.0),
                ),
              );
      },
    );
  }

  Widget _buildSearchResults() {
    return new ListView.builder(
      itemCount: _searchIssues.length,
      itemBuilder: (context, i) {
        return new Card(
          child: new ListTile(
            leading: new CircleAvatar(
              backgroundImage:
                  new NetworkImage(_searchIssues[i].user.avatarUrl),
            ),
            title: new Text(_searchIssues[i].title),
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
                hintText: 'Filter issues by title', border: InputBorder.none),
            onChanged: (value) => onSearchTextChanged(_flutterIssues, value),
          ),
          trailing: new IconButton(
            icon: new Icon(Icons.cancel),
            onPressed: () {
              print(controller.text);
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
                ? _buildSearchResults()
                : _buildFlutterIssuesList(snapshot)),
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
      if (userDetail.title.toLowerCase().contains(text))
        _searchIssues.add(userDetail);
    });

    if (_searchIssues.length > 0) {
      //print("search length greater than 0" + _searchResult.length.toString());
      setState(() {});
      return;
    }
  }
}
