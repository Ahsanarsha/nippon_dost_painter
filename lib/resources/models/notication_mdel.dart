// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

NotificationsModel notificationsFromJson(String str) =>
    NotificationsModel.fromJson(json.decode(str));

String notificationsToJson(NotificationsModel data) => json.encode(data.toJson());

class NotificationsModel {
  NotificationsModel({
    required this.description,
    required this.time,
  });

  late final String description;
  late final String time;

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['description'] = description;
    _data['time'] = time;
    return _data;
  }
}
