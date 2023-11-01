// To parse this JSON data, do
//
//     final promotionalImageModel = promotionalImageModelFromJson(jsonString);

import 'dart:convert';

PromotionalImageModel promotionalImageModelFromJson(String str) => PromotionalImageModel.fromJson(json.decode(str));

String promotionalImageModelToJson(PromotionalImageModel data) => json.encode(data.toJson());

class PromotionalImageModel {
  PromotionalImageModel({
   required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory PromotionalImageModel.fromJson(Map<String, dynamic> json) => PromotionalImageModel(
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
    required this.id,
    required this.title,
    required this.description,
    required this.bannerImg,
    required this.source,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String title;
  String description;
  String bannerImg;
  String source;
  DateTime startDate;
  DateTime endDate;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    bannerImg: json["banner_img"],
    source: json["source"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "banner_img": bannerImg,
    "source": source,
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
