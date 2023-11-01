// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

SupportModel supportFromJson(String str) =>
    SupportModel.fromJson(json.decode(str));

String supportToJson(SupportModel data) => json.encode(data.toJson());

class SupportModel {
  SupportModel({
    required this.ticketNo,
    required this.description,
    required this.status,
    required this.date,
    required this.time,
  });

  late final String ticketNo;
  late final String description;
  late final String status;
  late final String date;
  late final String time;

  SupportModel.fromJson(Map<String, dynamic> json) {
    ticketNo = json['ticketNo'];
    description = json['description'];
    status = json['status'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ticketNo'] = ticketNo;
    _data['description'] = description;
    _data['status'] = status;
    _data['date'] = date;
    _data['time'] = time;
    return _data;
  }
}
