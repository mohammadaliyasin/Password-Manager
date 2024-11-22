import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../controllers/authController.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  Uint8List? _image;
  final AuthController _authController = AuthController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      _image = await pickedFile.readAsBytes();
      setState(() {
        _image!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 20.h,
        ),
        children: [
          Column(
            children: [
              Image.asset('assets/1.png'),
              _authController.isLoginPage
                  ? Text(
                      'Login',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 30.sp,
                      ),
                    )
                  : Text(
                      'SignUp',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 30.sp,
                      ),
                    ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
          // if (!_authController.isLoginPage) _buildImagePicker(),
          SizedBox(
            height: 20.h,
          ),
          Container(
            child: Form(
              key: _authController.formKey,
              child: Column(
                children: [
                  if (!_authController.isLoginPage)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                        color: const Color.fromARGB(255, 25, 29, 39),
                        border: Border.all(
                            color: const Color(0xff205BFF), width: 0.8.w),
                      ),
                      child: TextFormField(
                        cursorColor: const Color(0xff205BFF),
                        keyboardType: TextInputType.name,
                        key: const ValueKey('username'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Incorrect Username';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authController.username = value!;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter Username',
                          hintStyle: GoogleFonts.outfit(
                            color: const Color(0xff8F8F93),
                            fontSize: 14.sp,
                          ),
                          contentPadding: EdgeInsets.all(8.0.r),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: const Color.fromARGB(255, 25, 29, 39),
                      border: Border.all(
                        color: const Color(0xff205BFF),
                        width: 0.8.w,
                      ),
                    ),
                    child: TextFormField(
                      cursorColor: const Color(0xff205BFF),
                      keyboardType: TextInputType.emailAddress,
                      key: const ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Incorrect Email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authController.email = value!;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Email',
                        hintStyle: GoogleFonts.outfit(
                          color: const Color(0xff8F8F93),
                          fontSize: 14.sp,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(8.0.r),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: const Color.fromARGB(255, 25, 29, 39),
                      border: Border.all(
                        color: const Color(0xff205BFF),
                        width: 0.8.w,
                      ),
                    ),
                    child: TextFormField(
                      cursorColor: const Color(0xff205BFF),
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      key: const ValueKey('password'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Incorrect Password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authController.password = value!;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Password',
                        hintStyle: GoogleFonts.outfit(
                          color: const Color(0xff8F8F93),
                          fontSize: 14.sp,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(8.0.r),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.zero,
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          const Color(0xff205BFF),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_authController.formKey.currentState!.validate()) {
                          _authController.startAuthentication(context, _image);
                        }
                      },
                      child: _authController.isLoginPage
                          ? Text(
                              'Login',
                              style: GoogleFonts.outfit(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : Text(
                              'SignUp',
                              style: GoogleFonts.outfit(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _authController.isLoginPage
                          ? Text(
                              'Not a member ?',
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          : Text(
                              'Already a member ?',
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _authController.isLoginPage =
                                !_authController.isLoginPage;
                          });
                        },
                        child: _authController.isLoginPage
                            ? Text(
                                'Signup',
                                style: GoogleFonts.outfit(
                                    color: const Color(0xff205BFF),
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                'Login',
                                style: GoogleFonts.outfit(
                                    color: const Color(0xff205BFF),
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePicker() {
    return Stack(
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
                border:
                    Border.all(color: const Color(0xff205BFF), width: 0.8.w),
                shape: BoxShape.circle),
            child: CircleAvatar(
              radius: 60.r,
              backgroundColor: const Color.fromARGB(255, 25, 29, 39),
              backgroundImage: _image != null ? MemoryImage(_image!) : null,
              child: _image == null
                  ? Center(
                      child: Icon(
                        Icons.person,
                        color: const Color(0xff8F8F93),
                        size: 80.r,
                      ),
                    )
                  : null,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 180.w,
            top: 70.h,
          ),
          child: IconButton(
            icon: const Icon(Icons.add_a_photo),
            color: const Color(0xff205BFF),
            onPressed: _pickImage,
          ),
        ),
      ],
    );
  }
}
