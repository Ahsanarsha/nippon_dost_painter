// To parse this JSON data, do
//
//     final giftDetailsModel = giftDetailsModelFromJson(jsonString);

import 'dart:convert';

GiftDetailsModel giftDetailsModelFromJson(String str) => GiftDetailsModel.fromJson(json.decode(str));

String giftDetailsModelToJson(GiftDetailsModel data) => json.encode(data.toJson());

class GiftDetailsModel {
  GiftDetailsModel({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory GiftDetailsModel.fromJson(Map<String, dynamic> json) => GiftDetailsModel(
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
    required this.name,
    required this.giftPoint,
    this.regionId,
    required this.userId,
    required this.giftValue,
    required this.bussinessSegmentId,
    required this.deliveryDays,
    required this.slabStatus,
    required this.slabImg,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String giftPoint;
  dynamic regionId;
  int userId;
  String giftValue;
  String bussinessSegmentId;
  String deliveryDays;
  String slabStatus;
  String slabImg;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    giftPoint: json["gift_point"],
    regionId: json["region_id"]??1,
    userId: json["user_id"],
    giftValue: json["gift_value"],
    bussinessSegmentId: json["bussiness_segment_id"],
    deliveryDays: json["delivery_days"],
    slabStatus: json["slab_status"],
    slabImg: json["slab_img"],
    description: json["description"]??'',
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "gift_point": giftPoint,
    "region_id": regionId,
    "user_id": userId,
    "gift_value": giftValue,
    "bussiness_segment_id": bussinessSegmentId,
    "delivery_days": deliveryDays,
    "slab_status": slabStatus,
    "slab_img": slabImg,
    "description": description,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
