import 'package:flutter/material.dart';
import 'package:flutter_mavericks/design_system/sizesystem.dart';

import '../design_system/color_system.dart';

class AppraisalsCard extends StatelessWidget {
  const AppraisalsCard(
      {super.key,
      required this.appraisalYear,
      required this.employeeName,
      required this.employeeDesignation,
      required this.isResponseSubmitted,
      this.onButtonPressed,
      required this.isEmp});

  final String appraisalYear;
  final String employeeName;
  final String employeeDesignation;
  final bool isResponseSubmitted;
  final VoidCallback? onButtonPressed;
  final bool isEmp;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.grey),
      ),
      margin: const EdgeInsets.only(bottom: SizeSystem.size12),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: SizeSystem.size16, vertical: SizeSystem.size10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: SizeSystem.size4),
            Text(
              appraisalYear,
              style: const TextStyle(
                fontSize: SizeSystem.size12,
                fontWeight: FontWeight.w600,
                color: Color(0xff6366F1),
              ),
            ),
            const SizedBox(height: SizeSystem.size8),
            Text(
              employeeName,
              style: const TextStyle(
                fontSize: SizeSystem.size16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: SizeSystem.size2),
            Text(
              employeeDesignation,
              style: TextStyle(
                fontSize: SizeSystem.size12,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(.6),
              ),
            ),
            Chip(
              avatar: CircleAvatar(
                radius: SizeSystem.size8,
                backgroundColor: isResponseSubmitted
                    ?  ColorSystem.greenShade
                    :  ColorSystem.orangeShade,
              ),
              shape: const StadiumBorder(
                  side: BorderSide(color: Colors.transparent)),
              backgroundColor: isResponseSubmitted
                  ? const Color(0xffE0FEC9)
                  :  ColorSystem.lightYellow,
              label: isResponseSubmitted
                  ? const Text("Self Assessment Submitted")
                  : const Text("Self Assessment Available"),
              labelStyle: TextStyle(
                  color: isResponseSubmitted
                      ?  ColorSystem.greenShade
                      :  ColorSystem.orangeShade,
                  fontSize: SizeSystem.size12),
            ),
            Visibility(
              visible: !isEmp,
              child: const Chip(
                avatar: CircleAvatar(
                  radius: SizeSystem.size8,
                  backgroundColor: ColorSystem.orangeShade,
                ),
                shape:
                    StadiumBorder(side: BorderSide(color: Colors.transparent)),
                backgroundColor: ColorSystem.lightYellow,
                label: Text("Leader Assessment Available"),
                labelStyle: TextStyle(
                    color: ColorSystem.orangeShade, fontSize: SizeSystem.size12),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: SizeSystem.size8),
                InkWell(
                  onTap: () {},
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
                        'Submit response',
                        style: TextStyle(
                            color: ColorSystem.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
