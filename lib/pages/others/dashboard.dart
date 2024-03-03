import 'package:flutter/material.dart';
import 'package:tsbridgedu/pages/Acheiver/acheivers.dart';
import 'package:tsbridgedu/pages/Activity/Quiz/Quizsummit.dart';
//import 'package:tsbridgedu/pages/dashboard.dart';
import 'package:tsbridgedu/pages/Home/homepage.dart';
import 'package:tsbridgedu/pages/LiveClass/liveclassess.dart';
import 'package:tsbridgedu/pages/ProfilePahes/profilepage.dart';

//import 'package:tsbridgedu/pages/signuppage.dart';
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<Widget> _pages = [
    ProfilePage(),
    HomePage(),
    LiveClasses(),
    ViewQuizzes(),
    StudentStatsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('TS Bridge Education'),
    ));
  }
}
