import 'package:hive/hive.dart';

part "Coupans.g.dart";

@HiveType(typeId: 5)
class Coupan {
  Coupan({
    this.usedBy,
    this.id,
    this.coupanCode,
    this.v,
  });
  @HiveField(0)
  String usedBy;
  @HiveField(1)
  String id;
  @HiveField(2)
  String coupanCode;
  @HiveField(3)
  int v;

  factory Coupan.fromJson(Map<String, dynamic> json) => Coupan(
        usedBy: json["usedBy"],
        id: json["_id"],
        coupanCode: json["coupanCode"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "usedBy": usedBy,
        "_id": id,
        "coupanCode": coupanCode,
        "__v": v,
      };
}
