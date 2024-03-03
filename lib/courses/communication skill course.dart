import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsbridgedu/courses/Widget/ListWidget.dart';
import 'package:velocity_x/velocity_x.dart';

class Communicationskillcourse extends StatefulWidget {
  const Communicationskillcourse({Key? key}) : super(key: key);

  @override
  State<Communicationskillcourse> createState() => _FacebookAdsState();
}

class _FacebookAdsState extends State<Communicationskillcourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,
          title: Text('Communication course',style:GoogleFonts.alef( color:Colors.black,fontSize: 25,fontWeight: FontWeight.bold),)
        // .shimmer(primaryColor: Vx.red900,secondaryColor: Colors.white,)
      ),
      body: Column(
        children: [
          ListWidget(
            items: [
              ListItem(
                title: "Lesson 1",
                subtitle: "Introduction And Fundamentals",
                duration: "8:43 min", imageUrl: 'https://i.ytimg.com/vi/364nCLsvBno/maxresdefault.jpg',
                videoUrl: 'assets/fbl1.mp4',
              ),
              ListItem(
                title: "Lesson 2",
                subtitle: "Why Learn Communication?",
                duration: "10:00 min", imageUrl: 'https://i.ytimg.com/vi/Bh1aBOrTD0c/sddefault.jpg',
                videoUrl: 'assets/lesson2.mp4',
              ), ListItem(
                title: "Lesson 3",
                subtitle: "What We Need For SuccessFull Communication?",
                duration: "9:40 min", imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGccdBxm_rh571try0Lps1eGNC671C0hV8TQ&usqp=CAU', videoUrl: '',
              ),
              // Add more items as needed
            ],
          ),
        ],
      ),
    );
  }
}
