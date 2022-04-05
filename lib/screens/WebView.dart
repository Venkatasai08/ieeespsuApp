import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webview extends StatefulWidget {
  var title;
  webview({Key? key, required this.title}) : super(key: key);

  @override
  State<webview> createState() => _webviewState();
}

class _webviewState extends State<webview> {
  late WebViewController controller;
  bool isViewed = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebView(
          // initialUrl: "https://zeno.fm/radio/first-trial/",
          initialUrl: "https://zeno.fm/radio/hindimusicradio/",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (contoller) {
            controller = contoller;
          },
          onPageStarted: (url) {
            // isViewed = true;
            // setState(() {});
          },
        ),
      ),
    );
  }
}
