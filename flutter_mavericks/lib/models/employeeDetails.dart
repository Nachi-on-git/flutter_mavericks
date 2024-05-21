// To parse this JSON data, do
//
//     final employeeDetails = employeeDetailsFromJson(jsonString);

import 'dart:convert';

EmployeeDetails employeeDetailsFromJson(String str) => EmployeeDetails.fromJson(json.decode(str));

String employeeDetailsToJson(EmployeeDetails data) => json.encode(data.toJson());

class EmployeeDetails {
  bool? status;
  String? message;
  Data? data;

  EmployeeDetails({
    this.status,
    this.message,
    this.data,
  });

  factory EmployeeDetails.fromJson(Map<String, dynamic> json) => EmployeeDetails(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? employeeRole;
  DateTime? joiningDate;
  String? address;
  String? projectName;
  String? reportingManager;
  String? reviewingManager;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.employeeRole,
    this.joiningDate,
    this.address,
    this.projectName,
    this.reportingManager,
    this.reviewingManager,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    employeeRole: json["employeeRole"],
    joiningDate: json["joiningDate"] == null ? null : DateTime.parse(json["joiningDate"]),
    address: json["address"],
    projectName: json["projectName"],
    reportingManager: json["reportingManager"],
    reviewingManager: json["reviewingManager"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phoneNumber": phoneNumber,
    "employeeRole": employeeRole,
    "joiningDate": joiningDate?.toIso8601String(),
    "address": address,
    "projectName": projectName,
    "reportingManager": reportingManager,
    "reviewingManager": reviewingManager,
  };
}
