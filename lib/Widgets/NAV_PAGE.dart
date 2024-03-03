import 'package:flutter/material.dart';
import 'package:tsbridgedu/ChatBot/ChatBot.dart';
import 'package:tsbridgedu/FeedbackSecction/feedbackPage.dart';
import 'package:tsbridgedu/LiveClassesApp/live.dart';
import 'package:tsbridgedu/Widgets/Upi%20page.dart';
import 'package:tsbridgedu/pages/Acheiver/acheivers.dart';
import 'package:tsbridgedu/pages/Activity/Activitypage.dart';
import 'package:tsbridgedu/pages/Home/homepage.dart';
import 'package:tsbridgedu/pages/ProfilePahes/profilepage.dart';

import '../courses/Widget/CourseList.dart';

class NavPage extends StatefulWidget {
  const NavPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,actions: [
        IconButton(
          icon: Icon(Icons.chat),
          onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context) {
           return const ChatBot();
         },));
          },
        ),
      ]),
      drawer: Drawer(width: 250,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/tsbedu.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Dashboard Menu',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                print('Profile tapped');
               Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(),));
              },
            ),
            ListTile(
              title: Text('Edit Profile'),
              onTap: () {
                print('Edit Profile tapped');
                Navigator.pushNamed(context, '/editprofile');
              },
            ), ListTile(
              title: Text('Settings'),
              onTap: () {
                print('Edit Profile tapped');
                Navigator.pushNamed(context, '/settings');
              },
            ), ListTile(
              title: Text('Private Policy'),
              onTap: () {
                print('Edit Profile tapped');
                Navigator.pushNamed(context, '/privacypolicy');
              },
            ), ListTile(
              title: Text('LogOut'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ), ListTile(
              title: Text('Subscribe'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UPIPAGE();
                },));
              },
            ),ListTile(
              title: Text('Help And Support'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SupportPage();
                },));
              },
            ),
            // Add debug print statements for other ListTiles
          ],
        ),
      ),
      backgroundColor: Colors.blue,
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 16.0,
        unselectedFontSize: 14.0,
        iconSize: 30.0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Courses"),
          BottomNavigationBarItem(
              icon: Icon(Icons.live_tv), label: "Live Classes"),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_activity_outlined), label: "Activity"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), label: "Achievements"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const HomePage(); // Corrected class name
      case 1:
        return const CoursePage(); // Corrected class name
      case 2:
        return const Live(); // Corrected class name
      case 3:
        return Activity();
      case 4:
        return  const StudentStatsPage();// Corrected class name
      default:
        return Container(); // Placeholder, you can handle other indices accordingly
    }
  }
}
