// To parse this JSON data, do
//
//     final updateProfileResponse = updateProfileResponseFromJson(jsonString);

import 'dart:convert';

UpdateProfileResponse updateProfileResponseFromJson(String str) => UpdateProfileResponse.fromJson(json.decode(str));

String updateProfileResponseToJson(UpdateProfileResponse data) => json.encode(data.toJson());

class UpdateProfileResponse {
  UpdateProfileResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) => UpdateProfileResponse(
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
    required this.painterImg,
    required this.id,
    required this.updatedAt,
  });

  String painterImg;
  int id;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    painterImg: json["painter_img"],
    id: json["id"],
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "painter_img": painterImg,
    "id": id,
    "updated_at": updatedAt.toIso8601String(),
  };
}
