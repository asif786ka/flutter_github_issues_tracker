import 'package:FlutterIssuesGitTracker/src/blocs/flutter_issues_detail_bloc.dart';
import 'package:FlutterIssuesGitTracker/src/blocs/issues_detail_bloc_provider.dart';
import 'package:FlutterIssuesGitTracker/src/models/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';


class IssuesDetail extends StatefulWidget {
  final avatarUrl;
  final description;
  final creationDate;
  final String title;
  final int issueId;

  IssuesDetail({
    required this.title,
    this.avatarUrl,
    this.description,
    this.creationDate,
    required this.issueId,
  });

  @override
  State<StatefulWidget> createState() {
    return IssuesDetailState(
      title: title,
      avatarUrl: avatarUrl,
      description: description,
      creationDate: creationDate,
      issueId: issueId,
    );
  }
}

class IssuesDetailState extends State<IssuesDetail> {
  final avatarUrl;
  final description;
  final creationDate;
  final String title;
  final int issueId;

  late FlutterIssuesDetailBloc bloc;

  IssuesDetailState({
    required this.title,
    this.avatarUrl,
    this.description,
    this.creationDate,
    required this.issueId,
  });

  @override
  void didChangeDependencies() {
    bloc = IssuesDetailBlocProvider.of(context);
    bloc.fetchUserProfiles(description);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 400.0,
                floating: false,
                pinned: true,
                elevation: 10.0,
                flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                  padding: const EdgeInsets.all(24.0),
                  child: new Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: new Container(
                      margin: const EdgeInsets.all(16.0),
//                                child: new Image.network(image_url+movies[i]['poster_path'],width: 100.0,height: 100.0),
                      child: new Container(
                        width: 70.0,
                        height: 70.0,
                      ),
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(10.0),
                        color: Colors.grey,
                        image: new DecorationImage(
                            image: new NetworkImage("$avatarUrl"),
                            fit:BoxFit.cover,
                            ),
                        boxShadow: [
                          new BoxShadow(
                              color: Colors.black,
                              blurRadius: 5.0,
                              offset: new Offset(2.0, 5.0))
                        ],
                      ),
                    ),
                  ),
                )),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(margin: EdgeInsets.only(top: 5.0)),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      Container(margin: EdgeInsets.only(left: 8.0, right: 8.0)),
                      Text(
                        description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                  Text(description),
                  Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                  Text(
                    "Issue Author Details",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                  StreamBuilder(
                    stream: bloc.allUserProfiles,
                    builder: (context, AsyncSnapshot<UserProfileModel> snapshot) {
                      if (snapshot.hasData) {
                        return trailerLayout(snapshot.data!);
                      } else {
                        return noTrailer();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget noTrailer() {
    return Center(
      child: Container(
        child: Text("No author details available"),
      ),
    );
  }

  Widget trailerLayout(UserProfileModel data) {
    return Row(
      children: <Widget>[
        trailerItem(data, 0),
      ],
    );
  }

  trailerItem(UserProfileModel data, int index) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Author Name:",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(margin: EdgeInsets.only(left: 4.0, right: 2.0)),
              Text(
                data!.name ?? "No name",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
          Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
          Row(
            children: <Widget>[
              Text(
                "Author Location:",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(margin: EdgeInsets.only(left: 4.0, right: 2.0)),
              Text(
                data?.location ?? "No location",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
          Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
          Row(
            children: <Widget>[
              Text(
                "Author Company:",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(margin: EdgeInsets.only(left: 4.0, right: 2.0)),
              Text(
                data?.company ?? "No company",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
          Container(margin: EdgeInsets.only(top: 16.0, bottom: 16.0)),
          Column(
            children: <Widget>[
              Text(
                "Author detailed profile link:",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(margin: EdgeInsets.only(left: 4.0, right: 2.0)),
              Linkify(
                onOpen: _onOpen,
                text: data?.htmlUrl ?? "No url",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }
}
