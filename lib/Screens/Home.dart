import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff10111C),
      appBar: AppBar(
        backgroundColor: const Color(0xff10111C),
        title: Text('Password Manager',style: GoogleFonts.outfit(),),
        centerTitle: true,

      ),

    );
  }
}