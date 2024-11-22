import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:password_manager/models/addpasswordModel.dart';

class Addpasswordscreen extends StatefulWidget {
  const Addpasswordscreen({super.key});

  @override
  State<Addpasswordscreen> createState() => _AddpasswordscreenState();
}

class _AddpasswordscreenState extends State<Addpasswordscreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  Future<void> savePassword() async {
    if (_emailController.text.isEmpty ||
        _websiteController.text.isEmpty ||
        _categoryController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all the fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Addpasswordmodel passwordData = Addpasswordmodel(
      email: _emailController.text.trim(),
      webLink: _websiteController.text.trim(),
      category: _categoryController.text.trim(),
      password: _passwordController.text.trim(),
    );

    try {
      await FirebaseFirestore.instance
          .collection('passwords')
          .add(passwordData.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      _emailController.clear();
      _websiteController.clear();
      _categoryController.clear();
      _passwordController.clear();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving password: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff10111C),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(
                  Icons.add_task_outlined,
                  color: const Color(0xff205BFF),
                  size: 120.r,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              _buildTextfield('Email', 'Email', _emailController, false),
              SizedBox(
                height: 10.h,
              ),
              _buildTextfield('Website link', 'Website', _websiteController, false),
              SizedBox(
                height: 10.h,
              ),
              _buildTextfield('Category', 'Category', _categoryController, false),
              SizedBox(
                height: 10.h,
              ),
              _buildTextfield('Password', 'Password', _passwordController, true),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                height: 45.h,
                width: 340.w,
                child: ElevatedButton(
                  onPressed: savePassword,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Color(0xff205BFF),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextfield(String text, String hintText, TextEditingController controller, bool isPassword) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: GoogleFonts.outfit(
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: const Color(0xff171A26),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword ? _isPasswordHidden : false,
            cursorColor: const Color(0xff4361EE),
            style: GoogleFonts.outfit(color: const Color(0xffffffff)),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.outfit(
                color: const Color(0xff8F8F93),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(8.0),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                        color: const Color(0xff8F8F93),
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordHidden = !_isPasswordHidden;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}