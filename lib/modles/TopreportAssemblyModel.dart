

class TopReportassemblyModel {
  String name;
  String amount;
  String panchayat;
  String packet;

  TopReportassemblyModel({
    required this.name,
    required this.amount,
    required this.panchayat,
    required this.packet
  });

  factory TopReportassemblyModel.fromJson(Map<String, dynamic> json) => TopReportassemblyModel(
    name: json["name"],
    amount: json["amount"],
    panchayat: json["panchayat"]??"", 
    packet: json["packet"]??''

  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "amount": amount,
    "panchayat": panchayat,
    "packaet": packet
  };
}
