


class TopReportpanchayatModel {
  String name;
  String amount;
  String packet;

  TopReportpanchayatModel({
    required this.name,
    required this.amount,
    required this.packet
  });

  factory TopReportpanchayatModel.fromJson(Map<String, dynamic> json) => TopReportpanchayatModel(
    name: json["name"],
    amount: json["amount"],
     packet: json["packet"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "amount": amount,
  };
}
