import 'package:flutter/material.dart';
import '../design_system/color_system.dart';
import '../design_system/scalesystem.dart';
import '../design_system/sizesystem.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSystem.white,
      appBar: AppBar(
        backgroundColor: ColorSystem.white,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
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
                size: 18,
              ),
            )),
        title: const Text(
          'Settings',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorSystem.lightOrange,
            fontSize: 24,
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: SizeSystem.size20, left: SizeSystem.size30),
              child: Text(
                'Want to change your password?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: SizeSystem.size30, top: SizeSystem.size4, bottom: SizeSystem.size20 ),
              child: Opacity(
                opacity: 0.60,
                child: Text(
                  'changed 2 weeks ago',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      child: !_showPassword
                          ? Image.asset(
                        'assets/images/hide_password.png',
                        scale: ScaleSystem.scale2,
                      )
                          : Image.asset(
                        'assets/images/password_visible.png',
                        scale: ScaleSystem.scale2,
                      )),
                  hintText: 'Current password',
                  hintStyle:  const TextStyle(
                    color: Color(0xFF78746D),
                    fontSize: 14,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      child: !_showPassword
                          ? Image.asset(
                        'assets/images/hide_password.png',
                        scale: ScaleSystem.scale2,
                      )
                          : Image.asset(
                        'assets/images/password_visible.png',
                        scale: ScaleSystem.scale2,
                      )),
                  hintText: 'Create new password',
                  hintStyle:  const TextStyle(
                    color: Color(0xFF78746D),
                    fontSize: 14,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      child: !_showPassword
                          ? Image.asset(
                        'assets/images/hide_password.png',
                        scale: ScaleSystem.scale2,
                      )
                          : Image.asset(
                        'assets/images/password_visible.png',
                        scale: ScaleSystem.scale2,
                      )),
                  hintText: 'Confirm new password',
                  hintStyle:  const TextStyle(
                    color: ColorSystem.gray,
                    fontSize: 14,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(
                  vertical: SizeSystem.size12,
                ),
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(SizeSystem.size12),
                    color: ColorSystem.primaryColor
                ),
                child: const Center(
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                          color: ColorSystem.white,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
