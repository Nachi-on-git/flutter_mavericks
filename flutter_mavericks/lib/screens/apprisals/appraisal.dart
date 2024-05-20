import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../design_system/color_system.dart';
import '../../design_system/sizesystem.dart';
import '../../models/appraisal.dart';

class AppraisalScreen extends StatefulWidget {
  const AppraisalScreen({super.key});

  @override
  State<AppraisalScreen> createState() => _AppraisalScreenState();
}

class _AppraisalScreenState extends State<AppraisalScreen> {
  int _currentStepIndex = 0;
  final List<AppraisalStep> _steps = [
    AppraisalStep(
      imageUrl: "assets/images/1.png",
      title: "Job Knowledge",
      description: "• Achieving proficiency in relevant skills. Latest knowledge of related areas to his/her function and keeping abreast of the latest developments in his/her functional areas.\n• Increase the use of standard methods, tools, and processes.",
    ),
    AppraisalStep(
      imageUrl: "assets/images/2.png",
      title: "Work Quality",
      description: "• Increase client/customer or user satisfaction.\n• Meet deliverable requirements/service level measures/specific targets.\n• Maximize productivity.\n• Structuring work to meet deadlines and quality expectations.\n• Meeting expectations and delivering measurable results regardless of obstacles.\n• Staying current on skills and industry knowledge, and enabling others to do the same.",
    ),
    AppraisalStep(
      imageUrl: "assets/images/3.png",
      title: "Initiative",
      description: "• Build skills needed to execute current responsibilities.\n• Maximize benefits/value for clients.\n• Builds and Applies skills and capabilities.",
    ),
    AppraisalStep(
      imageUrl: "assets/images/4.png",
      title: "Communication/Listening",
      description: "• Can effectively express ideas and opinions and provide information with clarity on a one-to-one level and to a group as a whole.\n• Is an effective listener and can appropriately respond to non-verbal clues.\n• Providing and maintaining a clear sense of direction and focus.",
    ),
    AppraisalStep(
      imageUrl: "assets/images/5.png",
      title: "Work Ethic",
      description: "• Believe in teamwork.\n• Accepts responsibility for his/her actions.\n• Can inspire confidence in others.\n• Creates enthusiasm and ensures collaboration amongst team members to attain stated objectives.\n• Participate in people initiatives.",
    ),
  ];
  void _nextStep() {
    setState(() {
      _currentStepIndex = (_currentStepIndex + 1) % _steps.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSystem.white,
      appBar:  AppBar(
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
                  const SizedBox(height: SizeSystem.size2),
                  Padding(
                    padding: const EdgeInsets.all(SizeSystem.size8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Step 1 - Performance Evaluation',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Opacity(
                          opacity: 0.60,
                          child: Text(
                            '( Feel free to use additional points and pages to substantiate comments )',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: SizeSystem.size10,),
                         Text(
                          "${_currentStepIndex+1} ${_steps[_currentStepIndex].title}",
                          style: const TextStyle(
                            color: Color(0xFF3B3936),
                            fontSize: 14,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          _steps[_currentStepIndex].description,
                          style: const TextStyle(
                            color: Color(0xFF3B3936),
                            fontSize: 14,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: SizeSystem.size10,),
                        const Text(
                          'Please provide your ratings below',
                          style: TextStyle(
                            color: Color(0xFF3B3936),
                            fontSize: 14,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: SizeSystem.size8,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 89.11,
                          padding: const EdgeInsets.symmetric(horizontal: 28.71, vertical: 23.92),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF7F8FA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.35),
                            ),
                          ),
                          child: Center(
                            child: RatingBar.builder(
                              initialRating: 0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemSize: 55,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                              updateOnDrag: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: SizeSystem.size10,),
                        const Center(
                          child: Text(
                            'Select stars for ratings',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF8A9BAD),
                              fontSize: 12,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: SizeSystem.size10,),
                        const Text(
                          'Please help us with your comment’s ',
                          style: TextStyle(
                            color: Color(0xFF3B3936),
                            fontSize: 14,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 18),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1, color: Color(0xFFE0E8F1)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: TextFormField(
                            maxLines: 3,
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
        ),),
    );
  }
}
