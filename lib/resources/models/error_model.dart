import 'dart:convert';

ErrorModel errorModelFromJson(String str) =>
    ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  ErrorModel({
    required this.success,
    required this.data,
    required this.message,
  });
  bool success = false;
  String message = 'msg';
  Data data = Data(error: '') ;
  
  ErrorModel.fromJson(Map<String, dynamic> json){
    success = json['success']??false;
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : Data(error: '');
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.error,
  });
  late final String error;
  
  Data.fromJson(Map<String, dynamic> json){
    error = json['error']??'';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = error;
    return _data;
  }
}