import 'package:flutter/material.dart';
import 'package:flutter_mavericks/screens/timesheets/timesheet.dart';

import '../../design_system/color_system.dart';

class EmpTimesheet extends StatefulWidget {
  final String empId;
  final bool isEmp;
  const EmpTimesheet({super.key, required this.empId, required this.isEmp});

  @override
  State<EmpTimesheet> createState() => _EmpTimesheetState();
}

class _EmpTimesheetState extends State<EmpTimesheet> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSystem.white,
        title: const Text('Timesheets'),
      ),
      backgroundColor: ColorSystem.white,
      body: Timesheets(empId: widget.empId,isEmp: widget.isEmp,));
  }
}