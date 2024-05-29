import '../pages/home.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  String domain = ' ';
  MyWebView({required this.domain, super.key});

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  String domain = 'google';
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  double _progress = 0;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    domain = widget.domain;
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://www.$domain.com'))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _progress = progress / 100;
            });
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Home()),
                (Route<dynamic> route) => false);
          },
        ),
      ),
      body: Stack(children: [
        WebViewWidget(
          controller: controller,
        ),
        _progress < 1
            ? SizedBox(
                height: 3,
                child: LinearProgressIndicator(
                  value: _progress,
                  backgroundColor:
                      Theme.of(context).highlightColor.withOpacity(0.2),
                ))
            : SizedBox(),
      ]),
    );
  }
}
