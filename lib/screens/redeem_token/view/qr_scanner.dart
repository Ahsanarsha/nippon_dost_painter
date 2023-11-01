import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/resources/models/qr_scan_model.dart';
import 'package:nippon_dost/screens/redeem_token/bloc/qr_scan_bloc.dart';
import 'package:nippon_dost/screens/redeem_token/controller/qr_view_controller.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  QRViewController? controller;
  bool showButton = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QrViewContoller _qvc = Get.put(QrViewContoller());

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
      print('object=========');
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  inititalizer(){
    Future.delayed(Duration(seconds: 2),(){
      print('object');
      setState(() {

      });
    });
  }
  @override
  void initState() {
    inititalizer();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(flex: 2, child: showButton?
        Center(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          Spacer(flex: 1,),
          Text(
            'Scan Another',
            style: TextStyle(
              fontSize: 25.sm,
              color: Colors.indigo.shade600,
            ),
          ),
          Spacer(flex: 1,),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 0.20.sw,
              vertical: 0.02.sh,
            ),
            width: 1.0.sw,
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  showButton = false;
                });
              },
              child: Text('Scan Another'),
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(Colors.indigo.shade600),
              ),
            ),
          ),
          Spacer(flex: 1,),
        ],),)
            :  _buildQrView(context)),
      ],
    );
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.indigo.shade700,
          // borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 0.50.sw),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    int duplicateCounter = 0;
    print('qr view created');
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      await controller.pauseCamera();
      // Future.delayed(Duration(milliseconds: 200));
      var result = _qvc.scannedValidationIds.contains(scanData.code!);
     if(!result){
       duplicateCounter = 0;
       await qrScanBloc.qrScanRequest(scanData.code!);
       // QrScanModel qsm = qrScanBloc.qrScanModel;
       var response = qrScanBloc.qrScanModel;
       if(response.success) {
         QrScanModel qsm = response;
         if(!_qvc.scannedValidationIds.contains(scanData.code!))
           {
             _qvc.scannedValidationIds.add(scanData.code!);
             _qvc.scannedValidationIds.refresh();
             _qvc.addToScannedList(qsm);
             _qvc.scannedQrIds.add(int.parse(qsm.data.serioalNo.toString()));
             setState(() {
               showButton = true;
             });

           }else{
           setState(() {
             showButton = true;
           });

         }
       }else{
         setState(() {
           showButton = true;
         });
         controller.resumeCamera();
         Get.snackbar(
           'sorry'.tr,
           response.message.toString(),
           backgroundColor: main_color,
           colorText: Colors.white,
           snackPosition: SnackPosition.BOTTOM,
           duration: Duration(seconds: 3),
         );
         ///Show SnackBar here

       }
     }else{
       if(duplicateCounter==0){
         setState(() {
           showButton = true;
         });
         Get.snackbar(
           'sorry'.tr,
           'already_scanned'.tr,
           backgroundColor: main_color,
           colorText: Colors.white,
           snackPosition: SnackPosition.BOTTOM,
           duration: Duration(seconds: 3),
         );
         duplicateCounter=1;
       }

     }
    });
    controller.pauseCamera();
    controller.resumeCamera();
    setState(() {

    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('no_permission'.tr)),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}