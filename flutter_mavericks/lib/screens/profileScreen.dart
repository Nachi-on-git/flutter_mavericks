import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../design_system/color_system.dart';
import '../models/http_response.dart';
import '../services/auth_services.dart';
import '../services/shared_preferences.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}



class _ProfileScreenState extends State<ProfileScreen> {
  AuthService authService = AuthService();
  Map<dynamic, dynamic> employeeDetails = {};
  bool isLoading = false;


  getUserDetails() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferenceService sharedPreferences = SharedPreferenceService();
    String? token = await sharedPreferences.getUserToken(key: 'token');
    HttpResponses response = await authService.getUserDetails(token??"");
    if (response.status!) {
      employeeDetails = response.data;
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Something went wrong !!"),
      ));
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
      backgroundColor: ColorSystem.white,
      appBar: AppBar(
        backgroundColor: ColorSystem.white,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              //Navigator.pop(context);
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
              ),
            )),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: isLoading?
          const Center(child: CircularProgressIndicator()):
      SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: SvgPicture.asset("assets/images/profileImage.svg"),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(width: 1, color: const Color(0xFFBEBAB3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/profileName.svg"),
                  const SizedBox(
                    width: 17,
                  ),
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Name',
                        style: TextStyle(
                          color: Color(0xFF3B3936),
                          fontSize: 20,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.50,
                        ),
                      ),
                      Text(
                        "${employeeDetails['firstName']??""} ${employeeDetails['lastName']??""}",
                        style: const TextStyle(
                          color: Color(0xFF78746D),
                          fontSize: 14,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(width: 1, color: const Color(0xFFBEBAB3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/emailImage.svg"),
                  const SizedBox(
                    width: 17,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email',
                        style: TextStyle(
                          color: Color(0xFF3B3936),
                          fontSize: 20,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.50,
                        ),
                      ),
                      Text(
                        "${employeeDetails['email']??""}",
                        style: const TextStyle(
                          color: Color(0xFF78746D),
                          fontSize: 14,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8 ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(width: 1, color: const Color(0xFFBEBAB3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/phoneImage.svg"),
                  const SizedBox(
                    width: 17,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Phone Number',
                        style: TextStyle(
                          color: Color(0xFF3B3936),
                          fontSize: 20,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.50,
                        ),
                      ),
                      Text(
                        "${employeeDetails['phoneNumber']??""}",
                        style: const TextStyle(
                          color: Color(0xFF78746D),
                          fontSize: 14,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8 ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(width: 1, color: const Color(0xFFBEBAB3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/roleImage.svg"),
                  const SizedBox(
                    width: 17,
                  ),
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Employee Role',
                        style: TextStyle(
                          color: Color(0xFF3B3936),
                          fontSize: 20,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.50,
                        ),
                      ),
                      Text(
                        "${employeeDetails['employeeRole']??""}",
                        style: const TextStyle(
                          color: Color(0xFF78746D),
                          fontSize: 14,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8 ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(width: 1, color: const Color(0xFFBEBAB3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/joiningDate.svg",),
                  const SizedBox(
                    width: 17,
                  ),
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Joining Date',
                        style: TextStyle(
                          color: Color(0xFF3B3936),
                          fontSize: 20,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.50,
                        ),
                      ),
                      if(employeeDetails["joiningDate"] != null)
                      Text(
                        DateFormat('d MMMM yyyy').format(DateTime.parse("${employeeDetails["joiningDate"]}")),
                        style: const TextStyle(
                          color: Color(0xFF78746D),
                          fontSize: 14,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8 ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(width: 1, color: const Color(0xFFBEBAB3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/manager.svg"),
                  const SizedBox(
                    width: 17,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Reporting Manager',
                        style: TextStyle(
                          color: Color(0xFF3B3936),
                          fontSize: 20,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.50,
                        ),
                      ),
                      Text(
                       "${employeeDetails['reportingManager']??""}",
                        style: const TextStyle(
                          color: Color(0xFF78746D),
                          fontSize: 14,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () async {
                SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                prefs.remove('empId');
                prefs.remove('token');
                prefs.remove('employee_type');
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ));
              },
              child: const Center(
                child: Text(
                  'Log out',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF78746D),
                    fontSize: 14,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
