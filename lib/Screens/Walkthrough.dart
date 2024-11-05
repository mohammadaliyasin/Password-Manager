import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/main.dart';

class Walkthrough extends StatelessWidget {
  const Walkthrough({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff10111C),
      appBar: AppBar(
        backgroundColor: const Color(0xff10111C),
        title: Text(
          'Password Manager',
          style: GoogleFonts.outfit(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60.h,
          ),
          Center(
            child: Icon(
              Icons.lock_outline,
              color: Colors.blue,
              size: 200.r,
            ),
          ),
        ],
      ),
    );
  }
}
