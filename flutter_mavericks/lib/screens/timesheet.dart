import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mavericks/design_system/color_system.dart';
import 'package:flutter_mavericks/design_system/padding_system.dart';
import 'package:flutter_mavericks/design_system/sizesystem.dart';
import 'package:flutter_mavericks/models/http_response.dart';
import 'package:flutter_mavericks/models/timehseet.dart';
import 'package:flutter_mavericks/screens/timesheet_details.dart';
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
  bool processing = false;
  ProjectDetails? projectDetails;
  bool timeSheetFound = false;
  String formattedDate = '';

  getEmpid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    empId = prefs.getInt('empId') ?? 0;
    print("empId : $empId");
    setState(() {
      formattedDate = DateFormat('MMM yyyy').format(DateTime.now());
    });
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
      String month =
          "${dateFormatInput.parse(dates[0].toString()).year}-${dateFormatInput.parse(dates[0].toString()).month}";

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
          "month": month
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

        setState(() {
          processing = false;
        });
      }
    }
  }

  void getTimesheet() async {
    HttpResponses response =
        await timesheetService.getTimesheetDetails(empId, '2024-02');
    if (response.status!) {
      var data = response.data;
      print(data);
      if (data.isNotEmpty) {
        // setState(() {
        projectDetails = ProjectDetails.fromJson({
          "projectName": data['projectName'],
          "leaves": data['leaves'],
          "totalBillableHours": data['totalBillableHours'],
          "totalNonBillableHours": data['totalNonBillableHours'],
          'extraWorkingDays': data['extraWorkingDays'],
          'totalWorkingHours':
              data['totalBillableHours'] + data['totalNonBillableHours'],
          'totalWorkingDays': data['totalWorkingDays']
        });
        timeSheetFound = true;
        // });
      }
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
      setState(() {
        processing = true;
      });
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
        backgroundColor: ColorSystem.white,
        title: const Text('Timesheets'),
      ),
      backgroundColor: ColorSystem.white,
      body: Column(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: SizeSystem.size20,
                )),
            Text('$formattedDate'),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: SizeSystem.size20,
                )),
          ],
        ),
        processing
            ? Center(
                child: Container(
                    margin: const EdgeInsets.all(PaddingSystem.padding40),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: PaddingSystem.padding50),
                            child: Image.asset('assets/images/processing.png'),
                          ),
                          const SizedBox(
                            height: PaddingSystem.padding30,
                          ),
                          const Text(
                            'We are processing',
                            style: TextStyle(
                                fontSize: SizeSystem.size20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: PaddingSystem.padding20,
                          ),
                          const Text(
                            'Your timesheet is being processed in our system please wait for a while',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: ColorSystem.gray,
                                fontSize: SizeSystem.size14),
                          ),
                          const SizedBox(
                            height: PaddingSystem.padding24,
                          ),
                        ])))
            : !timeSheetFound
                ? TimesheetDetails()
                : Center(
                    child: Container(
                        margin: const EdgeInsets.all(PaddingSystem.padding40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: PaddingSystem.padding50),
                              child:
                                  Image.asset('assets/images/no_timesheet.png'),
                            ),
                            const SizedBox(
                              height: PaddingSystem.padding30,
                            ),
                            const Text(
                              'No Timesheet Found',
                              style: TextStyle(
                                  fontSize: SizeSystem.size20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: PaddingSystem.padding20,
                            ),
                            const Text(
                              'You need to upload your timesheets to view them into our systems',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorSystem.gray,
                                  fontSize: SizeSystem.size14),
                            ),
                            const SizedBox(
                              height: PaddingSystem.padding24,
                            ),
                            GestureDetector(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.symmetric(
                                  vertical: SizeSystem.size12,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        SizeSystem.size12),
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
                        )))
      ]),
    );
  }
}
