//This model class is deprecated
import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    required this.data,
  });
  late final List<ProfileData> data;

  ProfileModel.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>ProfileData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ProfileData {
  ProfileData({
    required this.id,
    required this.name,
    required this.city,
    required this.region,
     this.painterCode,
    required this.primaryNumber,
    required this.secondaryNumber,
    required this.cnic,
    required this.address,
    required this.createdAt,
    required this.painterImg,
  });
  late final int id;
  late final String name;
  late final String city;
  late final String region;
  late final Null painterCode;
  late final String primaryNumber;
  late final String secondaryNumber;
  late final String cnic;
  late final String address;
  late final String createdAt;
  String? painterImg;

  ProfileData.fromJson(Map<String, dynamic> json){
    id = json['id']??'';
    name = json['name']??'';
    city = json['city']??'';
    region = json['region']??'';
    painterCode = null;
    primaryNumber = json['primary_number'];
    secondaryNumber = json['secondary_number']?? '';
    cnic = json['cnic'];
    address = json['address']??'';
    createdAt = json['created_at']??'';
    painterImg = json['painter_img']??'';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['city'] = city;
    _data['region'] = region;
    _data['painter_code'] = painterCode;
    _data['primary_number'] = primaryNumber;
    _data['secondary_number'] = secondaryNumber;
    _data['cnic'] = cnic;
    _data['address'] = address;
    _data['created_at'] = createdAt;
    _data['painter_img'] = painterImg;
    return _data;
  }
}