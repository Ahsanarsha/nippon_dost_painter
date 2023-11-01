import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DisplayNotification extends StatelessWidget {
  const DisplayNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;

    return Scaffold(
       appBar: AppBar(
        title: Text('app_name'.tr),
      ),
      body: ListView(
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.all(5.0),
        children: <Widget>[
          Text('Title: ${data.title}'),
          Text('Body: ${data.body}'),
          Text('Key_1: ${data.key_1}'),
          Text('Key_2: ${data.key_2}'),
          Image.network('${data.imageUrl}'),
        ],
      ),
    );
  }
}
