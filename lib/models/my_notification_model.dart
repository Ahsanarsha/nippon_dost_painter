class MyNotificationModel {
    String body;
    String title;
    DateTime time;

    MyNotificationModel({
      required this.body,
      required this.title,
      required this.time,

    });
 factory MyNotificationModel.fromJson(Map<String, dynamic> json)
 {
    return MyNotificationModel(
      body: json['body'],
      title: json['title'],
      time: DateTime.parse(json['time']),
    );
  }

  Map<String, dynamic> toJson()=>
     <String, dynamic>{
   'body' : body,
   'time' : time.toString(),
   'title' : title
  };


}