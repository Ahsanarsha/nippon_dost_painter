import 'dart:convert';

SupportResponseModel supportResponseModelFromJson(String str) => SupportResponseModel.fromJson(json.decode(str));

String supportResponseModelToJson(SupportResponseModel data) => json.encode(data.toJson());

class SupportResponseModel {
  SupportResponseModel({
   required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory SupportResponseModel.fromJson(Map<String, dynamic> json) => SupportResponseModel(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    required this.ticketNo,
    required this.painterId,
    required this.message,
    required this.file,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  int ticketNo;
  String painterId;
  String message;
  String file;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    ticketNo: json["ticket_no"],
    painterId: json["painter_id"],
    message: json["message"],
    file: json["file"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "ticket_no": ticketNo,
    "painter_id": painterId,
    "message": message,
    "file": file,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}
