import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) =>
    DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  DashboardModel({
    required this.success,
    required this.data,
    required this.message,
  });
  late final bool success;
  late final DashboardData data;
  late final String message;
  
  DashboardModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = DashboardData.fromJson(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.toJson();
    _data['message'] = message;
    return _data;
  }
}

class DashboardData {
  DashboardData({
    required this.cash,
    required this.points,
  });
  late final num cash;
  late final int points;
  
  DashboardData.fromJson(Map<String, dynamic> json){
    cash = json['cash'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cash'] = cash;
    _data['points'] = points;
    return _data;
  }
}