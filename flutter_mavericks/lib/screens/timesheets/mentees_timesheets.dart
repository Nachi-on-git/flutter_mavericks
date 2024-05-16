import 'package:flutter/material.dart';
import 'package:flutter_mavericks/models/http_response.dart';
import 'package:flutter_mavericks/screens/timesheets/emp_timesheet.dart';
import 'package:flutter_mavericks/services/timesheet_service.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../design_system/color_system.dart';
import '../../design_system/padding_system.dart';
import '../../design_system/sizesystem.dart';

class MenteesTimesheet extends StatefulWidget {
  const MenteesTimesheet({super.key});

  @override
  State<MenteesTimesheet> createState() => _MenteesTimesheetState();
}

class _MenteesTimesheetState extends State<MenteesTimesheet> {
  TimesheetService timesheetService = TimesheetService();
  String month = '';
  int id = 0;
  List<Map> empList = [];
  bool isLoading = true;
  @override
  void initState() {
    setState(() {
      month = DateFormat('MM-yyyy').format(DateTime.now());
    });
    getId();
    super.initState();
  }

  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getInt('empId') ?? 0;
      print("id : $id");
    });
    getAllMentees();
  }

  // get mentees list
  getAllMentees() async {
    HttpResponses response;
    response = await timesheetService.getMenteesTimesheet(id.toString(), month);
    if (response.status!) {
      if (response.data != null &&
          response.data.isNotEmpty &&
          response.data.length > 0) {
        setState(() {
          for (var emp in response.data) {
            print(emp);
            empList.add(emp);
          }
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: PaddingSystem.padding20),
        child: isLoading
            ? const CircularProgressIndicator()
            :
            SingleChildScrollView(child:              Column(
                children: empList
                    .map((emp) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmpTimesheet(
                                      empId: id.toString(),
                                      isEmp: false,
                                    )),
                          );
                        },
                        child: Container(
                            margin: const EdgeInsets.only(
                                left: PaddingSystem.padding20,
                                right: PaddingSystem.padding20,
                                bottom: PaddingSystem.padding20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: PaddingSystem.padding20,
                                vertical: PaddingSystem.padding05),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorSystem.gray.withOpacity(0.4)),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: PaddingSystem.padding10,
                                        left: PaddingSystem.padding10,
                                        right: PaddingSystem.padding10),
                                    child:
                                        Image.asset('assets/images/emp.png')),
                                Text(
                                  '${emp['employeeName']}',
                                  style: const TextStyle(
                                      fontSize: SizeSystem.size20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ))))
                    .toList())));
  }
}
