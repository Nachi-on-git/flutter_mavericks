import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mavericks/design_system/color_system.dart';
import 'package:flutter_mavericks/design_system/padding_system.dart';
import 'package:flutter_mavericks/design_system/sizesystem.dart';
import 'package:flutter_mavericks/models/http_response.dart';
import 'package:flutter_mavericks/models/timehseet.dart';
import 'package:flutter_mavericks/screens/timesheets/timesheet_details.dart';
import 'package:flutter_mavericks/services/timesheet_service.dart';
import 'package:intl/intl.dart';

class Timesheets extends StatefulWidget {
  final String empId;
  final bool isEmp;
  final String empName;
  const Timesheets({super.key, required this.empId, required this.isEmp,required this.empName});

  @override
  State<Timesheets> createState() => _TimesheetsState();
}

class _TimesheetsState extends State<Timesheets> {
  // List dates = [];
  String monthInSheet = '';
  // List<Timesheet> timesheets = [];
  DateFormat dateFormatInput = DateFormat('dd-MMM-yyyy');
  TimesheetService timesheetService = TimesheetService();
  // List<Timesheet> myTimesheets = [];
  bool processing = true;
  List<ProjectDetails> projectDetails = [];
  bool timeSheetFound = false;
  String formattedDate = '';
  String currentMonth = '';
  String month = '';

  getIntialDetails() async {
    setState(() {
      formattedDate = DateFormat('MMM yyyy').format(DateTime.now());
      month = DateFormat('MM-yyyy').format(DateTime.now());
      currentMonth = DateFormat('dd-MMM-yyyy').format(DateTime.now());
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
  int getDaysInMonths({required String date}) {
    if (date.isEmpty) {
      return 0;
    }
    DateTime parsedDateTime = dateFormatInput.parse(date);
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

  // get total days in months
  int getAllDaysInMonths({required String date}) {
    if (date.isEmpty) {
      return 0;
    }
    DateTime parsedDateTime = dateFormatInput.parse(date);
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
    return endDate.difference(startDate).inDays + 1;
  }

  void submitTimesheet({required String date}) async {
    HttpResponses response;
    setState(() {
      processing = true;
    });
    if (projectDetails.isNotEmpty) {
      for (var timesheet in projectDetails) {
        response = await timesheetService.submitTimesheetDetails({
          "employeeId": widget.empId,
          "projectName": timesheet.projectName,
          "billableHours": timesheet.totalBillableHours,
          "nonBillableHours": timesheet.totalNonBillableHours,
          "leaves": timesheet.leaves,
          "extraWorkingDays": timesheet.extraWorkingDays,
          "comments": "N/A",
          "totalWorkingDays": timesheet.totalWorkingDays,
          "month": month
        });
        if (response.status!) {
                    // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Timesheet submmited successfully !!"),
          ));
          getTimesheet();
        } else {
          // ignore: use_build_context_synchronously
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
    HttpResponses response = await timesheetService.getTimesheetDetails(
        int.parse(widget.empId), month);
    if (response.status!) {
      var data = response.data;
      projectDetails = [];
      if (data.isNotEmpty && data.length > 0) {
        setState(() {
          for (var details in data) {
            projectDetails.add(ProjectDetails.fromJson({
              "projectName": details['projectName'],
              "leaves": details['leaves'],
              "totalBillableHours": details['billableHours'],
              "totalNonBillableHours": details['nonBillableHours'],
              'extraWorkingDays': details['extraWorkingDays'],
              'totalWorkingHours':
                  details['billableHours'] + details['nonBillableHours'],
              'totalWorkingDays': details['totalWorkingDays']
            }));
          }
          timeSheetFound = true;
          processing = false;
        });
      } else {
        setState(() {
          timeSheetFound = false;
          processing = false;
        });
      }
    } else {
                // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${response.message}"),
      ));
      setState(() {
        processing = false;
      });
    }
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );
    // print("result : $result");
    if (result != null) {
      setState(() {
        processing = true;
      });
      var bytes = File(result.files[0].path!).readAsBytesSync();
      var excelFile = Excel.decodeBytes(bytes);
      ProjectDetails singleTimesheetDetails;
      List<Map> dates = [];
      try {
        for (var table in excelFile.tables.keys) {
          for (var row in excelFile.tables[table]!.rows) {
            for (var cell in row) {
              if (cell == null) {
                break;
              }
              final value = cell.value;
              // first row as title i.e. 0
              if (cell.rowIndex > 0) {
                if (cell.columnIndex == 2) {
                  // add project name
                  if (projectDetails.isEmpty) {
                    projectDetails.add(ProjectDetails.fromJson(
                        {"projectName": value.toString()}));
                  } else {
                    ProjectDetails sheetDetails = projectDetails.firstWhere(
                        (element) => element.projectName == value.toString(),
                        orElse: () =>
                            ProjectDetails.fromJson({'projectName': null}));
                    if (sheetDetails.projectName!.isEmpty) {
                      projectDetails.add(ProjectDetails.fromJson(
                          {"projectName": value.toString()}));
                    }
                  }
                }

                // add hours
                singleTimesheetDetails = projectDetails.firstWhere(
                    (element) =>
                        element.projectName == row[2]!.value.toString(),
                    orElse: () => ProjectDetails.fromJson(
                        {'projectName': null, 'projectDetails': null}));
                if (cell.columnIndex == 12) {
                  singleTimesheetDetails.totalWorkingHours +=
                      double.parse(value.toString());
                }

                // add dates
                if (cell.columnIndex == 0) {
                  if (singleTimesheetDetails.projectName!.isEmpty) {
                    continue;
                  }
                  // if (monthInSheet.isEmpty) {
                  monthInSheet = value.toString();

                  Map filteredData = dates.firstWhere(
                      (element) =>
                          element.containsKey(row[2]!.value.toString()),
                      orElse: () => {});
                  if (filteredData.isEmpty) {
                    dates.add({
                      singleTimesheetDetails.projectName: [value.toString()]
                    });
                  } else {
                    if (!filteredData[singleTimesheetDetails.projectName]
                        .contains(value.toString())) {
                      filteredData[singleTimesheetDetails.projectName]
                          .add(value.toString());
                    }
                    // }
                  }
                }

                // billing status
                if (cell.columnIndex == 14) {
                  if (value.toString() == 'Non Billable') {
                    singleTimesheetDetails.totalNonBillableHours +=
                        double.parse(row[12]!.value.toString());
                  } else {
                    singleTimesheetDetails.totalBillableHours +=
                        double.parse(row[12]!.value.toString());
                  }
                }
              }
            }
          }
        }

        Future.delayed(const Duration(seconds: 2), () {
          int expectedWorkingDays = getDaysInMonths(date: monthInSheet);
          for (var data in projectDetails) {
            for (int i = 0; i < dates.length; i++) {
              if (dates[i][data.projectName] != null) {
                data.totalWorkingDays = dates[i][data.projectName].length;
              }
            }
            if (data.totalWorkingDays < expectedWorkingDays) {
              data.leaves = expectedWorkingDays - data.totalWorkingDays;
            }
          }
          submitTimesheet(date: month);
        });
      } catch (error) {
        // print("file error : $error");
        setState(() {
          processing = false;
        });
                  // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something wrong with file !!!"),
        ));
      }
    }
  }

  previousMonth() {
    setState(() {
      processing = true;
      projectDetails = [];
      DateTime previousMonth = dateFormatInput.parse(currentMonth).subtract(
          Duration(days: getAllDaysInMonths(date: currentMonth.toString())));
      formattedDate = DateFormat('MMM yyyy').format(previousMonth);
      currentMonth = DateFormat('dd-MMM-yyyy').format(previousMonth);
      month = DateFormat('MM-yyyy').format(previousMonth);
    });
    getTimesheet();
  }

  nextMonth() {
    setState(() {
      projectDetails = [];
      processing = true;
      DateTime nextMonth = dateFormatInput.parse(currentMonth).add(
          Duration(days: getAllDaysInMonths(date: currentMonth.toString())));
      formattedDate = DateFormat('MMM yyyy').format(nextMonth);
      currentMonth = DateFormat('dd-MMM-yyyy').format(nextMonth);
      month = DateFormat('MM-yyyy').format(nextMonth);
    });
    getTimesheet();
  }

  @override
  void initState() {
    getIntialDetails();
    Future.delayed(const Duration(milliseconds: 800), () {
      getTimesheet();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                previousMonth();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: SizeSystem.size20,
              )),
          Text(
            formattedDate,
            style: const TextStyle(
                fontSize: SizeSystem.size14,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          IconButton(
              onPressed: DateFormat('MM-yyyy').format(DateTime.now()) == month
                  ? null
                  : () {
                      nextMonth();
                    },
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
          : timeSheetFound
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: projectDetails.length,
                  itemBuilder: ((context, index) {
                    return TimesheetDetails(
                      empName: widget.empName,
                      isEmp : widget.isEmp,
                        projectDetails: projectDetails[index]);
                  }))
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
                          Text(
                            widget.isEmp
                                ? 'You need to upload your timesheets to view them into our systems'
                                : 'This user has not uploaded his timesheets to our systems yet.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
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
                                  borderRadius:
                                      BorderRadius.circular(SizeSystem.size12),
                                  color: ColorSystem.primaryColor),
                              child: Center(
                                  child: Text(
                                widget.isEmp
                                    ? 'Upload Timesheet'
                                    : 'Request Timesheet',
                                style: const TextStyle(
                                    color: ColorSystem.white,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                            onTap: () {
                              if (widget.isEmp) {
                                pickFile();
                              }
                            },
                          ),
                          
                        ],
                      )))
    ]);
  }
}
