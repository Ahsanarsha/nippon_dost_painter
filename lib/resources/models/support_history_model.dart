import 'dart:convert';

SupportHistoryModel supportHistoryModelFromJson(String str) => SupportHistoryModel.fromJson(json.decode(str));

String supportHistoryModelToJson(SupportHistoryModel data) => json.encode(data.toJson());

class SupportHistoryModel {
  bool? success;
  List<Data>? data;
  String? message;

  SupportHistoryModel({this.success, this.data, this.message});

  SupportHistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  int? ticketNo;
  int? painterId;
  int? dealerId;
  int? replyId;
  String? message;
  String? file;
  String? status;
  String? type;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.ticketNo,
        this.painterId,
        this.dealerId,
        this.replyId,
        this.message,
        this.file,
        this.status,
        this.type,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    ticketNo = json['ticket_no']??0;
    painterId = json['painter_id']??0;
    dealerId = json['dealer_id']??0;
    replyId = json['reply_id']??0;
    message = json['message']??'';
    file = json['file'];
    status = json['status'];
    type = json['type']??'';
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticket_no'] = this.ticketNo;
    data['painter_id'] = this.painterId;
    data['dealer_id'] = this.dealerId;
    data['reply_id'] = this.replyId;
    data['message'] = this.message;
    data['file'] = this.file;
    data['status'] = this.status;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}