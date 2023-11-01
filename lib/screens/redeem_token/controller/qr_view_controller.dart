import 'package:get/get.dart';
import 'package:nippon_dost/resources/models/qr_scan_model.dart';

class QrViewContoller extends GetxController{
  // RxBool value = false.obs;
  RxBool value = true.obs;
  RxList<QrScanModel> scannedQr = <QrScanModel>[].obs;
  RxList<int> scannedQrIds = <int>[].obs;
  RxList<String> scannedQrs = <String>[].obs;
  RxList<String> scannedValidationIds = <String>[].obs;

  void toggle(bool newVal) => value.value = newVal;
  void addToScannedList(QrScanModel qrScanned){
    scannedQr.add(qrScanned);
    // scannedQrIds.add(qrScanned.data!.qrCode.id!);
    // scannedQrs.add(qrScanned.data!.qrCode.qrCode!);
  }
  
}