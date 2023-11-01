
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nippon_dost/screens/login/view/next.dart';
import 'package:nippon_dost/screens/login/view/switch_language.dart';
import 'package:nippon_dost/screens/login/view/login_form.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:nippon_dost/utils/app_images.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: main_color,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween ,
            children: [
              Container(
                width: double.infinity  ,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(top_bg),
                        fit: BoxFit.fill
                    )
                ),
              ),
              Image.asset(login_title),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.20.sw, vertical: 0.02.sh),
                child: Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 21.sp,
                      fontWeight:FontWeight.w400
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              LoginForm(),
              Next(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 0.01.sh),
                padding: EdgeInsets.symmetric(horizontal: 0.30.sw),
                child: SwitchLanguage(),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 70),
                  Image.asset(nippon_paint_logo),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}