import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/main.dart';

class PasswordGeneratorScreen extends StatefulWidget {
  @override
  _PasswordGeneratorScreenState createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen> {
  int _passwordLength = 8;
  bool _includeUppercase = true;
  bool _includeLowercase = true;
  bool _includeNumbers = true;
  bool _includeSymbols = false;
  String _generatedPassword = '';

  String generatePassword({
    required int length,
    bool useUppercase = true,
    bool useLowercase = true,
    bool useNumbers = true,
    bool useSymbols = true,
  }) {
    const uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const lowercase = 'abcdefghijklmnopqrstuvwxyz';
    const numbers = '0123456789';
    const symbols = '!@#\$%^&*()_+-=[]{}|;:,.<>?';

    String chars = '';
    if (useUppercase) chars += uppercase;
    if (useLowercase) chars += lowercase;
    if (useNumbers) chars += numbers;
    if (useSymbols) chars += symbols;

    if (chars.isEmpty) return '';

    Random random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  void _generatePassword() {
    setState(() {
      _generatedPassword = generatePassword(
        length: _passwordLength,
        useUppercase: _includeUppercase,
        useLowercase: _includeLowercase,
        useNumbers: _includeNumbers,
        useSymbols: _includeSymbols,
      );
    });
  }

  void _copyPassword() {
    if (_generatedPassword.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: _generatedPassword));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password copied to clipboard!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff10111C),
      appBar: AppBar(
        backgroundColor: const Color(0xff10111C),
        title: Text(
          'Password Generator',
          style: GoogleFonts.outfit(color: Colors.white),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              readOnly: true,
              style: GoogleFonts.outfit(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Generated Password',
                hintText: 'Password...',
                hintStyle:  GoogleFonts.outfit(color: Colors.white38,fontSize: 16.sp),
                labelStyle: GoogleFonts.outfit(
                  color: const Color(0xff205BFF),
                  fontSize: 16.sp,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff205BFF)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff205BFF)),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.copy,color: Colors.white54,),
                  onPressed: _copyPassword,
                ),
              ),
              controller: TextEditingController(text: _generatedPassword),
            ),
            SizedBox(height: 20.h),
            Text(
              'Password Length: $_passwordLength',
              style: GoogleFonts.outfit(color: Colors.white,fontSize: 14.sp),
            ),
            Slider(
              thumbColor: const Color(0xff205BFF),
              activeColor: const Color(0xff205BFF),
              inactiveColor: Colors.white,
              secondaryActiveColor: Colors.black,
              min: 4,
              max: 20,
              divisions: 16,
              value: _passwordLength.toDouble(),
              label: _passwordLength.toString(),
              onChanged: (value) {
                setState(() {
                  _passwordLength = value.toInt();
                });
              },
            ),
            SizedBox(height: 20.h),
            CheckboxListTile(
              activeColor: const Color(0xff205BFF),
              title: Text(
                'Include Uppercase Letters',
                style: GoogleFonts.outfit(color: Colors.white,fontSize: 16.sp),
              ),
              value: _includeUppercase,
              onChanged: (bool? value) {
                setState(() {
                  _includeUppercase = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              activeColor: const Color(0xff205BFF),
              title: Text(
                'Include Lowercase Letters',
                style: GoogleFonts.outfit(color: Colors.white,fontSize: 16.sp),
              ),
              value: _includeLowercase,
              onChanged: (bool? value) {
                setState(() {
                  _includeLowercase = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              activeColor: const Color(0xff205BFF),
              title: Text(
                'Include Numbers',
                style: GoogleFonts.outfit(color: Colors.white,fontSize: 16.sp),
              ),
              value: _includeNumbers,
              onChanged: (bool? value) {
                setState(() {
                  _includeNumbers = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              activeColor: const Color(0xff205BFF),
              title: Text(
                'Include Symbols',
                style: GoogleFonts.outfit(color: Colors.white,fontSize: 16.sp),
              ),
              value: _includeSymbols,
              onChanged: (bool? value) {
                setState(() {
                  _includeSymbols = value ?? false;
                });
              },
            ),
            SizedBox(height: 20.h),
            Center(
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Color(0xff205BFF),
                  ),
                ),
                onPressed: _generatePassword,
                child: Text(
                  'Generate Password',
                  style: GoogleFonts.outfit(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
