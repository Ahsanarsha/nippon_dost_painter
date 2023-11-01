import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/components/app_bar.dart';
import 'package:nippon_dost/components/navbar.dart';
import 'package:nippon_dost/resources/models/profile_model.dart';
import 'package:nippon_dost/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:nippon_dost/screens/profile/bloc/profile_bloc.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileModel _pm = profileBloc.profileData;
    return Scaffold(
      appBar: mainAppBar,
      // bottomNavigationBar: NavBar(),
      body: WillPopScope(
        onWillPop: ()async{
          dashboardBloc.refreshDataWithBack();
          return true;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0.10.sw, 0.05.sh, 0.10.sw, 0),
              child: QrImage(
                data: _pm.data[0].primaryNumber.toString(),
                version: QrVersions.auto,
                gapless: true,
                // size: 200,
                // embeddedImage: AssetImage('assets/images/img.jpg'),
                embeddedImageStyle: QrEmbeddedImageStyle(size: Size(100, 100)),
                errorStateBuilder: (ctx, err) {
                  return Container(
                    child: Center(
                      child: Text('Something went wrong ${err.toString}'),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.20.sw, 0.05.sh, 0.20.sw, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    _pm.data[0].primaryNumber.toString(),
                    style: TextStyle(
                      color: main_color,
                      fontSize: 24.sm,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
