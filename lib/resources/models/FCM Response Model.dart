import 'dart:convert';

FcmResponseModel fcmResponseModelFromJson(String str) => FcmResponseModel.fromJson(json.decode(str));

String fcmResponseModelToJson(FcmResponseModel data) => json.encode(data.toJson());

class FcmResponseModel {
  FcmResponseModel({
   required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory FcmResponseModel.fromJson(Map<String, dynamic> json) => FcmResponseModel(
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
    required this.fcmToken,
  });

  String fcmToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    fcmToken: json["FCMToken"],
  );

  Map<String, dynamic> toJson() => {
    "FCMToken": fcmToken,
  };
}
