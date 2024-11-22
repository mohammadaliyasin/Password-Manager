import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:password_manager/Screens/Home.dart';
import 'package:password_manager/Screens/Walkthrough.dart';
import 'package:password_manager/Screens/addPasswordScreen.dart';
import 'package:password_manager/Screens/passwordGenerator.dart';
import 'package:password_manager/firebase_options.dart';
import 'Screens/auth/authscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      const MyApp(),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, usersnapshot) {
          if (usersnapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (usersnapshot.hasData) {
            return Home();
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
