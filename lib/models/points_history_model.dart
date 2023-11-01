class PointsHistoryModel {
  PointsHistoryModel({
    required this.points,
    required this.gifts,
    required this.status,
  });

  late final String points;
  late final String gifts;
  late final String status;

  PointsHistoryModel.fromJson(Map<String, dynamic> json) {
    points = json['points'];
    gifts = json['gifts'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['points'] = points;
    _data['gifts'] = gifts;
    _data['status'] = status;
    return _data;
  }
}
