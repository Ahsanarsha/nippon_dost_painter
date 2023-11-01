import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/screens/redeem_token/controller/qr_view_controller.dart';
import 'package:nippon_dost/screens/redeem_token/view/qr_field.dart';
import 'package:nippon_dost/screens/redeem_token/view/qr_scanner.dart';
import 'package:nippon_dost/utils/app_colors.dart';

class QrView extends StatefulWidget {
  const QrView({Key? key}) : super(key: key);

  @override
  State<QrView> createState() => _QrViewState();
}

class _QrViewState extends State<QrView> {
  @override
  Widget build(BuildContext context) {
    QrViewContoller _qvc = Get.put(QrViewContoller());

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 0.01.sh,
        horizontal: 0.01.sh,
      ),
      width: 1.0.sw,
      height: 0.35.sh,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Obx(
            () => Visibility(
              visible: _qvc.value.value == false,
              child: Align(
                alignment: Alignment.center,
                child: QrScanner(),
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: _qvc.value.value == true,
              child: Align(
                alignment: Alignment.center,
                child: QrField(),
              ),
            ),
          ),
          Obx(
            () => _qvc.value.value?
            Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Manual', style: TextStyle(
                    fontSize: 14.sp,
                    color: main_color,
                  ),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Camera/Scan', style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(0xff8D8D8D),
                    )),
                  ),
                  Switch(
                    focusColor: Colors.white,
                    activeColor: Colors.indigo.shade800,
                    hoverColor: Colors.grey,
                    inactiveThumbColor: Colors.grey.shade100,
                    value: _qvc.value.value,
                    onChanged: (newVal) {
                      _qvc.toggle(newVal);
                    },
                  ),
                ],
              ),
            ):
            Align(
              alignment: Alignment.topRight,
              child: Switch(
                focusColor: Colors.white,
                activeColor: Colors.indigo.shade800,
                hoverColor: Colors.grey,
                inactiveThumbColor: Colors.grey.shade100,
                value: _qvc.value.value,
                onChanged: (newVal) {
                  print('here');
                  _qvc.toggle(newVal);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
