import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Flipkart extends StatefulWidget {
  const Flipkart({Key? key}) : super(key: key);

  @override
  _FlipkartState createState() => _FlipkartState();
}

class _FlipkartState extends State<Flipkart> {
  double progress = 0;
  late WebViewController controller;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          // ? stya in the app even if we click to go back
          return false;
        } else {
          ///? leaves the app
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Webview in flutter'),
          actions: [
            IconButton(
                onPressed: () async {
                  if (await controller.canGoBack()) {
                    controller.goBack();
                  }
                },
                icon: const Icon(Icons.arrow_back)),
            IconButton(
                onPressed: () async {
                  controller.reload();
                },
                icon: const Icon(Icons.replay_outlined))
          ],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: progress,
              color: Colors.red,
              backgroundColor: Colors.black12,
            ),
            Expanded(
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: 'https://flipkart.com',
                onWebViewCreated: (controller) {
                  this.controller = controller;
                },
                onPageStarted: (url) {
                  print('New Website : $url');
                },
                onProgress: (progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
