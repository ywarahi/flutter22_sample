import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Flutter url_launcher Sample',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter url_launcher Sample'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _launchInBrowser('https://pub.dev/packages/url_launcher');
              },
              child: const Text('ブラウザでURLを開く'),
            ),
            ElevatedButton(
              onPressed: () {
                _launchInApp('https://pub.dev/packages/url_launcher');
              },
              child: const Text('アプリ内でURLを開く'),
            ),
            ElevatedButton(
              child: const Text('アプリ内でURLを開き、5秒後に閉じる'),
              onPressed: () {
                _launchInApp('https://pub.dev/packages/url_launcher');
                Timer(
                  const Duration(seconds: 5),
                  closeWebView,
                );
              },
            ),
            ElevatedButton(
              onPressed: _launchUniversalLinkIos,
              child: const Text('iOSのユニバーサルリンクを開く'),
            ),
          ],
        )),
      ),
    );
  }

  // アプリ内で開く
  Future<void> _launchInApp(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
      );
    } else {
      throw Exception('このURLにはアクセスできません');
    }
  }

// ブラウザで開く
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw Exception('このURLにはアクセスできません');
    }
  }

// ユニバーサルリンク
  Future<void> _launchUniversalLinkIos() async {
    const url = 'https://www.youtube.com/';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        universalLinksOnly: true,
      );
    } else {
      throw Exception('このURLにはアクセスできません');
    }
  }
}
