import 'package:flutter/material.dart';
import 'package:flutter_mavericks/design_system/padding_system.dart';
import 'package:flutter_mavericks/design_system/sizesystem.dart';
import 'package:flutter_mavericks/models/timehseet.dart';

import '../../design_system/color_system.dart';

class TimesheetDetails extends StatefulWidget {
  final ProjectDetails projectDetails;
  const TimesheetDetails({super.key, required this.projectDetails});

  @override
  State<TimesheetDetails> createState() => _TimesheetDetailsState();
}

class _TimesheetDetailsState extends State<TimesheetDetails> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          const SizedBox(
            height: PaddingSystem.padding10,
          ),
          Container(
              margin: const EdgeInsets.all(PaddingSystem.padding20),
              decoration: BoxDecoration(
                  border: Border.all(color: ColorSystem.gray.withOpacity(0.6)),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: const BoxDecoration(
                        color: ColorSystem.primaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/bullet.png',
                          color: ColorSystem.white,
                        ),
                        const SizedBox(
                          height: PaddingSystem.padding20,
                        ),
                        Text(
                          '${widget.projectDetails.projectName}',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorSystem.white,
                              fontSize: SizeSystem.size30),
                        )
                      ],
                    )),
                Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(children: [
                      const Row(
                        children: [
                          Text(
                            'Total working hours',
                            style: TextStyle(
                                color: ColorSystem.gray,
                                fontSize: SizeSystem.size20),
                          ),
                          // Text('Total working Days',
                          //     style: TextStyle(
                          //         color: ColorSystem.gray,
                          //         fontSize: SizeSystem.size20))
                        ],
                      ),
                      Row(
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            WidgetSpan(
                                child: Text(
                              '${widget.projectDetails.totalWorkingHours.toInt()}',
                              style: const TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            )),
                            const WidgetSpan(
                                child: Text('Hrs',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))),
                          ]))
                        ],
                      ),
                      const SizedBox(
                        height: PaddingSystem.padding20,
                      ),
                      LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(10),
                        minHeight: 8,
                        backgroundColor: ColorSystem.gray.withOpacity(0.4),
                        color: ColorSystem.primaryColor,
                        value: widget.projectDetails.totalBillableHours /
                            widget.projectDetails.totalWorkingHours,
                      ),
                      const SizedBox(
                        height: PaddingSystem.padding20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 6,
                                  width: 40,
                                  margin: const EdgeInsets.only(top: 8),
                                  decoration: BoxDecoration(
                                      color: ColorSystem.primaryColor,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Billable',
                                        style: TextStyle(
                                            color: ColorSystem.gray
                                                .withOpacity(0.6),
                                            fontSize: 15),
                                      ),
                                      Text(
                                        '${widget.projectDetails.totalBillableHours.toInt()} Hrs',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ])
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 6,
                                  width: 40,
                                  margin: const EdgeInsets.only(top: 8),
                                  decoration: BoxDecoration(
                                      color: ColorSystem.gray.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Non Billable',
                                        style: TextStyle(
                                            color: ColorSystem.gray
                                                .withOpacity(0.6),
                                            fontSize: 15),
                                      ),
                                      Text(
                                        '${widget.projectDetails.totalNonBillableHours.toInt()} Hrs',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ])
                              ],
                            ),
                          ]),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Leaves',
                            style: TextStyle(
                                color: ColorSystem.gray.withOpacity(0.6),
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text('${widget.projectDetails.leaves}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30)),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Total working days',
                            style: TextStyle(
                                color: ColorSystem.gray.withOpacity(0.6),
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text('${widget.projectDetails.totalWorkingDays}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30)),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Extra working days',
                            style: TextStyle(
                                color: ColorSystem.gray.withOpacity(0.6),
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text('${widget.projectDetails.extraWorkingDays}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30)),
                        ],
                      ),
                    ])),
              ])),
        ]));
  }
}
