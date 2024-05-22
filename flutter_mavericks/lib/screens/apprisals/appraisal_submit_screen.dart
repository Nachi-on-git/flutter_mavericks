import 'package:flutter/material.dart';
import 'package:flutter_mavericks/screens/dashboard.dart';
import '../../design_system/color_system.dart';
import '../../design_system/sizesystem.dart';
import 'emp_apprisals.dart';

class AppraisalSubmitScreen extends StatefulWidget {
  const AppraisalSubmitScreen({super.key});

  @override
  State<AppraisalSubmitScreen> createState() => _AppraisalScState();
}

class _AppraisalScState extends State<AppraisalSubmitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSystem.white,
      appBar: AppBar(
        backgroundColor: ColorSystem.white,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        title: const Text(
          'Appraisals',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 33),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/appraisalSubmit.png"),
              const SizedBox(
                height: SizeSystem.size32,
              ),
              const Text(
                'Self Assessment Submitted !! ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF3B3936),
                  fontSize: 24,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: SizeSystem.size8,
              ),
              const Text(
                'Your response has been recorded and sent to the upper management',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF78746D),
                  fontSize: 14,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: SizeSystem.size32,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Dashboard()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                    vertical: SizeSystem.size12,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SizeSystem.size12),
                      color: ColorSystem.primaryColor),
                  child: const Center(
                    child: Text(
                      'Go back',
                      style: TextStyle(
                          color: ColorSystem.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
