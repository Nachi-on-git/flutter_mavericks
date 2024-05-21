import 'package:flutter/material.dart';
import 'package:flutter_mavericks/design_system/color_system.dart';
import 'package:flutter_mavericks/screens/dashboard.dart';
import 'package:flutter_mavericks/screens/profile_screen.dart';
import 'package:flutter_mavericks/screens/settings_screen.dart';

class NavigationScreen extends StatefulWidget {
   const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
   int _selectedIndex = 0;

   final List<Widget> _pages = [
     const Dashboard(),
     const ProfileScreen(),
     const SettingsScreen(),
   ];


   void _onTabSelected(int index) {
     setState(() {
       _selectedIndex = index;
     });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorSystem.white,
        currentIndex: _selectedIndex,
        onTap: _onTabSelected,
        selectedItemColor: ColorSystem.primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
