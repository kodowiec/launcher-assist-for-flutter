# Launcher Assist

This is a Flutter plugin that gives you basic access to Android's `PackageManager` and `WallpaperManager` classes. As such, it is designed to help you build launchers for Android. Currently, it offers the following methods:

- `getAllApps()` - This method returns a list of app objects containing the labels, package names, icons and banners of all the launchable apps installed on a user's device. The icons and banners are available as Uint8List.

- `getUserApps()` - This method returns a list of app objects containing the labels, package names, icons and banners of all the user-installed apps. The icons and banners are available as Uint8List.

- `launchApp()` - Takes a package name as its only argument. As its name suggests, it lets you launch apps.

- `getWallpaper()` - Returns the current wallpaper of the user, as a byte array that you can directly pass to the `Image.memory()` method. Note that on devices running Android Oreo or higher, this method will work only if your app has the `READ_EXTERNAL_STORAGE` permission.


### Usage

To use this plugin, add `launcher_assist` as a dependency in your pubspec.yaml file.

### Sample Code

```
import 'package:launcher_assist/launcher_assist.dart';

.
.
.

// Get all apps
List<App> installedApps;
var numberOfInstalledApps;

LauncherAssist.getAllApps().then((apps) {
    setState(() {
        numberOfInstalledApps = apps.length;
        installedApps = apps;
    });
});
```
