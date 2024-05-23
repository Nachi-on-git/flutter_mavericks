import 'package:flutter/material.dart';
import 'package:flutter_mavericks/design_system/sizesystem.dart';
import 'package:flutter_mavericks/screens/timesheets/timesheet.dart';

import '../../design_system/color_system.dart';

class EmpTimesheet extends StatefulWidget {
  final String empId;
  final bool isEmp;
  final String? empName;
  const EmpTimesheet(
      {super.key, required this.empId, required this.isEmp, this.empName});

  @override
  State<EmpTimesheet> createState() => _EmpTimesheetState();
}

class _EmpTimesheetState extends State<EmpTimesheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorSystem.white,
          title: const Text('Timesheets'),
                  elevation: 0,

        ),
        backgroundColor: ColorSystem.white,
        body: SingleChildScrollView(
            child: Column(children: [
          Visibility(
            visible: !widget.isEmp,
            child: Text(
              '${widget.empName}',
              style: const TextStyle(
                  fontSize: SizeSystem.size20, color: ColorSystem.gray),
            ),
          ),
          Timesheets(
              empId: widget.empId,
              isEmp: widget.isEmp,
              empName: widget.empName!)
        ])));
  }
}
