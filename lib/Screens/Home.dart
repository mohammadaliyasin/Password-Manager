import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:password_manager/Screens/addPasswordScreen.dart';
import 'package:password_manager/Screens/auth/passwordScreen.dart';
import 'package:password_manager/Screens/passwordGenerator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final _screens = [
    const PasswordsScreen(),
    const Addpasswordscreen(),
    PasswordGeneratorScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff10111C),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(16, 17, 28, 1),
        toolbarHeight: 60.h,
        title: Text(
          'My passwords',
          style: GoogleFonts.outfit(
            color: const Color(0xff205BFF),
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: const Color(0xff205BFF),
            child: Center(
              child: Icon(
                Icons.person,
                size: 40.r,
              ),
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF171A26),
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 0, "Home"),
              const SizedBox(width: 64),
              _buildNavItem(Icons.password, 2, "Generate Password"),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onItemTapped(1);
        },
        backgroundColor: const Color(0xFF205BFF),
        child: const Icon(Icons.add, size: 36.0, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildNavItem(IconData icon, int index, String label) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 28.0,
            color: _selectedIndex == index ? Colors.blue : Colors.white,
          ),
          if (_selectedIndex == index)
            Container(
              margin: const EdgeInsets.only(top: 4.0),
              height: 4.0,
              width: 4.0,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}

