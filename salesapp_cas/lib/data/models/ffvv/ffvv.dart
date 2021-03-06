import 'package:hive/hive.dart';

part 'ffvv.g.dart';

@HiveType(typeId: 3)
class Ffvv {
  @HiveField(0)
  final int ffvv;
  @HiveField(1)
  final int companyId;
  @HiveField(2)
  final int branchOfficeId;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String state;

  Ffvv({
    required this.ffvv,
    required this.companyId,
    required this.branchOfficeId,
    required this.description,
    required this.state,
  });

  factory Ffvv.fromJson(Map<String, dynamic> json) => Ffvv(
        ffvv: json["FFVV"],
        companyId: json["CompanyId"],
        branchOfficeId: json["BranchOfficeId"],
        description: json["Description"],
        state: json["State"],
      );

  Map<String, dynamic> toJson() => {
        "FFVV": ffvv,
        "CompanyId": companyId,
        "BranchOfficeId": branchOfficeId,
        "Description": description,
        "State": state,
      };
}
