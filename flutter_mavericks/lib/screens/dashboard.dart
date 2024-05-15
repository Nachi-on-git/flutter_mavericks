import 'package:flutter/material.dart';
import 'package:flutter_mavericks/design_system/scalesystem.dart';
import 'package:flutter_mavericks/design_system/sizesystem.dart';
import 'package:flutter_mavericks/screens/login_screen.dart';
import 'package:flutter_mavericks/screens/timesheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_response.dart';
import '../services/auth_services.dart';
import 'manager_timesheet.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  AuthService authService = AuthService();
  bool isLoading = false;
  String userName = '';
  String? empRole;

  getUserDetails() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userToken = prefs.getString('token');
    print(userToken);
    HttpResponses response = await authService.getUserDetails(userToken ?? '');
    if (response.status!) {
      setState(() {
        userName = response.data['firstName'];
        empRole = response.data['employeeRole'];
      });
      print("user details : ${response.data}");
      prefs.setInt('empId', response.data['id']);
      prefs.setString('employeeRole', response.data['employeeRole']);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: SizeSystem.size24, horizontal: SizeSystem.size24),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hello,',
                        style: TextStyle(color: Colors.black, fontSize: SizeSystem.size16),
                      ),
                      const SizedBox(
                        height: SizeSystem.size8,
                      ),
                      Text(
                        userName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: SizeSystem.size32,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.remove('empId');
                        prefs.remove('token');
                        prefs.remove('employee_type');
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ));
                      },
                      icon: const Icon(Icons.logout))
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              GestureDetector(
                onTap: () {
                  if (empRole == null || empRole == 'employee') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Timesheets()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ManagerTimeSheetView()),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SizeSystem.size12), border: Border.all(color: Colors.black45.withOpacity(0.3))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(SizeSystem.size12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/timesheet_dashboard.png',
                          fit: BoxFit.none,
                          scale: ScaleSystem.scale2,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: SizeSystem.size16, vertical: SizeSystem.size12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Timesheet',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: SizeSystem.size24),
                              ),
                              Text(
                                'Get your timesheets powered with HRMS',
                                style: TextStyle(fontSize: SizeSystem.size14),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: SizeSystem.size24,
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(SizeSystem.size12), border: Border.all(color: Colors.black45.withOpacity(0.3))),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(SizeSystem.size12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/appraisals_dashboard.png',
                        fit: BoxFit.none,
                        scale: ScaleSystem.scale2,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: SizeSystem.size16, vertical: SizeSystem.size12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Appraisals',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: SizeSystem.size24),
                            ),
                            Text(
                              'Manage & track your appraisals here',
                              style: TextStyle(fontSize: SizeSystem.size14),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
