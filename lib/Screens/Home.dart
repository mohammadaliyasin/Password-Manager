import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/main.dart';

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
        title: Text(
          'Password Manager',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xff11131E),
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home_outlined,
            ),
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(
              child: Icon(
                Icons.notifications_outlined,
              ),
            ),
            label: 'Notification',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(
                Icons.messenger_outline_outlined,
              ),
            ),
            label: 'Message',
          ),
        ],
      ),
    );
  }
}
