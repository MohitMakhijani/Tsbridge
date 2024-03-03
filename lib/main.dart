import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tsbridgedu/pages/Acheiver/acheivers.dart';
import 'package:tsbridgedu/pages/Activity/Quiz/Quizsummit.dart';
import 'package:tsbridgedu/pages/Home/homepage.dart';
import 'package:tsbridgedu/pages/LiveClass/liveclassess.dart';
import 'package:tsbridgedu/pages/SignIn/loginpage.dart';
import 'package:tsbridgedu/pages/others/privacypolicy.dart';
import 'package:tsbridgedu/pages/ProfilePahes/profilepage.dart';
import 'package:tsbridgedu/pages/SignUp/signuppage.dart';
import 'package:tsbridgedu/pages/ProfilePahes/editprofile.dart';
import 'package:tsbridgedu/pages/others/settings.dart';
import 'courses/Widget/CourseList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: '/login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black, // App bar color
        scaffoldBackgroundColor: Colors.white, // Background color
        colorScheme: ColorScheme.fromSwatch(
          accentColor: Color(0xFF0D94E7), // Color #0d94e7
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black), // Body text color
          bodyText2: TextStyle(color: Colors.black), // Secondary text color
          headline6: TextStyle(color: Colors.black), // App bar text color
        ),
      ),
      routes: {
        '/home': (context) => const HomePage(),
        '/courses': (context) => CoursePage(),
        '/liveclasses': (context) => LiveClasses(),
        '/activity': (context) => const ViewQuizzes(),
        '/achievers': (context) => StudentStatsPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => const Signup(),
        '/profile': (context) => ProfilePage(),
        '/editprofile': (context) => EditProfilePage(),
        '/settings': (context) => SettingsPage(),
        '/privacypolicy': (context) => PrivacyPolicyPage(),

      },
    );
  }
}
