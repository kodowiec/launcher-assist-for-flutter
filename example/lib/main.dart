// Copyright 2017 Ashraff Hathibelagal.
// Use of this source code is governed by an Apache license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:launcher_assist/launcher_assist.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<App> installedApps;
  var numberOfInstalledApps;
  var wallpaper;
  App selectedApp;

  @override
  initState() {
    super.initState();

    // Get all apps
    LauncherAssist.getAllApps().then((apps) {
      setState(() {
        numberOfInstalledApps = apps.length;
        installedApps = apps;
      });
    });

    // Get wallpaper as binary data
    LauncherAssist.getWallpaper().then((imageData) {
      setState(() {
        wallpaper = imageData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> test = new List<Widget>();

    installedApps.forEach((app) => test.add(RaisedButton(
        onPressed: () {
          setState(() {
            selectedApp = app;
          });
        },
        child: Text(app.label))));
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Launcher Assist'),
          ),
          body: new ListView(children: <Widget>[
            new Text("Found $numberOfInstalledApps apps installed"),
            new RaisedButton(
                child: new Text("Launch " +
                    (selectedApp != null
                        ? selectedApp.label
                        : installedApps[0].label)),
                onPressed: () {
                  // Launch the first app available
                  (selectedApp != null)
                      ? LauncherAssist.launchApp(selectedApp.package)
                      : LauncherAssist.launchApp(installedApps[0].package);
                }),
            new RaisedButton(
                child: new Text("Refresh"),
                onPressed: () {
                  // Launch the first app available
                  LauncherAssist.getAllApps().then((apps) {
                    setState(() {
                      numberOfInstalledApps = apps.length;
                      installedApps = apps;
                    });
                  });
                }),
            (installedApps.length > 0)
                ? selectedApp != null
                    ? Image.memory(selectedApp.icon)
                    : installedApps[0].icon != null
                        ? Image.memory(installedApps[0].icon)
                        : Container()
                : Container(),
            (installedApps.length > 0)
                ? selectedApp != null
                    ? selectedApp.banner != null ? Image.memory(selectedApp.banner) : Container()
                    : installedApps[0].banner != null
                        ? Image.memory(installedApps[0].banner)
                        : Container()
                : Container(),
            wallpaper != null
                ? new Image.memory(wallpaper, fit: BoxFit.scaleDown)
                : new Center(),
            ListView(
              children: test,
            )
          ])),
    );
  }
}
