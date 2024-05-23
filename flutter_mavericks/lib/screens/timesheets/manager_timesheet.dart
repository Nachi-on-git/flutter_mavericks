import 'package:flutter/material.dart';
import 'package:flutter_mavericks/screens/timesheets/timesheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../design_system/color_system.dart';
import 'mentees_timesheets.dart';

class ManagerTimeSheetView extends StatefulWidget {
  const ManagerTimeSheetView({super.key});

  @override
  State<ManagerTimeSheetView> createState() => _ManagerTimeSheetViewState();
}

class _ManagerTimeSheetViewState extends State<ManagerTimeSheetView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isLoading = false;
  int id = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    // Add a listener to the TabController to listen for tab changes
    Future.delayed(const Duration(milliseconds: 200), () {
      getId();
    });
    super.initState();
  }

  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getInt('empId') ?? 0;
      // print("id : $id");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              SingleChildScrollView(
                  child: SizedBox(
                height: MediaQuery.of(context).size.height * 3,
                child: TabBarView(controller: _tabController, children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Timesheets(
                        empId: id.toString(),
                        isEmp: true,
                        empName: '',
                      )),
                const  Column(
                    children: [MenteesTimesheet()],
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
