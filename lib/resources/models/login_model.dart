import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());


class LoginModel {
  LoginModel({
    required this.success,
    required this.data,
    required this.message,
  });
  late final bool success;
  late final int data;
  late final String message;
  
  LoginModel.fromJson(Map<String, dynamic> json){
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