class CashHistoryModel {
  CashHistoryModel({
    required this.cash,
    required this.dealer,
    required this.date,
  });

  late final String cash;
  late final String dealer;
  late final String date;

  CashHistoryModel.fromJson(Map<String, dynamic> json) {
    cash = json['cash'];
    dealer = json['dealer'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cash'] = cash;
    _data['dealer'] = dealer;
    _data['date'] = date;
    return _data;
  }
}
