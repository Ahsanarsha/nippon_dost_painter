import 'dart:convert';

QrRedeemModel qrRedeemModelFromJson(String str) =>
    QrRedeemModel.fromJson(json.decode(str));

String qrRedeemToJson(QrRedeemModel data) => json.encode(data.toJson());


class QrRedeemModel {
  QrRedeemModel({
    required this.success,
    required this.data,
    required this.message,
  });
  late final bool success;
  late final String data;
  late final String message;
  
  QrRedeemModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data;
    _data['message'] = message;
    return _data;
  }
}