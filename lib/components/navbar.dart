import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nippon_dost/controllers/navbar_controller.dart';
import 'package:nippon_dost/packages/nav_bar/custom_nav_bar.dart';
import 'package:nippon_dost/routes/app_pages.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:nippon_dost/utils/app_images.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavbarController _nc = Get.put(NavbarController());

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: Obx(
        () => SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 0.02.sw,
              vertical: 0.01.sh,
            ),
            child: CNav(
              rippleColor:
                  Color(0xff5d6ab4), // tab button ripple color when pressed
              // hoverColor: Colors.grey[700]!, // tab button hover color
              // haptic: true, // haptic feedback
              tabBorderRadius: 12,
              // tabActiveBorder: Border.all(color: Colors.black, width: 1), // tab button border
              // tabBorder:
              //     Border.all(color: Colors.grey, width: 1), // tab button border
              // tabShadow: [
              //   BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
              // ], // tab button shadow
              curve: Curves.easeInCubic, // tab animation curves
              // duration: Duration(milliseconds: 500), // tab animation duration
              gap: 5, // the tab button gap between icon and text
              color: Colors.black, // unselected icon color
              activeColor: _nc.isSelected.value
                  ? Colors.black
                  : Colors.white, // selected icon and text color
              iconSize: 30, // tab button icon size
              tabBackgroundColor: _nc.isSelected.value
                  ? Colors.transparent
                  : main_color, // selected tab background color
              padding: EdgeInsets.symmetric(
                  horizontal: 0.03.sw,
                  vertical: 0.01.sw), // navigation bar padding
              tabs: [
                CButton(
                  // icon: CustomIcons.home,
                  icon: home,
                  text: _nc.isSelected.value ? '' : 'home'.tr,
                ),
                CButton(
                  icon: slab,
                  text: _nc.isSelected.value ? '' : 'slab'.tr,
                ),
                CButton(
                  icon: profile,
                  text: _nc.isSelected.value ? '' : 'profile'.tr,
                ),
                CButton(
                  icon: history,
                  text: _nc.isSelected.value ? '' : 'history'.tr,
                )
              ],
              selectedIndex: _nc.index.value,
              onTabChange: (index) {
                if (_nc.isBack.value) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('are_you_sure'.tr),
                      content: Text(
                          'do_you_want_to_go_back'.tr),
                        actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text('no'.tr),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                            Get.offAndToNamed(Routes.Home);
                            _nc.goBack(false);
                            _nc.changeBar(false);
                            _nc.changeIndex(index);
                          },
                          child: Text('yes'.tr),
                        ),
                      ],
                    ),
);
                } else if (_nc.isSelected.value) {
                  Get.offAndToNamed(Routes.Home);
                  _nc.goBack(false);
                  _nc.changeBar(false);
                  _nc.changeIndex(index);
                } else {
                  _nc.goBack(false);
                  _nc.changeBar(false);
                  _nc.changeIndex(index);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
