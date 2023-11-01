import 'dart:convert';

CashRedeemHistoryModel cashRedeemHistoryModelFromJson(String str) => CashRedeemHistoryModel.fromJson(json.decode(str));

String cashRedeemHistoryModelToJson(CashRedeemHistoryModel data) => json.encode(data.toJson());

class CashRedeemHistoryModel {
  CashRedeemHistoryModel({
   required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  List<CashRedeemHistory> data;
  String message;

  factory CashRedeemHistoryModel.fromJson(Map<String, dynamic> json) => CashRedeemHistoryModel(
    success: json["success"],
    data: List<CashRedeemHistory>.from(json["data"].map((x) => CashRedeemHistory.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class CashRedeemHistory {
  CashRedeemHistory({
   required this.cash,
   required this.dealerId,
   required this.createdAt,
   required this.dealer,
  });

  int cash;
  int dealerId;
  String createdAt;
  Dealer dealer;

  factory CashRedeemHistory.fromJson(Map<String, dynamic> json) => CashRedeemHistory(
    cash: json["Cash"]??0,
    dealerId: json["dealer_id"]??0,
    createdAt: json["created_at"]??'',
    dealer: Dealer.fromJson(json["dealer"]),
  );

  Map<String, dynamic> toJson() => {
    "Cash": cash,
    "dealer_id": dealerId,
    "created_at": createdAt,
    "dealer": dealer.toJson(),
  };
}

class Dealer {
  Dealer({
    required this.id,
    required this.regionId,
    required this.cityId,
    this.popupBannerId,
    required this.salePerson,
    required this.name,
    required this.dealerName,
    required this.primaryNumber,
    this.secondaryNumber,
    required this.dealerCode,
    required this.cnic,
    required  this.address,
    required this.otp,
    this.dealerImg,
    required this.dealerStatus,
    required this.cash,
    required this.points,
    this.fcmToken,
    required this.networkProvider,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int regionId;
  int cityId;
  dynamic popupBannerId;
  String salePerson;
  String name;
  String dealerName;
  String primaryNumber;
  dynamic secondaryNumber;
  String dealerCode;
  String cnic;
  String address;
  int otp;
  dynamic dealerImg;
  int dealerStatus;
  int cash;
  int points;
  dynamic fcmToken;
  String networkProvider;
  DateTime createdAt;
  DateTime updatedAt;

  factory Dealer.fromJson(Map<String, dynamic> json) => Dealer(
    id: json["id"]??0,
    regionId: json["region_id"]??0,
    cityId: json["city_id"]??0,
    popupBannerId: json["popup_banner_id"]??0,
    salePerson: json["sale_person"]??'',
    name: json["name"]??'',
    dealerName: json["dealer_name"]??'',
    primaryNumber: json["primary_number"]??'',
    secondaryNumber: json["secondary_number"]??'',
    dealerCode: json["dealer_code"]??'',
    cnic: json["cnic"]??'',
    address: json["address"]??'',
    otp: json["otp"]??0,
    dealerImg: json["dealer_img"]??'',
    dealerStatus: json["dealer_status"]??0,
    cash: json["cash"]??0,
    points: json["points"]??0,
    fcmToken: json["fcm_token"]??'',
    networkProvider: json["network_provider"]??'',
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "region_id": regionId,
    "city_id": cityId,
    "popup_banner_id": popupBannerId,
    "sale_person": salePerson,
    "name": name,
    "dealer_name": dealerName,
    "primary_number": primaryNumber,
    "secondary_number": secondaryNumber,
    "dealer_code": dealerCode,
    "cnic": cnic,
    "address": address,
    "otp": otp,
    "dealer_img": dealerImg,
    "dealer_status": dealerStatus,
    "cash": cash,
    "points": points,
    "fcm_token": fcmToken,
    "network_provider": networkProvider,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
