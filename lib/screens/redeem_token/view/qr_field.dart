import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/components/txt_field.dart';
import 'package:nippon_dost/controllers/text_field_controller.dart';
import 'package:nippon_dost/screens/app_widgets/loading_widget.dart';
import 'package:nippon_dost/screens/redeem_token/bloc/qr_scan_bloc.dart';
import 'package:nippon_dost/screens/redeem_token/controller/qr_view_controller.dart';
import 'package:nippon_dost/utils/app_colors.dart';

class QrField extends StatelessWidget {
  const QrField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QrViewContoller _qvc = Get.put(QrViewContoller());
    TextFieldController _tfc = Get.put(TextFieldController());

    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.10.sw,
            vertical: 0.01.sh,
          ),
          child: Text(
            'qr_code'.tr,
            style: TextStyle(fontSize: 16.sp),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.10.sw),
          child: TxtField(
            txtStyle: TextStyle(fontSize: 16.sp),
            autofocus: false,
            txtInputType: TextInputType.text,
            txtAlign: TextAlign.center,
            hintTxt: 'enter_qr_code'.tr,
            borderRadius: 10,
            borderColor: Colors.grey.shade400,
            borderStyle: BorderStyle.solid,
            borderWidth: 1,
            etController: _tfc.tec,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 0.20.sw,
            vertical: 0.02.sh,
          ),
          width: 1.0.sw,
          child: ElevatedButton(
            onPressed: () async {
              if(_tfc.tec.text.isNotEmpty){
                // SystemChannels.textInput.invokeMethod('TextInput.hide');
                FocusScope.of(context).requestFocus(FocusNode());
                // if (_qvc.scannedQrs.contains(_tfc.tec.text.trim())) {
                if (_qvc.scannedValidationIds.contains(_tfc.tec.text.trim())) {
                  Get.snackbar(
                    'qr_scan'.tr,
                    'qr_already_in_list'.tr,
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: main_color,
                    colorText: Colors.white,
                  );
                } else {
                  loadingWidget(context);
                  await qrScanBloc.qrScanRequest(_tfc.tec.text.trim());
                  Get.back();
                  var qsm = qrScanBloc.qrScanModel;
                  if (qsm.success == true) {
                    _qvc.addToScannedList(qsm);
                    _qvc.scannedQrIds.add(qsm.data.serioalNo);
                    _qvc.scannedValidationIds.add(_tfc.tec.text.trim());
                    _tfc.tec.text = '';
                  } else {
                    Get.snackbar('Qr Scan', '${qsm.message}',
                        snackPosition: SnackPosition.BOTTOM,
                        duration: Duration(seconds: 3),
                        backgroundColor: main_color,
                        colorText: Colors.white);
                  }
                }
              }else{
                Get.snackbar('sorry'.tr, 'enter_qr_code'.tr);
              }

            },
            child: Text('scan'.tr),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Colors.indigo.shade600),
            ),
          ),
        ),
      ],
    );
  }
}
