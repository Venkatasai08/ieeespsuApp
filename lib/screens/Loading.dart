import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ieeespsu/screens/WebView.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      const Duration(seconds: 2),
      (() => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => webview(
                title: "Zeno fm",
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.5),
      child: const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.grey,
        ),
      ),
    );
  }
}
