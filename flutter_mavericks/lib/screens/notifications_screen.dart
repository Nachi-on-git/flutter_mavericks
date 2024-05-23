import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../design_system/color_system.dart';
import '../design_system/sizesystem.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
            child: Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.all(6),
              decoration: const ShapeDecoration(
                shape: OvalBorder(
                  side: BorderSide(width: 1, color: Color(0xFFBEBAB3)),
                ),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 18,
              ),
            )),
        title: const Text(
          'Notifications',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorSystem.lightOrange,
            fontSize: 24,
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 144,
                margin: const EdgeInsets.only(bottom: 15, top: 20, right: 16),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: ShapeDecoration(
                  color: ColorSystem.lightGray,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(33),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Mark all as read',
                      style: TextStyle(
                        color: ColorSystem.primaryColor,
                        fontSize: 11.93,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: SizeSystem.size4,),
                    SvgPicture.asset("assets/images/tickImage.svg"),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: ColorSystem.borderColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/boyProfile.svg"),
                  const SizedBox(width: SizeSystem.size8,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Nachiket Labade ',
                              style: TextStyle(
                                color: ColorSystem.lightOrange,
                                fontSize: 14,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'submitted a new ',
                              style: TextStyle(
                                color: ColorSystem.lightOrange,
                                fontSize: 12,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: '\nTimesheet',
                              style: TextStyle(
                                color: ColorSystem.lightOrange,
                                fontSize: 14,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 4, right: 14),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: ColorSystem.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.11),
                              ),
                            ),
                            child: const Text(
                              'View now',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorSystem.white,
                                fontSize: 11.93,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4,),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(width: 0.85, color: Color(0xFFDDDEE1)),
                                borderRadius: BorderRadius.circular(5.11),
                              ),
                            ),
                            child: const Text(
                              'Details',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF3C4257),
                                fontSize: 11.93,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: SizeSystem.size4,),
                      const Text(
                        'Today at 9:42 AM',
                        style: TextStyle(
                          color: Color(0xFFA5ACB8),
                          fontSize: 11.93,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: ColorSystem.borderColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/boyProfile.svg"),
                  const SizedBox(width: SizeSystem.size8,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Nachiket Labade’s ',
                              style: TextStyle(
                                color: ColorSystem.lightOrange,
                                fontSize: 14,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'appraisal got his ',
                              style: TextStyle(
                                color: ColorSystem.lightOrange,
                                fontSize: 12,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: '\nindividual feedback ',
                              style: TextStyle(
                                color: ColorSystem.lightOrange,
                                fontSize: 14,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'updated',
                              style: TextStyle(
                                color: ColorSystem.lightOrange,
                                fontSize: 12,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 4, right: 14),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF413970),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.11),
                              ),
                            ),
                            child: const Text(
                              'View now',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorSystem.white,
                                fontSize: 11.93,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: SizeSystem.size4,),
                      const Text(
                        'Today at 9:42 AM',
                        style: TextStyle(
                          color: Color(0xFFA5ACB8),
                          fontSize: 11.93,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: ColorSystem.borderColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/boyProfile.svg"),
                  const SizedBox(width: SizeSystem.size8,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Your ',
                              style: TextStyle(
                                color: ColorSystem.lightOrange,
                                fontSize: 14,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'appraisal got his ',
                              style: TextStyle(
                                color: ColorSystem.lightOrange,
                                fontSize: 12,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'individual \nfeedback ',
                              style: TextStyle(
                                color: ColorSystem.lightOrange,
                                fontSize: 14,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'updated',
                              style: TextStyle(
                                color: ColorSystem.lightOrange,
                                fontSize: 12,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 4, right: 14),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF413970),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.11),
                              ),
                            ),
                            child: const Text(
                              'View now',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorSystem.white,
                                fontSize: 11.93,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: SizeSystem.size4,),
                      const Text(
                        'Today at 9:42 AM',
                        style: TextStyle(
                          color: Color(0xFFA5ACB8),
                          fontSize: 11.93,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: ColorSystem.borderColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/boyProfile.svg"),
                  const SizedBox(width: SizeSystem.size8,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Your ',
                              style: TextStyle(
                                color: ColorSystem.lightOrange,
                                fontSize: 14,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'appraisal got his ',
                              style: TextStyle(
                                color: ColorSystem.lightOrange,
                                fontSize: 12,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Mentor’s \nfeedback ',
                              style: TextStyle(
                                color: ColorSystem.lightOrange,
                                fontSize: 14,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'updated',
                              style: TextStyle(
                                color: ColorSystem.lightOrange,
                                fontSize: 12,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 4, right: 14),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color:  ColorSystem.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.11),
                              ),
                            ),
                            child: const Text(
                              'View now',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorSystem.white,
                                fontSize: 11.93,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: SizeSystem.size4,),
                      const Text(
                        'Today at 9:42 AM',
                        style: TextStyle(
                          color: Color(0xFFA5ACB8),
                          fontSize: 11.93,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: ColorSystem.borderColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/greenTick.svg"),
                  const SizedBox(width: SizeSystem.size8,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Your Timesheet ',
                              style: TextStyle(
                                color: ColorSystem.lightOrange,
                                fontSize: 14,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'just got approved by ',
                              style: TextStyle(
                                color: ColorSystem.lightOrange,
                                fontSize: 12,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: '\nshrutika tatkare',
                              style: TextStyle(
                                color: ColorSystem.lightOrange,
                                fontSize: 14,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 4, right: 14),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color:  ColorSystem.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.11),
                              ),
                            ),
                            child: const Text(
                              'View now',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorSystem.white,
                                fontSize: 11.93,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: SizeSystem.size4,),
                      const Text(
                        'Today at 9:42 AM',
                        style: TextStyle(
                          color: Color(0xFFA5ACB8),
                          fontSize: 11.93,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: ColorSystem.borderColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/rejectedImg.svg"),
                  const SizedBox(width: SizeSystem.size8,),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Your Timesheet ',
                              style: TextStyle(
                                color: ColorSystem.lightOrange,
                                fontSize: 14,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'just got Rejected by ',
                              style: TextStyle(
                                color: ColorSystem.lightOrange,
                                fontSize: 12,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: '\nshrutika tatkare',
                              style: TextStyle(
                                color: ColorSystem.lightOrange,
                                fontSize: 14,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: SizeSystem.size8,),
                      Text(
                        'Please refill with correct work hours',
                        style: TextStyle(
                          color: ColorSystem.lightOrange,
                          fontSize: 12,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: SizeSystem.size4,),
                      Text(
                        'Today at 9:42 AM',
                        style: TextStyle(
                          color: Color(0xFFA5ACB8),
                          fontSize: 11.93,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

