import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Article extends StatefulWidget {

  final String blogUrl;
  Article({this.blogUrl});


  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {

  final Completer<WebViewController> _completer=Completer<WebViewController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("SJ"),
            Text("News",style: TextStyle(color: Colors.blue),),
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),
          ),
        ],
      ),
      body: Container(
        child: WebView(
          initialUrl: widget.blogUrl,
          onWebViewCreated: ((WebViewController webViewController){
            _completer.complete(webViewController);
          }),
        ),
      ),
    );
  }
}