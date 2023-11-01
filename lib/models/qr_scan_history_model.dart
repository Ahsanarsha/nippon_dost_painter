import 'dart:convert';
QrScanHistoryModel qrScanHistoryModelFromJson(String str) => QrScanHistoryModel.fromJson(json.decode(str));
String qrScanHistoryModelToJson(QrScanHistoryModel data) => json.encode(data.toJson());
class QrScanHistoryModel {
  QrScanHistoryModel({
      bool? success, 
      QrHistory? qrhistory, 
      String? message,}){
    _success = success;
    _qrhistory = qrhistory;
    _message = message;
}

  QrScanHistoryModel.fromJson(dynamic json) {
    _success = json['success'];
    _qrhistory = json['qr-history'] != null ? QrHistory.fromJson(json['qr-history']) : null;
    _message = json['message'];
  }
  bool? _success;
  QrHistory? _qrhistory;
  String? _message;

  bool? get success => _success;
  QrHistory? get qrhistory => _qrhistory;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_qrhistory != null) {
      map['qr-history'] = _qrhistory?.toJson();
    }
    map['message'] = _message;
    return map;
  }

}

QrHistory qrHistoryFromJson(String str) => QrHistory.fromJson(json.decode(str));
String qrHistoryToJson(QrHistory data) => json.encode(data.toJson());
class QrHistory {
  QrHistory({
      int? currentPage, 
      List<Data>? data, 
      String? firstPageUrl, 
      int? from, 
      int? lastPage, 
      String? lastPageUrl, 
      List<Links>? links, 
      String? nextPageUrl, 
      String? path, 
      int? perPage, 
      dynamic prevPageUrl, 
      int? to, 
      int? total,}){
    _currentPage = currentPage;
    _data = data;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _links = links;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
}

  QrHistory.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }
  int? _currentPage;
  List<Data>? _data;
  String? _firstPageUrl;
  int? _from;
  int? _lastPage;
  String? _lastPageUrl;
  List<Links>? _links;
  String? _nextPageUrl;
  String? _path;
  int? _perPage;
  dynamic _prevPageUrl;
  int? _to;
  int? _total;

  int? get currentPage => _currentPage;
  List<Data>? get data => _data;
  String? get firstPageUrl => _firstPageUrl;
  int? get from => _from;
  int? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  List<Links>? get links => _links;
  String? get nextPageUrl => _nextPageUrl;
  String? get path => _path;
  int? get perPage => _perPage;
  dynamic get prevPageUrl => _prevPageUrl;
  int? get to => _to;
  int? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = _firstPageUrl;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['last_page_url'] = _lastPageUrl;
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['prev_page_url'] = _prevPageUrl;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }

}

Links linksFromJson(String str) => Links.fromJson(json.decode(str));
String linksToJson(Links data) => json.encode(data.toJson());
class Links {
  Links({
      dynamic url, 
      String? label, 
      bool? active,}){
    _url = url;
    _label = label;
    _active = active;
}

  Links.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }
  dynamic _url;
  String? _label;
  bool? _active;

  dynamic get url => _url;
  String? get label => _label;
  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      int? id, 
      String? painterId, 
      String? serioalNo, 
      String? qrCode, 
      dynamic pointRedemption, 
      dynamic uniqueCode, 
      dynamic giftName, 
      String? batchNo, 
      String? points, 
      String? balancePoints, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _painterId = painterId;
    _serioalNo = serioalNo;
    _qrCode = qrCode;
    _pointRedemption = pointRedemption;
    _uniqueCode = uniqueCode;
    _giftName = giftName;
    _batchNo = batchNo;
    _points = points;
    _balancePoints = balancePoints;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _painterId = json['painter_id'];
    _serioalNo = json['serioal_no'];
    _qrCode = json['qr_code'];
    _pointRedemption = json['point_redemption'];
    _uniqueCode = json['unique_code'];
    _giftName = json['gift_name'];
    _batchNo = json['batch_no'];
    _points = json['points'];
    _balancePoints = json['balance_points'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _painterId;
  String? _serioalNo;
  String? _qrCode;
  dynamic _pointRedemption;
  dynamic _uniqueCode;
  dynamic _giftName;
  String? _batchNo;
  String? _points;
  String? _balancePoints;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get painterId => _painterId;
  String? get serioalNo => _serioalNo;
  String? get qrCode => _qrCode;
  dynamic get pointRedemption => _pointRedemption;
  dynamic get uniqueCode => _uniqueCode;
  dynamic get giftName => _giftName;
  String? get batchNo => _batchNo;
  String? get points => _points;
  String? get balancePoints => _balancePoints;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['painter_id'] = _painterId;
    map['serioal_no'] = _serioalNo;
    map['qr_code'] = _qrCode;
    map['point_redemption'] = _pointRedemption;
    map['unique_code'] = _uniqueCode;
    map['gift_name'] = _giftName;
    map['batch_no'] = _batchNo;
    map['points'] = _points;
    map['balance_points'] = _balancePoints;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}