import 'dart:convert';

LogoutModel logoutModelFromJson(String str) =>
    LogoutModel.fromJson(json.decode(str));

String logoutModelToJson(LogoutModel data) => json.encode(data.toJson());



class LogoutModel {
  LogoutModel({
    required this.success,
    required this.message,
  });
  late final bool success;
  late final String message;
  
  LogoutModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    return _data;
  }
}