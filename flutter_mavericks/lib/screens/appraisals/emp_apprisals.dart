import 'package:flutter/material.dart';
import 'package:flutter_mavericks/models/http_response.dart';
import 'package:flutter_mavericks/services/appraisal_service.dart';
import '../../design_system/color_system.dart';
import '../../models/appraisal_card.dart';
import '../../widgets/apprisal_card.dart';
import 'instructions.dart';

class EmployeeAppraisals extends StatefulWidget {
  final bool appraisalSubmitted;
  final int empId;
  const EmployeeAppraisals(
      {super.key, required this.appraisalSubmitted, required this.empId});

  @override
  State<EmployeeAppraisals> createState() => _EmployeeAppraisalsState();
}

class _EmployeeAppraisalsState extends State<EmployeeAppraisals> {
  AppraisalsService appraisalsService = AppraisalsService();
  AppraisalCard? appraisalCard;
  @override
  void initState() {
    super.initState();
  }

  getAppraisal() async{
   HttpResponses responses = await appraisalsService.getMyAppraisal(id: widget.empId);
  if(responses.status!){
    if(responses.data != null){
    setState(() {
      
    });
    }
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorSystem.white,
          title: const Text('appraisals'),
                  elevation: 0,

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
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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
