class Timesheet {
  String? projectName;
  ProjectDetails projectData;

  Timesheet({required this.projectName, required this.projectData});

  factory Timesheet.fromJson(Map<String, dynamic> json) {
    return Timesheet(
      projectName: json['projectName'] ?? '',
      projectData: json['projectDetails'] != null
          ? ProjectDetails.fromJson(json['projectDetails'])
          : ProjectDetails.fromJson({}),
    );
  }
}

class ProjectDetails {
  double totalBillableHours;
  double totalNonBillableHours;
  int leaves;
  int extraWorkingDays;
  double totalWorkingHours;
  int totalWorkingDays;

  ProjectDetails(
      {required this.totalBillableHours,
      required this.extraWorkingDays,
      required this.leaves,
      required this.totalNonBillableHours,
      required this.totalWorkingHours,
      required this.totalWorkingDays});
  factory ProjectDetails.fromJson(Map<String, dynamic> json) {
    return ProjectDetails(
        totalBillableHours: json['totalBillableHours'] ?? 0.0,
        totalNonBillableHours: json['totalNonBillableHours'] ?? 0.0,
        leaves: json['leaves'] ?? 0,
        extraWorkingDays: json['extraWorkingDays'] ?? 0,
        totalWorkingHours: json['totalWorkingHours'] ?? 0.0,
        totalWorkingDays: json['totalWorkingDays'] ?? 0);
  }
}
