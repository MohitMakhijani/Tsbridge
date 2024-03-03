import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsbridgedu/courses/Widget/ListWidget.dart';
import 'package:velocity_x/velocity_x.dart';

class Adobe extends StatefulWidget {
  const Adobe({Key? key}) : super(key: key);

  @override
  State<Adobe> createState() => _FacebookAdsState();
}

class _FacebookAdsState extends State<Adobe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,
          title: Text('Adobe Pro Course',style:GoogleFonts.alef( color:Colors.black,fontSize: 25,fontWeight: FontWeight.bold),)
        // .shimmer(primaryColor: Vx.red900,secondaryColor: Colors.white,)
      ),
      body: Column(
        children: [
          ListWidget(
            items: [
              ListItem(
                title: "Lesson 1",
                subtitle: "Introduction And Fundamentals",
                duration: "8:43 min",
                imageUrl: 'https://d3f1iyfxxz8i1e.cloudfront.net/courses/course_image/444255c14700.jpg',
                videoUrl: 'assets/7. Exporting.mp4',
              ),
              ListItem(
                title: "Lesson 2",
                subtitle: "Why Abobe Pro?",
                duration: "10:00 min", imageUrl: 'https://i.ytimg.com/vi/tMjMyBNdb0s/maxresdefault.jpg',
                videoUrl: 'assets/lesson2.mp4',
              ), ListItem(
                title: "Lesson 3",
                subtitle: "What We Need For SuccessFull Projects?",
                duration: "9:40 min", imageUrl: 'https://i.ytimg.com/vi/9gZm00t-hHI/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLCTGhGg-0h7IHpONCERJLEQqZBRGw', videoUrl: '',
              ),
              // Add more items as needed
            ],
          ),
        ],
      ),
    );
  }
}
