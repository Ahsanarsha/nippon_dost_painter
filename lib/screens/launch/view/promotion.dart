import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/screens/launch/controller/app_launch_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nippon_dost/screens/splash/view/splash_page.dart';

class Promotion extends StatelessWidget {
  const Promotion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        // statusBarColor: Color(0xFFFFB900),
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    AppLaunchController _alc = Get.put(AppLaunchController());
    _alc.getPromotionalImage();
    //To close pop up after timer
    // _alc.closePopUp();

    return SafeArea(
      child: Container(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: <Widget>[
           Obx(()=> _alc.networkImageURL.value!=''? CachedNetworkImage(
              imageUrl: _alc.networkImageURL.value,
             fit: BoxFit.fill,
             width: Get.width,
             height: Get.height,
              placeholder: (context, url) => SplashPage(),
              errorWidget: (context, url, error) => Text("Something went wrong"),
            ):SplashPage()),
           // Obx(()=> _alc.networkImageURL.value.isNotEmpty?
           // Image.network(
           //   "https://images.unsplash.com/photo-1547721064-da6cfb341d50",
           //   // _alc.networkImageURL.value,
           //   fit: BoxFit.fill,
           // ):Image.asset(
           //    _alc.promotionalImage,
           //    fit: BoxFit.fill,
           //    width: Get.width,
           //    height: Get.height,
           //  ),),
            Padding(
              padding: EdgeInsets.only(top: 0.sp),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => _alc.change(),
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
