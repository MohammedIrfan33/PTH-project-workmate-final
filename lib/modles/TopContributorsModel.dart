class Topcontributorsmodel {


  String name;
  String amount;
  String packet;


  Topcontributorsmodel({required this.name,required this.amount, required this.packet});  

  factory Topcontributorsmodel.fromJson(Map<String, dynamic> json) => Topcontributorsmodel(
    amount: json["amount"],
    name: json["name"],
    packet: json["packet"],
  );


}