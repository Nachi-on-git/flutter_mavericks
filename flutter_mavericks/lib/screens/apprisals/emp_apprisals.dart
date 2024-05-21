import 'package:flutter/material.dart';
import '../../design_system/color_system.dart';
import '../../widgets/apprisal_card.dart';
import 'instructions.dart';

class EmployeeAppraisals extends StatefulWidget {
  final bool appraisalSubmitted;
  const EmployeeAppraisals({super.key, required this.appraisalSubmitted});

  @override
  State<EmployeeAppraisals> createState() => _EmployeeAppraisalsState();
}

class _EmployeeAppraisalsState extends State<EmployeeAppraisals> {
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
                    child: AppraisalsCard(
                      appraisalYear: '2024',
                      employeeName: 'Manoj Waghmare',
                      employeeDesignation: 'Flutter developer',
                      isResponseSubmitted: widget.appraisalSubmitted,
                      isEmp: true,
                    )),
              )
            ],
          ),
        ));
  }
}
