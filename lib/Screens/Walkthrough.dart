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
          style: GoogleFonts.outfit(color: Colors.white,),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 60.h,
            ),
            Center(
              child: Icon(
                Icons.lock_outline,
                color: const Color(0xff205BFF),
                size: 200.r,
              ),
            ),
            SizedBox(
              height: 60.h,
            ),
            Text(
              'All your passwords in one\nsecure place',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(color: Colors.white, fontSize: 22.sp),
            ),
            SizedBox(
              height: 50.h,
              width: 340.w,
              child: ElevatedButton(
                onPressed: () {},
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Color(0xff205BFF),
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: GoogleFonts.outfit(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
