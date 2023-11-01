import 'dart:convert';

import 'package:nippon_dost/resources/models/order_scan_single_history_model.dart';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

OrderScanHistoryModel orderScanHistoryModelFromJson(String str) =>
    OrderScanHistoryModel.fromJson(json.decode(str));

String orderScanHistoryModelToJson(OrderScanHistoryModel data) =>
    json.encode(data.toJson());

class OrderScanHistoryModel {

  OrderScanHistoryModel({
    required this.success,
    required this.data,
    required this.message,
  });
  late final bool success;
  late final List<OrderScanData> data;
  late final String message;
  
  OrderScanHistoryModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = List.from(json['data']).map((e)=>OrderScanData.fromJson(e)).toList();
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

class OrderScanData {
  OrderScanData({
    required this.orderId,
    required this.updatedAt,
    required this.cash,
    required this.points,
  });
  late final dynamic orderId;
  late final String updatedAt;
  late final int cash;
  late final int points;
  
  OrderScanData.fromJson(Map<String, dynamic> json){
    orderId = json['order_id'];
    updatedAt = json['updated_at'];
    cash = json['cash'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['order_id'] = orderId;
    _data['updated_at'] = updatedAt;
    _data['cash'] = cash;
    _data['points'] = points;
    return _data;
  }
}