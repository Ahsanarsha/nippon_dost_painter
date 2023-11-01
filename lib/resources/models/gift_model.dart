import 'dart:convert';

GiftModel giftModelFromJson(String str) =>
    GiftModel.fromJson(json.decode(str));

String giftModelToJson(GiftModel data) => json.encode(data.toJson());

class GiftModel {
  GiftModel({
    required this.success,
    required this.data,
    required this.message,
  });
  late final bool success;
  late final List<GiftData> data;
  late final String message;
  
  GiftModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = List.from(json['data']).map((e)=>GiftData.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }
}

class GiftData {
  GiftData({
    required this.id,
    required this.name,
    required this.giftPoint,
  });
  late final int id;
  late final String name;
  late final dynamic giftPoint;
  
  GiftData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    giftPoint = json['gift_point']??0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['gift_point'] = giftPoint;
    return _data;
  }
}