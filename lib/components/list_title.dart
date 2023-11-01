import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListTitle extends StatelessWidget {
  const ListTitle({this.txt, Key? key}) : super(key: key);

  final String? txt;

  @override
  Widget build(BuildContext context) {
    return Text(
      txt!,
      style: TextStyle(
        color: Color(0xFF03428D),
        fontSize: 14.sm,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
