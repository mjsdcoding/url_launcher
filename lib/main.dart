// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'URL Launcher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'URL Launcher'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  @override
  Widget build(BuildContext context) {
    // onPressed calls using this URL are not gated on a 'canLaunch' check
    // because the assumption is that every device can launch a web URL.
    const String toLaunch = 'https://www.yout';
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  await launch('http://silverappli.website/');
                },
                child: const Text('Launch in browser'),
              ),
              const Padding(padding: EdgeInsets.all(16.0)),
              ElevatedButton(
                onPressed: () async {
                  await launch('http://silverappli.website/',
                      //forceSafariVC: true,
                      forceWebView: true,
                      enableJavaScript: true,
                      enableDomStorage: true,
                      webOnlyWindowName: "_blank"
                      // universalLinksOnly: true // guide where to find more information
                      );
                },
                child: const Text('Launch in app'),
              ),
              const Padding(padding: EdgeInsets.all(16.0)),
              ElevatedButton(
                  onPressed: () async {
                    // can launch uri
                    final Uri launchUri = Uri(
                      scheme: 'tel',
                      path: "+18003450948",
                    );
                    await launch(launchUri.toString());
                  },
                  child: const Text('Make phone call')),
              const Padding(padding: EdgeInsets.all(16.0)),
              ElevatedButton(
                  onPressed: () async {
                    // can launch uri
                    final Uri launchUri = Uri(
                      scheme: 'smsto',
                      path: "+18003450948",
                    );
                    await launch(launchUri.toString());
                  },
                  child: const Text('Send SMS')),
              const Padding(padding: EdgeInsets.all(16.0)),
              ElevatedButton(
                  onPressed: () async {
                    String? encodeQueryParameters(Map<String, String> params) {
                      return params.entries
                          .map((e) =>
                              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                          .join('&');
                    }

                    String email = 'smith@example.com';
                    String subject = 'Example Subject & Symbols are allowed!';
                    String body = 'Helloo !!!';

                    final Uri emailUri = Uri(
                      scheme: 'mailto',
                      path: email,
                      query: encodeQueryParameters(
                          <String, String>{'subject': subject, 'body': body}),
                    );
                    if (await canLaunch(emailUri.toString())) {
                      launch(emailUri.toString());
                    }else {
                     print("The action is not supported. ( No Email app )");
                    }
                  },
                  child: const Text('Send Email')),
            ],
          ),
        ],
      ),
    );
  }
}
