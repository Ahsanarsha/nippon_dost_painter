import 'dart:convert';

PrivacyPolicyModel privacyPolicyModelFromJson(String str) =>
    PrivacyPolicyModel.fromJson(json.decode(str));

String privacyPolicyModelToJson(PrivacyPolicyModel data) =>
    json.encode(data.toJson());

class PrivacyPolicyModel {
  PrivacyPolicyModel({
    required this.success,
    required this.data,
    required this.message,
  });
  late final bool success;
  late final PrivacyData data;
  late final String message;

  PrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = PrivacyData.fromJson(json['data']);
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

class PrivacyData {
  PrivacyData({
    required this.pages,
  });
  late final PrivacyPages pages;

  PrivacyData.fromJson(Map<String, dynamic> json) {
    pages = PrivacyPages.fromJson(json['pages']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pages'] = pages.toJson();
    return _data;
  }
}

class PrivacyPages {
  PrivacyPages({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String title;
  late final String description;
  late final String createdAt;
  late final String updatedAt;

  PrivacyPages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['description'] = description;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
