class AppraisalCard {
  String name;
  String date;
  String role;

  AppraisalCard({required this.name,required this.date,required this.role});
  factory AppraisalCard.fromJson(Map<String, dynamic> json) => AppraisalCard(
    name: json["status"],
    date: json["message"],
    role: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "date": date,
    "role": role,
  };
}