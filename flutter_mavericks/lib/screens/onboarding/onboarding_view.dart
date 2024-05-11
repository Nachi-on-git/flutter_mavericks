import 'package:flutter/material.dart';
import 'package:flutter_mavericks/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../design_system/color_system.dart';
import '../../design_system/scalesystem.dart';
import '../../design_system/sizesystem.dart';
import '../home_screen.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  OnboardingViewState createState() => OnboardingViewState();
}

class OnboardingViewState extends State<OnboardingView> {
  late PageController _pageController;
  late ValueNotifier<int> _currentPage;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _currentPage = ValueNotifier<int>(0);
    _pageController.addListener(() {
      _currentPage.value = _pageController.page!.round();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ValueListenableBuilder(
          valueListenable: _currentPage,
          builder: (context, currentPage, _) {
            return Padding(
              padding: const EdgeInsets.all(SizeSystem.size16).copyWith(top: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isVisitedOnboarding', true);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: ColorSystem.gray,
                          fontSize: SizeSystem.size14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: PageView(
                      controller: _pageController,
                      children: [
                        OnboardingScreen(
                          image: 'assets/images/obs1.png',
                          title: 'Better Timesheet Management',
                          subtitle: 'No more need of filling timely google forms to submit your time-logs! We made things easy for you',
                          currentPageIndex: currentPage,
                        ),
                        OnboardingScreen(
                          image: 'assets/images/obs2.png',
                          title: 'Appraisals made smoother',
                          subtitle: 'Accurate Transparent Faster without making any stressful efforts and with a speed that is non comparable !',
                          currentPageIndex: currentPage,
                        ),
                        OnboardingScreen(
                          image: 'assets/images/obs3.png',
                          title: 'Save your time and hustle',
                          subtitle: 'Time sheets & Appraisals made easy for everyone and get a smoother flow',
                          currentPageIndex: currentPage,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: SizeSystem.size20),
                  InkWell(
                    onTap: () async {
                      if (currentPage < 2) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      } else {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isVisitedOnboarding', true);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: SizeSystem.size20),
                      padding: const EdgeInsets.symmetric(
                        vertical: SizeSystem.size12,
                      ),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(SizeSystem.size12), color: ColorSystem.primaryColor),
                      child: Center(
                        child: Text(
                          currentPage == 2 ? 'Let\'s Start' : 'Next',
                          style: const TextStyle(
                            color: ColorSystem.white,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeSystem.size16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final int currentPageIndex;

  const OnboardingScreen({
    required this.image,
    required this.title,
    required this.subtitle,
    Key? key,
    required this.currentPageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          scale: ScaleSystem.scale1,
        ),
        const SizedBox(height: SizeSystem.size30),
        Text(
          title,
          style: const TextStyle(
            fontSize: SizeSystem.size24,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: SizeSystem.size20),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: SizeSystem.size14,
            fontWeight: FontWeight.w500,
            color: ColorSystem.gray,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: SizeSystem.size30),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: SizeSystem.size16,
                    height: SizeSystem.size6,
                    decoration: BoxDecoration(
                      shape: currentPageIndex != i ? BoxShape.circle : BoxShape.rectangle,
                      borderRadius: currentPageIndex != i ? null : BorderRadius.circular(10),
                      color: currentPageIndex == i ? Colors.blue : Colors.grey.withOpacity(0.5),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
