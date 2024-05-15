import 'package:flutter/material.dart';
import 'package:flutter_mavericks/design_system/padding_system.dart';
import 'package:flutter_mavericks/design_system/sizesystem.dart';
import 'package:intl/intl.dart';

import '../design_system/color_system.dart';

class TimesheetDetails extends StatefulWidget {
  const TimesheetDetails({super.key});

  @override
  State<TimesheetDetails> createState() => _TimesheetDetailsState();
}

class _TimesheetDetailsState extends State<TimesheetDetails> {
  DateTime currentDate = DateTime.now();
  DateTime? parsedDate;
  String formattedDate = '';

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 10), () {
      formattedDate = DateFormat('MMM yyyy').format(currentDate);
      print(formattedDate);
    });
    super.initState();
  }

  // get total days in months
  int getDaysInMonths() {
    // get month count
    int totalDaysInMonths = DateTimeRange(
        start: DateTime(currentDate.year, currentDate.month, 1),
        end: DateTime(
          currentDate.year,
          currentDate.month + 1,
        )).duration.inDays;
    DateTime startDate = DateTime(currentDate.year, currentDate.month, 01);
    DateTime endDate =
        DateTime(currentDate.year, currentDate.month, totalDaysInMonths);
    return endDate.difference(startDate).inDays + 1;
  }

  previousMonth() {
    currentDate.subtract(Duration(days: getDaysInMonths()));
  }

  nextMonth() {
    currentDate.add(Duration(days: getDaysInMonths()));
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/images/bullet.png',
                              color: ColorSystem.white,
                            ),
                            Text(
                              'Emp ID',
                              style: const TextStyle(
                                  color: ColorSystem.gray,
                                  fontSize: SizeSystem.size20),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: PaddingSystem.padding20,
                        ),
                        Text(
                          'Project Name',
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
                      Row(
                        children: [
                          Text(
                            'Total working hours',
                            style: const TextStyle(
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
                              '200',
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
                        value: 0.4,
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
                                        '150 Hrs',
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
                                        '150 Hrs',
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
                          Text('2',
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
                          Text('0',
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
                          Text('0',
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
