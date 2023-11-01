// To parse this JSON data, do
//
//     final pointsRedeemHistoryModel = pointsRedeemHistoryModelFromJson(jsonString);

import 'dart:convert';

PointsRedeemHistoryModel pointsRedeemHistoryModelFromJson(String str) => PointsRedeemHistoryModel.fromJson(json.decode(str));

String pointsRedeemHistoryModelToJson(PointsRedeemHistoryModel data) => json.encode(data.toJson());

class PointsRedeemHistoryModel {
  PointsRedeemHistoryModel({
   required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory PointsRedeemHistoryModel.fromJson(Map<String, dynamic> json) => PointsRedeemHistoryModel(
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
    required this.pointHistory,
    required this.giftname,
    required this.paintername,
  });

  List<PointHistory> pointHistory;
  String giftname;
  String paintername;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pointHistory: List<PointHistory>.from(json["point_history"].map((x) => PointHistory.fromJson(x))),
    giftname: json["giftname"]??'',
    paintername: json["paintername"],
  );

  Map<String, dynamic> toJson() => {
    "point_history": List<dynamic>.from(pointHistory.map((x) => x.toJson())),
    "giftname": giftname,
    "paintername": paintername,
  };
}

class PointHistory {
  PointHistory({
    required this.point,
    required this.dealerId,
    required this.giftId,
    required this.updatedAt,
    required this.status,
    required this.id,
    required this.dealer,
    required this.giftName,
  });

  int point;
  int dealerId;
  int giftId;
  DateTime updatedAt;
  String status;
  int id;
  Dealer dealer;
  GiftName giftName;

  factory PointHistory.fromJson(Map<String, dynamic> json){
    dynamic dealerResponse = json["dealer"];
    dynamic giftResponse = json["gift_name"];
   return  PointHistory(
        point: json["Point"],
        dealerId: json["dealer_id"],
        giftId: json["gift_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        id: json["id"],
        dealer: dealerResponse==null? Dealer(id: 0, dealerName: '') : Dealer.fromJson(json["dealer"]),
        giftName: giftResponse==null? GiftName(id: 0, name: 'name') : GiftName.fromJson(json["gift_name"]),

  );}

  Map<String, dynamic> toJson() => {
    "Point": point,
    "dealer_id": dealerId,
    "gift_id": giftId,
    "updated_at": updatedAt.toIso8601String(),
    "status": status,
    "id": id,
    "dealer": dealer.toJson(),
    "gift_name": giftName.toJson(),
  };
}

class Dealer {
  Dealer({
    required this.id,
    required this.dealerName,
  });

  int id;
  String dealerName;

  factory Dealer.fromJson(Map<String, dynamic> json) => Dealer(
    id: json["id"],
    dealerName: json["dealer_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dealer_name": dealerName,
  };
}

class GiftName {
  GiftName({
    required  this.id,
    required  this.name,
  });

  int id;
  String name;

  factory GiftName.fromJson(Map<String, dynamic> json) => GiftName(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
