// To parse this JSON data, do
//
//     final qrScanModel = qrScanModelFromJson(jsonString);

import 'dart:convert';

QrScanModel qrScanModelFromJson(String str) => QrScanModel.fromJson(json.decode(str));

String qrScanModelToJson(QrScanModel data) => json.encode(data.toJson());

class QrScanModel {
  QrScanModel({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory QrScanModel.fromJson(Map<String, dynamic> json) => QrScanModel(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    required this.point,
    required this.productName,
    required this.cash,
    required this.serioalNo,
    required this.time,
  });

  String point;
  String productName;
  String cash;
  dynamic serioalNo;
  String time;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    point: json["point"]??0,
    productName: json["product_name"]??'',
    cash: json["cash"]??0,
    serioalNo: json["serioal_no"]??0,
    time: json["time"]??'',
  );

  Map<String, dynamic> toJson() => {
    "point": point,
    "product_name": productName,
    "cash": cash,
    "serioal_no": serioalNo,
    "time": time,
  };
}
