import 'package:flutter/material.dart';
import '../AdobeCourse.dart';
import '../DropShipping.dart';
import '../FacebookAdscourse.dart';
import '../Trading.dart';
import '../communication skill course.dart';
import 'CourseCard.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({Key? key}) : super(key: key);

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildCourseCardsList(context),
    );
  }
}

Widget buildCourseCardsList(BuildContext context) {
  return ListView(
    children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return FacebookAds();
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        },
        child: CourseCard(
          courseName: 'Facebook Ads Course',
          description: '100 Days of the Facebook Ads Mastery',
          author: 'Ts Bridge Edu',
          duration: '15 weeks',
          coverImageUrl: 'https://rescholar.in/uploads/course/1678790595-B2oqSItsSB.png',
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return Dropshipping();
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        },
        child: CourseCard(
          courseName: 'Drop shipping Killing Course ',
          description: 'Earn As Much As You Can With DropSipping',
          author: 'Ts Bridge Edu',
          duration: '8 weeks',
          coverImageUrl: 'https://s3.amazonaws.com/coursesity-blog/2022/05/Droshipping_courses.jpg',
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return Trading();
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        },
        child: CourseCard(
          courseName: 'Ultimate Trading Course For Beginners',
          description: 'Be Bull Of Market',
          author: 'Ts Bridge Edu',
          duration: '8 weeks',
          coverImageUrl: 'https://i.ytimg.com/vi/y7iVTTH5tOA/maxresdefault.jpg',
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return Communicationskillcourse();
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        },
        child: CourseCard(
          courseName: 'Communication Skill Course',
          description: 'Effective And Easy Communication',
          author: 'Ts Bridge Edu',
          duration: '8 weeks',
          coverImageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjHtg1AxgvCcCnaEc9ChLRLpftXIK9reCLbA&usqp=CAU',
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return Adobe();
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        },
        child: CourseCard(
          courseName: 'Adobe Premiere Pro Course',
          description: 'Master All The Skills Of the Adobe',
          author: 'Ts Bridge Edu',
          duration: '8 weeks',
          coverImageUrl: 'https://i.ytimg.com/vi/eCsM0r3RNc4/maxresdefault.jpg',
        ),
      ),
      // Add more CourseCard widgets as needed
    ],
  );
}
