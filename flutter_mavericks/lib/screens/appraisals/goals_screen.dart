import 'package:flutter/material.dart';
import 'package:flutter_mavericks/screens/appraisals/appraisal_submit_screen.dart';
import '../../design_system/color_system.dart';
import '../../design_system/sizesystem.dart';
import '../../models/appraisal.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  int _currentStepIndex = 0;
  final List<AppraisalStep> _steps = [
    AppraisalStep(
      imageUrl: "assets/images/9.png",
      title: "Technical Goals",
    ),
    AppraisalStep(
      imageUrl: "assets/images/10.png",
      title: "Non-Technical Goals",
    ),
  ];

  void _nextStep() {
    if (_currentStepIndex < _steps.length - 1) {
      setState(() {
        _currentStepIndex++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AppraisalSubmitScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSystem.white,
      appBar:  AppBar(
        backgroundColor: ColorSystem.white,
        centerTitle: true,
                elevation: 0,

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
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(SizeSystem.size16).copyWith(top: SizeSystem.size12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.grey),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(_steps[_currentStepIndex].imageUrl, width: MediaQuery.of(context).size.width,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Step 2 - Goal Setting',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: SizeSystem.size10,),
                    Text(
                      _steps[_currentStepIndex].title,
                      style: const TextStyle(
                        color: ColorSystem.lightOrange,
                        fontSize: 14,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: SizeSystem.size10,),
                    const Text(
                      'Goal 1*',
                      style: TextStyle(
                        color: ColorSystem.lightOrange,
                        fontSize: 12,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(top: 10, bottom: 18),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(width: 1, color: Color(0xFFE0E8F1)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Your text goes here...',
                            hintStyle: TextStyle(
                              color: Color(0xFF8A9BAD),
                              fontSize: 12,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                    ),
                    const Text(
                      'Goal 2*',
                      style: TextStyle(
                        color: ColorSystem.lightOrange,
                        fontSize: 12,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(top: 10, bottom: 18),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(width: 1, color: Color(0xFFE0E8F1)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Your text goes here...',
                            hintStyle: TextStyle(
                              color: Color(0xFF8A9BAD),
                              fontSize: 12,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                    ),
                    const Text(
                      'Goal 3*',
                      style: TextStyle(
                        color: ColorSystem.lightOrange,
                        fontSize: 12,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(top: 10, bottom: 18),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(width: 1, color: Color(0xFFE0E8F1)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Your text goes here...',
                            hintStyle: TextStyle(
                              color: Color(0xFF8A9BAD),
                              fontSize: 12,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                    ),
                    const Text(
                      'Goal 4*',
                      style: TextStyle(
                        color: ColorSystem.lightOrange,
                        fontSize: 12,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(top: 10, bottom: 18),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(width: 1, color: Color(0xFFE0E8F1)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Your text goes here...',
                            hintStyle: TextStyle(
                              color: Color(0xFF8A9BAD),
                              fontSize: 12,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                    ),
                    InkWell(
                      onTap: _nextStep,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                          vertical: SizeSystem.size12,
                        ),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(SizeSystem.size12), color: ColorSystem.primaryColor),
                        child: const Center(
                          child: Text(
                            'Next',
                            style: TextStyle(color: ColorSystem.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: SizeSystem.size6),
                  ],
                ),
              ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
