class PushNotification {
  PushNotification({
    required this.to,
    required this.notification,
    required this.data,
  });
  late final String to;
  late final Notification notification;
  late final Data data;
  
  PushNotification.fromJson(Map<String, dynamic> json){
    to = json['to'];
    notification = Notification.fromJson(json['notification']);
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['to'] = to;
    _data['notification'] = notification.toJson();
    _data['data'] = data.toJson();
    return _data;
  }
}

class Notification {
  Notification({
    required this.body,
    required this.title,
  });
  late final String body;
  late final String title;
  
  Notification.fromJson(Map<String, dynamic> json){
    body = json['body'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['body'] = body;
    _data['title'] = title;
    return _data;
  }
}

class Data {
  Data({
    required this.body,
    required this.title,
    required this.key_1,
    required this.key_2,
    required this.imageUrl,
  });
  late final String body;
  late final String title;
  late final String key_1;
  late final String key_2;
  late final String imageUrl;
  
  Data.fromJson(Map<String, dynamic> json){
    body = json['body'];
    title = json['title'];
    key_1 = json['key_1'];
    key_2 = json['key_2'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['body'] = body;
    _data['title'] = title;
    _data['key_1'] = key_1;
    _data['key_2'] = key_2;
    _data['image_url'] = imageUrl;
    return _data;
  }
}