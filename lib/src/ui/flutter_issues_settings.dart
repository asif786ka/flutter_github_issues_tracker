import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme_provider.dart';

class FlutterIssuesSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Consumer<ThemeNotifier>(
                  builder:(context, notifier, child) =>
                      SwitchListTile(
                        title: Text("Dark Mode"),
                        onChanged:(value){
                          notifier.toggleTheme();
                        } ,
                        value: notifier.darkTheme ,
                      ),
                ),

                Card(
                  child: ListTile(
                    title: Text("Toggle between dark mode and light mode"),
                  ),
                ),
              ]
          ),
        )
    );
  }
}