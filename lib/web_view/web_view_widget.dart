import 'dart:io';

import 'package:get/get.dart';
import 'package:nippon_dost/components/app_bar.dart';
import 'package:nippon_dost/screens/app_widgets/screen_banner.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:nippon_dost/utils/app_images.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class WebViewApp extends StatefulWidget {
  String title, url;

  WebViewApp(this.title, this.url);

  @override
  WebViewAppState createState() => WebViewAppState();
}

class WebViewAppState extends State<WebViewApp> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  int app_color = 0xFF03428D;
  bool isLoading = true;
  final _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: secondary_color,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Container(
              width: Get.width * 0.80,
              height: Get.height * 0.10,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  nippon_logo,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          actions: <Widget>[

          ],
        ),
          body: Stack(
            children: <Widget>[
              ScreenBanner(bannerText: widget.title.tr),
              WebView(
                key: _key,
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (finish) {
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Stack(),
            ],
          )),
    );
  }
}
