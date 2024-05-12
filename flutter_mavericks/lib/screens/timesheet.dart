import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mavericks/design_system/color_system.dart';
import 'package:flutter_mavericks/design_system/padding_system.dart';
import 'package:flutter_mavericks/design_system/sizesystem.dart';
import 'package:flutter_mavericks/models/http_response.dart';
import 'package:flutter_mavericks/models/timehseet.dart';
import 'package:flutter_mavericks/services/timesheet_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Timesheets extends StatefulWidget {
  const Timesheets({super.key});

  @override
  State<Timesheets> createState() => _TimesheetsState();
}

class _TimesheetsState extends State<Timesheets> {
  List dates = [];
  List<Timesheet> timesheets = [];
  DateFormat dateFormatInput = DateFormat('dd-MMM-yyyy');
  int empId = 0;
  TimesheetService timesheetService = TimesheetService();
  List<Timesheet> myTimesheets = [];

  getEmpid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    empId = prefs.getInt('empId') ?? 0;
    print("empId : $empId");
  }

  // get days in month without weekends
  int getDaysWithoutWeekend(DateTime startDate, DateTime endDate) {
    int nbDays = endDate.difference(startDate).inDays + 1;
    List<int> days = List.generate(nbDays, (index) {
      int weekDay =
          DateTime(startDate.year, startDate.month, startDate.day + (index))
              .weekday;
      if (weekDay != DateTime.saturday && weekDay != DateTime.sunday) {
        return 1;
      }
      return 0;
    });
    return days.reduce((a, b) => a + b);
  }

  // get total days in months
  int getDaysInMonths() {
    if (dates.isEmpty) {
      return 0;
    }
    DateTime parsedDateTime = dateFormatInput.parse(dates[0].toString());
    // get month count
    int totalDaysInMonths = DateTimeRange(
        start: DateTime(parsedDateTime.year, parsedDateTime.month, 1),
        end: DateTime(
          parsedDateTime.year,
          parsedDateTime.month + 1,
        )).duration.inDays;
    DateTime startDate =
        DateTime(parsedDateTime.year, parsedDateTime.month, 01);
    DateTime endDate =
        DateTime(parsedDateTime.year, parsedDateTime.month, totalDaysInMonths);
    return getDaysWithoutWeekend(startDate, endDate);
  }

  void submitTimesheet() async {
    HttpResponses response;
    if (timesheets.isNotEmpty) {
      for (var timesheet in timesheets) {
        response = await timesheetService.submitTimesheetDetails({
          "employeeId": empId,
          "projectName": timesheet.projectName,
          "billableHours": timesheet.projectData.totalBillableHours,
          "nonBillableHours": timesheet.projectData.totalNonBillableHours,
          "leaves": timesheet.projectData.leaves,
          "extraWorkingDays": timesheet.projectData.extraWorkingDays,
          "comments": "N/A",
          "totalWorkingDays": timesheet.projectData.totalWorkingDays,
          "month":
              "${dateFormatInput.parse(dates[0].toString()).year - dateFormatInput.parse(dates[0].toString()).month}"
        });
        if (response.status!) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Timesheet submmited successfully !!"),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("${response.message}"),
          ));
        }
      }
    }
  }

  void getTimesheet() async {
    HttpResponses response = await timesheetService.getTimesheetDetails(empId);
    if (response.status!) {
      var data = response.data;
      print(data);
    } else {
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("${response.message}"),
          ));
    }
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );
    print("result : $result");
    if (result != null) {
      var bytes = File(result.files[0].path!).readAsBytesSync();
      var excelFile = Excel.decodeBytes(bytes);
      Timesheet singleTimesheetDetails;
      for (var table in excelFile.tables.keys) {
        for (var row in excelFile.tables[table]!.rows) {
          for (var cell in row) {
            final value = cell?.value;
            // first row as title i.e. 0
            if (cell!.rowIndex > 0) {
              if (cell.columnIndex == 2) {
                // add project name
                if (timesheets.isEmpty) {
                  timesheets.add(Timesheet.fromJson({
                    'projectName': value.toString(),
                    'projectDetails': null
                  }));
                } else {
                  Timesheet sheetDetails = timesheets.firstWhere(
                      (element) => element.projectName == value.toString(),
                      orElse: () => Timesheet.fromJson(
                          {'projectName': null, 'projectDetails': null}));
                  if (sheetDetails.projectName == null) {
                    timesheets.add(Timesheet.fromJson({
                      'projectName': value.toString(),
                      'projectDetails': null
                    }));
                  }
                }
              }

              // add hours
              singleTimesheetDetails = timesheets.firstWhere(
                  (element) => element.projectName == row[2]!.value.toString(),
                  orElse: () => Timesheet.fromJson(
                      {'projectName': null, 'projectDetails': null}));
              if (cell.columnIndex == 12) {
                singleTimesheetDetails.projectData.totalWorkingHours +=
                    double.parse(value.toString());
              }

              // add dates
              if (cell.columnIndex == 0) {
                if (dates.isEmpty) {
                  dates.add(value.toString());
                } else {
                  if (!dates.contains(value.toString())) {
                    dates.add(value.toString());
                  }
                }
              }

              // billing status
              if (cell.columnIndex == 14) {
                if (value.toString() == 'Non Billable') {
                  singleTimesheetDetails.projectData.totalNonBillableHours +=
                      double.parse(row[12]!.value.toString());
                } else {
                  singleTimesheetDetails.projectData.totalBillableHours +=
                      double.parse(row[12]!.value.toString());
                }
              }
            }
          }
        }
      }
      Future.delayed(const Duration(seconds: 2), () {
        int expectedWorkingDays = getDaysInMonths();
        if (dates.length < expectedWorkingDays) {
          for (var data in timesheets) {
            data.projectData.leaves = expectedWorkingDays - dates.length;
            data.projectData.totalWorkingDays = dates.length;
          }
        }
        submitTimesheet();
      });
    }
  }

  @override
  void initState() {
    getEmpid();
    getTimesheet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timesheets'),
      ),
      body: Center(
          child: Padding(
              padding: EdgeInsets.all(PaddingSystem.padding10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No timesheet found'),
                  Text(
                      'You need to upload your timesheets to view them into our systems'),
                  GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                        vertical: SizeSystem.size12,
                      ),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(SizeSystem.size12),
                          color: ColorSystem.primaryColor),
                      child: const Center(
                          child: Text(
                        'Upload Timesheet',
                        style: TextStyle(
                            color: ColorSystem.white,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    onTap: () {
                      pickFile();
                    },
                  )
                ],
              ))),
    );
  }
}
