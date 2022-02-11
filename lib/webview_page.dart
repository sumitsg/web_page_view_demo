import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;
  const WebViewPage({Key? key, required this.url, required this.title})
      : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState(url, title);
}

class _WebViewPageState extends State<WebViewPage> {
  final String url;
  final String title;

  _WebViewPageState(this.url, this.title);

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Expanded(
              child: WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
          ))
        ],
      ),
    );
  }
}
