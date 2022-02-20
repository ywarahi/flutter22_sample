import 'dart:io' as io;
import 'package:package_info/package_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Platform {
  ios,
  android,
  unknown,
}

class LocalVersion extends ChangeNotifier {
  Platform _platform = Platform.unknown;
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Platform get platform {
    //initialize();
    return _platform;
  }

  PackageInfo get packageInfo {
    //initialize();
    return _packageInfo;
  }

  Future<void> initialize() async {
    if (_platform == Platform.unknown) {
      if (io.Platform.isAndroid) {
        _platform = Platform.android;
      } else if (io.Platform.isIOS) {
        _platform = Platform.ios;
      }

      _packageInfo = await PackageInfo.fromPlatform();
      notifyListeners();
      print('initialize');
    }
  }
}

final localVersionProvider = ChangeNotifierProvider((ref) => LocalVersion());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: Consumer(
        builder: (context, watch, child) {
          final localVersion = watch(localVersionProvider);
          return Text(localVersion.platform.toString());
        },
      )),
      body: Consumer(builder: (context, watch, child) {
        final localVersion = watch(localVersionProvider);
        print(localVersion.packageInfo.appName);
        print(localVersion.packageInfo.packageName);
        print(localVersion.packageInfo.version);
        print(localVersion.packageInfo.buildNumber);
        return Center(
            child: ElevatedButton(
              onPressed: localVersion.initialize,
              child: Text('Count: ${localVersion.packageInfo.version}'),
            ));
      }),
    ));
  }
}
