import 'dart:convert';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mavericks/models/timehseet.dart';
import 'package:intl/intl.dart';

class ExportFile extends StatefulWidget {
  const ExportFile({super.key});

  @override
  State<ExportFile> createState() => _ExportFileState();
}

class _ExportFileState extends State<ExportFile> {
  List<Timesheet> timesheet = [];
  DateFormat dateFormatInput = DateFormat('dd-MMM-yyyy');
  int totalDaysInMonths = 0;
  List datewiseSorting = [];

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

    print(days.reduce((a, b) => a + b));
    return days.reduce((a, b) => a + b);
  }

  getDaysInMonths() {
    if (datewiseSorting.isEmpty) {
      return;
    }
    DateTime parsedDateTime =
        dateFormatInput.parse(datewiseSorting[0].toString());
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

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );
    print("result : $result");
    if (result != null) {
      var bytes = File(result.files[0].path!).readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      double totalNonBillableHours = 0.0;
      double totalBillableHours = 0.0;
      double totalHours = 0;
      Timesheet projectNameData;
      for (var table in excel.tables.keys) {
        for (var row in excel.tables[table]!.rows) {
          for (var cell in row) {
            final value = cell?.value;
            // print('cell : ${cell!.rowIndex}/${cell.columnIndex}');
            // check Column name for date
            if (cell!.rowIndex > 0) {
              // print('$value');
              // print(cell.columnIndex);
              if (cell.columnIndex == 2) {
                // Project name
                if (timesheet.isEmpty) {
                  timesheet.add(Timesheet.fromJson({
                    'projectName': value.toString(),
                    'projectDetails': null
                  }));
                } else {
                  Timesheet details = timesheet.firstWhere(
                      (element) => element.projectName == value.toString(),
                      orElse: () => Timesheet(
                          projectName: null,
                          projectData: ProjectDetails(
                              totalBillableHours: 0.0,
                              extraWorkingDays: 0,
                              leaves: 0,
                              totalNonBillableHours: 0.0,
                              totalWorkingHours: 0.0)));
                  if (details.projectName == null) {
                    timesheet.add(Timesheet.fromJson({
                      'projectName': value.toString(),
                      'projectDetails': null
                    }));
                  }
                }
              }
              projectNameData = timesheet.firstWhere(
                  (element) => element.projectName == row[2]!.value.toString(),
                  orElse: () => Timesheet(
                      projectName: null,
                      projectData: ProjectDetails(
                          totalBillableHours: 0.0,
                          extraWorkingDays: 0,
                          leaves: 0,
                          totalNonBillableHours: 0.0,
                          totalWorkingHours: 0.0)));

              if (cell.columnIndex == 12) {
                projectNameData.projectData.totalWorkingHours +=
                    double.parse(value.toString());
              }
              // date
              if (cell.columnIndex == 0) {
                if (datewiseSorting.isEmpty) {
                  datewiseSorting.add(value.toString());
                } else {
                  if (!datewiseSorting.contains(value.toString())) {
                    datewiseSorting.add(value.toString());
                  }
                }
              }
              if (cell.columnIndex == 14) {
                if (value.toString() == 'Non Billable') {
                  projectNameData.projectData.totalNonBillableHours +=
                      double.parse(row[12]!.value.toString());
                } else {
                  projectNameData.projectData.totalBillableHours +=
                      double.parse(row[12]!.value.toString());
                }
              }
            }
          }
        }
      }
      Future.delayed(const Duration(seconds: 2), () {
        int expectedWorkingDays = getDaysInMonths() ?? 0;
        if (datewiseSorting.length < expectedWorkingDays) {
          for (var data in timesheet) {
            data.projectData.leaves =
                expectedWorkingDays - datewiseSorting.length;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
            child: Text('Upload'),
            onTap: () {
              pickFile();
            }),
      ),
    );
  }
}
