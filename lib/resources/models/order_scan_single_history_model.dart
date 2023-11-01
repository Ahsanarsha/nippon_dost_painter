import 'dart:convert';

OrderScanSingleHistoryModel orderScanSingleHistoryModelFromJson(String str) => OrderScanSingleHistoryModel.fromJson(json.decode(str));

String orderScanSingleHistoryModelToJson(OrderScanSingleHistoryModel data) => json.encode(data.toJson());

class OrderScanSingleHistoryModel {
  OrderScanSingleHistoryModel({
   required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory OrderScanSingleHistoryModel.fromJson(Map<String, dynamic> json) => OrderScanSingleHistoryModel(
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
    required this.scanQr,
  });

  List<ScanQr> scanQr;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    scanQr: List<ScanQr>.from(json["scan-qr"].map((x) => ScanQr.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "scan-qr": List<dynamic>.from(scanQr.map((x) => x.toJson())),
  };
}

class ScanQr {
  ScanQr({
    required this.productId,
    required this.updatedAt,
    required this.product,
  });

  int productId;
  DateTime updatedAt;
  Product product;

  factory ScanQr.fromJson(Map<String, dynamic> json) => ScanQr(
    productId: json["product_id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "updated_at": updatedAt.toIso8601String(),
    "product": product.toJson(),
  };
}

class Product {
  Product({
    required  this.id,
    required  this.userId,
    required  this.brandId,
    required this.productTypeId,
    required this.name,
    required this.tokenCash,
    required this.points,
    required this.packSize,
    required this.code,
    this.productImg,
    required this.productStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  int brandId;
  int productTypeId;
  String name;
  String tokenCash;
  String points;
  String packSize;
  String code;
  dynamic productImg;
  int productStatus;
  DateTime createdAt;
  DateTime updatedAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"]??0,
    userId: json["user_id"]??0,
    brandId: json["brand_id"]??0,
    productTypeId: json["product_type_id"]??0,
    name: json["name"]??'',
    tokenCash: json["token_cash"]??'',
    points: json["points"]??'',
    packSize: json["pack_size"]??'',
    code: json["code"]??'',
    productImg: json["product_img"],
    productStatus: json["product_status"]??0,
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "brand_id": brandId,
    "product_type_id": productTypeId,
    "name": name,
    "token_cash": tokenCash,
    "points": points,
    "pack_size": packSize,
    "code": code,
    "product_img": productImg,
    "product_status": productStatus,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
