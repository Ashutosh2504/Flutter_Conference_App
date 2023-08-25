import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewComponent extends StatefulWidget {
  const WebviewComponent(
      {super.key, required this.title, required this.webviewUrl});
  final String title;
  final String webviewUrl;

  @override
  State<WebviewComponent> createState() => _WebviewComponentState();
}

class _WebviewComponentState extends State<WebviewComponent> {
  WebViewController controller = WebViewController();

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            //   if (!request.url.startsWith('https://whizsoftwares.in')) {
            //     return NavigationDecision.prevent;
            //   }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.webviewUrl));
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  PreferredSizeWidget getAppBar() {
    return AppBar(
      title: Text(widget.title),
    );
  }

  Widget getBody() {
    return WebViewWidget(controller: controller);
  }
}
