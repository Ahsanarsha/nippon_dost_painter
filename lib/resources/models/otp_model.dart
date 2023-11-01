import 'dart:convert';

OtpModel otpModelFromJson(String str) =>
    OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
  OtpModel({
    required this.success,
    required this.data,
    required this.message,
  });
  late final bool success;
  late final OtpData data;
  late final String message;
  
  OtpModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = OtpData.fromJson(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.toJson();
    _data['message'] = message;
    return _data;
  }
}

class OtpData {
  OtpData({
    required this.painter,
    required this.painterStatus,
    required this.token,
  });
  late final OtpPainter painter;
  late final String painterStatus;
  late final String token;
  
  OtpData.fromJson(Map<String, dynamic> json){
    painter = OtpPainter.fromJson(json['painter']);
    painterStatus = json['painter_status'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['painter'] = painter.toJson();
    _data['painter_status'] = painterStatus;
    _data['token'] = token;
    return _data;
  }
}

class OtpPainter {
  OtpPainter({
    required this.id,
    required this.primaryNumber,
  });
  late final int id;
  late final String primaryNumber;
  
  OtpPainter.fromJson(Map<String, dynamic> json){
    id = json['id'];
    primaryNumber = json['primary_number'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['primary_number'] = primaryNumber;
    return _data;
  }
}