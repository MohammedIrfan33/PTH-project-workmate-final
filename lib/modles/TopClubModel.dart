import 'dart:convert';
class TopClubModel {
  String name;
  String amount;
  String packet;

  TopClubModel({
    required this.name,
    required this.amount,
    required this.packet,
  });

  factory TopClubModel.fromJson(Map<String, dynamic> json) => TopClubModel(
    name: json["name"],
    amount: json["amount"], packet: '${json["packet"]}',
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "amount": amount,
  };
}
