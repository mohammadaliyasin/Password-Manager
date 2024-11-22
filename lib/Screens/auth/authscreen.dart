import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'authform.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoginPage = true;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff11151E),
      body: AuthForm(),
    );
  }
}
