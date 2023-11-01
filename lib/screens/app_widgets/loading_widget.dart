import 'package:flutter/material.dart';
import 'package:nippon_dost/utils/app_images.dart';

loadingWidget(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Image.asset(loading);
    },
  );
}
