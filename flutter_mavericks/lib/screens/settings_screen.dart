import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../design_system/color_system.dart';
import '../models/http_response.dart';
import '../services/auth_services.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String fullName = '';
  String email = '';
  bool isLoading = false;

 getUserDetails()async{
   setState(() {
     isLoading = true;
   });
   SharedPreferences prefs = await SharedPreferences.getInstance();
   fullName = prefs.getString("fullName")??"";
   email = prefs.getString("email")??"";
   print(fullName);
   print("ahgfdgh ${email}");
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
       
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: isLoading?
      const Center(child: CircularProgressIndicator()):
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/images/notificationImage.svg"),
                      const SizedBox(
                        width: 17,
                      ),
                      const Text(
                        'Notifications',
                        style: TextStyle(
                          color: Color(0xFF3B3936),
                          fontSize: 20,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.50,
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset("assets/images/toggle_button.svg")
                ],
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.only(left: 16, top: 8),
            //   child: Text(
            //     'Account information',
            //     style: TextStyle(
            //       color: Color(0xFF3B3936),
            //       fontSize: 20,
            //       fontFamily: 'Rubik',
            //       fontWeight: FontWeight.w500,
            //       letterSpacing: -0.50,
            //     ),
            //   ),
            // ),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(16),
            //     border: Border.all(width: 1, color: const Color(0xFFBEBAB3)),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Row(
            //         mainAxisSize: MainAxisSize.min,
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           SvgPicture.asset("assets/images/profileName.svg"),
            //           const SizedBox(
            //             width: 17,
            //           ),
            //            Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               const Text(
            //                 'Name',
            //                 style: TextStyle(
            //                   color: Color(0xFF3B3936),
            //                   fontSize: 20,
            //                   fontFamily: 'Rubik',
            //                   fontWeight: FontWeight.w500,
            //                   letterSpacing: -0.50,
            //                 ),
            //               ),
            //               Text(
            //                 fullName,
            //                 style: const TextStyle(
            //                   color: Color(0xFF78746D),
            //                   fontSize: 14,
            //                   fontFamily: 'Rubik',
            //                   fontWeight: FontWeight.w400,
            //                 ),
            //               )
            //             ],
            //           ),
            //         ],
            //       ),
            //       SvgPicture.asset("assets/images/rightArrow.svg")
            //     ],
            //   ),
            // ),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(16),
            //     border: Border.all(width: 1, color: const Color(0xFFBEBAB3)),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Row(
            //         mainAxisSize: MainAxisSize.min,
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           SvgPicture.asset("assets/images/emailImage.svg"),
            //           const SizedBox(
            //             width: 17,
            //           ),
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               const Text(
            //                 'Email',
            //                 style: TextStyle(
            //                   color: Color(0xFF3B3936),
            //                   fontSize: 20,
            //                   fontFamily: 'Rubik',
            //                   fontWeight: FontWeight.w500,
            //                   letterSpacing: -0.50,
            //                 ),
            //               ),
            //               Text(
            //                 email,
            //                 style: const TextStyle(
            //                   color: Color(0xFF78746D),
            //                   fontSize: 14,
            //                   fontFamily: 'Rubik',
            //                   fontWeight: FontWeight.w400,
            //                 ),
            //               )
            //             ],
            //           ),
            //         ],
            //       ),
            //       SvgPicture.asset("assets/images/rightArrow.svg")
            //     ],
            //   ),
            // ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/password.svg"),
                      const SizedBox(
                        width: 17,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password',
                            style: TextStyle(
                              color: Color(0xFF3B3936),
                              fontSize: 20,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.50,
                            ),
                          ),
                          Text(
                            'changed 2 weeks ago',
                            style: TextStyle(
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
                  SvgPicture.asset("assets/images/rightArrow.svg")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
