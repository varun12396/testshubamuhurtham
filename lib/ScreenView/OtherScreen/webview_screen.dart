import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  final String initUrl, title;
  const WebviewScreen({Key? key, required this.initUrl, required this.title})
      : super(key: key);

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyComponents.appbarWithTitle(
          context, widget.title, true, [], MyTheme.whiteColor),
      body: SizedBox(
        width: MyComponents.widthSize(context),
        height: MyComponents.heightSize(context),
        child: WebView(
          initialUrl: widget.initUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onPageStarted: (data) {
            debugPrint('onPageStarted:$data');
          },
          onProgress: (data) {
            debugPrint('onProgress:$data');
          },
          onPageFinished: (data) {
            debugPrint('onPageFinished:$data');
          },
        ),
      ),
    );
  }
}
