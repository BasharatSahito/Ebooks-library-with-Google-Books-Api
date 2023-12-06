import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewUrl extends StatefulWidget {
  final String url;
  const ViewUrl({super.key, required this.url});

  @override
  State<ViewUrl> createState() => _ViewUrlState();
}

class _ViewUrlState extends State<ViewUrl> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    print(widget.url);
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
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Simple Example')),
      body: WebViewWidget(controller: controller),
    );
  }
}
