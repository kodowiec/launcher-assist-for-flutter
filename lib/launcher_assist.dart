import 'dart:typed_data';
import 'package:flutter/services.dart';


  /// App object containing label, package, icon and banner
class App {
  App.fromMap(Map<dynamic, dynamic> map) :
        package = map['package'],
        label = map['label'],
        icon = map['icon'],
        banner = map['banner'];

  final Uint8List banner;
  final Uint8List icon;
  final String label;
  final String package;
}

class LauncherAssist {



  static const MethodChannel _channel = const MethodChannel('launcher_assist');

  /// Returns a list of apps installed on the user's device
  /// App object  [App.package, App.label, App.icon, App.banner]
  static getAllApps() async {
    List<dynamic> methodData = await _channel.invokeMethod('getAllApps');
    List<App> apps = new List<App>();
    methodData.forEach((app) {
      print(app['package']);
      apps.add(App.fromMap(app));
    });
    return apps;
  }

  /// Returns a list of user-installed apps
  /// App object  [App.package, App.label, App.icon, App.banner]
  static getUserApps() async {
    List<dynamic> methodData = await _channel.invokeMethod('getUserApps');
    List<App> apps = new List<App>();
    methodData.forEach((app) => apps.add(App.fromMap(app)));
    return apps;
  }

  /// Launches an app using its package name
  static launchApp(String packageName) {
    _channel.invokeMethod("launchApp", {"packageName": packageName});
  }

  /// Gets you the current wallpaper on the user's device. This method
  /// needs the READ_EXTERNAL_STORAGE permission on Android Oreo.
  static getWallpaper() async {
    var data = await _channel.invokeMethod('getWallpaper');
    return data;
  }
}

