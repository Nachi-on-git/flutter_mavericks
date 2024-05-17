import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mavericks/screens/apprisals/no_apprisals.dart';

import '../../design_system/color_system.dart';
import '../../widgets/apprisal_card.dart';
import 'instructions.dart';

class Managerappraisals extends StatefulWidget {
  const Managerappraisals({super.key});

  @override
  State<Managerappraisals> createState() => _ManagerappraisalsState();
}

class _ManagerappraisalsState extends State<Managerappraisals>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
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
          'Appraisals',
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
                        'Your Appraisals',
                        style: TextStyle(
                          color: ColorSystem.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ), // Title for Tab 1
                    Tab(
                      child: Text(
                        'Teams Appraisals',
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
              SingleChildScrollView(
                  child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(controller: _tabController, children: [
                  const Noappraisals(),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const StartAppraisalInfoScreen()),
                                );
                              },
                              child: const AppraisalsCard(
                                appraisalYear: '2024',
                                employeeName: 'Manoj Waghmare',
                                employeeDesignation: 'Flutter developer',
                                isResponseSubmitted: true,
                                isEmp: false,
                              ));
                        })),
                  )
                ]),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
