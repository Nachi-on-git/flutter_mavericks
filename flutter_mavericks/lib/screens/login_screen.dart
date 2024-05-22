// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_mavericks/design_system/color_system.dart';
import 'package:flutter_mavericks/design_system/scalesystem.dart';
import 'package:flutter_mavericks/design_system/sizesystem.dart';
import 'package:flutter_mavericks/models/http_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_services.dart';
import 'navigation_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _showPassword = false;
  AuthService authService = AuthService();
  bool isLoading = false;

  setUserId() {
    setState(() {});
  }

  userLogin() async {
    setState(() {
      isLoading = true;
    });
    HttpResponses response = await authService.userLogin(
      loginIdController.text.trim(),
      passwordController.text.trim(),
    );
    if (response.status!) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.data['token']);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavigationScreen()),
      );
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
  void dispose() {
    loginIdController.clear();
    passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SizeSystem.size24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/login_illustration.png',
              scale: ScaleSystem.scale2,
            ),
            const SizedBox(
              height: SizeSystem.size16,
            ),
            const Text(
              'Login',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(
              height: SizeSystem.size16,
            ),
            //textforfield for email
            Container(
              padding: const EdgeInsets.symmetric(horizontal: SizeSystem.size8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SizeSystem.size12),
                  border: Border.all()),
              child: TextFormField(
                cursorColor: ColorSystem.primaryColor,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) {
                  if (email!.isEmpty) {
                    return 'Email is required';
                  } else {
                    if (!RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                        .hasMatch(email)) {
                      return 'Enter a valid email.';
                    }
                  }
                  return null;
                },
                controller: loginIdController,
                onChanged: (val) {
                  setUserId();
                },
                
                decoration: const InputDecoration(
                  hintText: 'Email',
                  border: InputBorder.none,
                 // Removes the default border
                ),
              ),
            ),
            const SizedBox(
              height: SizeSystem.size16,
            ),
            //textforfield for password
            Container(
              padding: const EdgeInsets.symmetric(horizontal: SizeSystem.size8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SizeSystem.size12),
                  border: Border.all()),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                cursorColor: ColorSystem.primaryColor,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: passwordController,
                validator: (password) {
                  if (password!.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
                obscureText: !_showPassword,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                      focusColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      child: _showPassword
                          ? Image.asset(
                              'assets/images/hide_password.png',
                              scale: ScaleSystem.scale2,
                            )
                          : Image.asset(
                              'assets/images/password_visible.png',
                              scale: ScaleSystem.scale2,
                            )),
                  hintText: 'Password',
                  border: InputBorder.none, // Removes the default border
                ),
              ),
            ),
            const SizedBox(
              height: SizeSystem.size16,
            ),
            isLoading
                ? const CircularProgressIndicator(
                    color: ColorSystem.primaryColor,
                  )
                : InkWell(
                    onTap: () async {
                      if (passwordController.text.isNotEmpty &&
                          loginIdController.text.isNotEmpty) {
                        await userLogin();
                      } else {}
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                        vertical: SizeSystem.size12,
                      ),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(SizeSystem.size12),
                          color: passwordController.text.isNotEmpty &&
                                  RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                      .hasMatch(loginIdController.text)
                              ? ColorSystem.primaryColor
                              : Colors.grey),
                      child: const Center(
                          child: Text(
                        'Login',
                        style: TextStyle(
                            color: ColorSystem.white,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
