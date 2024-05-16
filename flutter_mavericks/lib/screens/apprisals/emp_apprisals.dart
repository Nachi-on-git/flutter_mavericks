import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../design_system/color_system.dart';
import '../../widgets/apprisal_card.dart';
import 'instructions.dart';

class Employeeappraisals extends StatefulWidget {
  const Employeeappraisals({super.key});

  @override
  State<Employeeappraisals> createState() => _EmployeeappraisalsState();
}

class _EmployeeappraisalsState extends State<Employeeappraisals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorSystem.white,
          title: const Text('appraisals'),
        ),
        backgroundColor: ColorSystem.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StartAppraisalInfoScreen()),
                  );
                },
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: const AppraisalsCard(
                      appraisalYear: '2024',
                      employeeName: 'Manoj Waghmare',
                      employeeDesignation: 'Flutter developer',
                      isResponseSubmitted: false,
                      isEmp: true,
                    )),
              )
            ],
          ),
        ));
  }
}
