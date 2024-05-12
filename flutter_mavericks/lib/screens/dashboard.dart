import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mavericks/design_system/scalesystem.dart';
import 'package:flutter_mavericks/design_system/sizesystem.dart';
import 'package:flutter_mavericks/screens/timesheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_response.dart';
import '../services/auth_services.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  AuthService authService = AuthService();
  bool isLoading = false;
  String? userName = '';

  getUserDetails() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userToken = prefs.getString('token');
    HttpResponses response = await authService.getUserDetails(userToken ?? '');
    if (response.status!) {
      setState(() {
        userName = response.data['firstName'];
      });
      print("user details : ${response.data}");
      prefs.setInt('empId', response.data['id']);
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
          padding: const EdgeInsets.symmetric(
              vertical: SizeSystem.size24, horizontal: SizeSystem.size24),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hello,',
                        style: TextStyle(
                            color: Colors.black, fontSize: SizeSystem.size16),
                      ),
                      const SizedBox(
                        height: SizeSystem.size8,
                      ),
                      Text(
                        userName ?? '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: SizeSystem.size32,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/dashboard_bell.png',
                        scale: ScaleSystem.scale2,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Timesheets()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SizeSystem.size12),
                      border:
                          Border.all(color: Colors.black45.withOpacity(0.3))),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: SizeSystem.size16,
                              vertical: SizeSystem.size12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Timesheet',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeSystem.size24),
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
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SizeSystem.size12),
                    border: Border.all(color: Colors.black45.withOpacity(0.3))),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: SizeSystem.size16,
                            vertical: SizeSystem.size12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Appraisals',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeSystem.size24),
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
