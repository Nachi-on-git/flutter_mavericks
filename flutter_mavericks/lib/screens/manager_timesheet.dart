import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mavericks/design_system/sizesystem.dart';
import 'package:flutter_mavericks/screens/timesheet_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../design_system/color_system.dart';
import '../design_system/padding_system.dart';

class ManagerTimeSheetView extends StatefulWidget {
  const ManagerTimeSheetView({super.key});

  @override
  State<ManagerTimeSheetView> createState() => _ManagerTimeSheetViewState();
}

class _ManagerTimeSheetViewState extends State<ManagerTimeSheetView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isLoading = false;

  getMyTimeSheet() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    // Add a listener to the TabController to listen for tab changes
    getMyTimeSheet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Timesheets',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: ColorSystem.primaryColor.withOpacity(0.1),
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: ColorSystem.primaryColor,
                  unselectedLabelColor: ColorSystem.gray,
                  labelColor: ColorSystem.primaryColor,
                  automaticIndicatorColorAdjustment: true,
                  tabs: const [
                    Tab(
                      child: Text(
                        'Your Timesheets',
                        style: TextStyle(
                          color: ColorSystem.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ), // Title for Tab 1
                    Tab(
                      child: Text(
                        'Teams Timesheets',
                        style: TextStyle(
                          color: ColorSystem.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(controller: _tabController, children: [
                  Column(
                    children: [TimesheetDetails()],
                  ),
                  Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.all(PaddingSystem.padding20),
                          padding: EdgeInsets.symmetric(
                              horizontal: PaddingSystem.padding20,
                              vertical: PaddingSystem.padding05),
                          decoration: BoxDecoration(
                              border: Border.all(color: ColorSystem.gray.withOpacity(0.4)),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: PaddingSystem.padding10,
                                        left: PaddingSystem.padding10,
                                        right: PaddingSystem.padding10),
                                    child:
                                        Image.asset('assets/images/emp.png')),
                                Text(
                                  'Nachiket Labade',
                                  style: TextStyle(
                                      fontSize: SizeSystem.size20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ])),
                    ],
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
