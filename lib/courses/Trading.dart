
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsbridgedu/courses/Widget/ListWidget.dart';

class Trading extends StatefulWidget {
  const Trading({Key? key}) : super(key: key);

  @override
  State<Trading> createState() => _FacebookAdsState();
}

class _FacebookAdsState extends State<Trading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,
          title: Text('Trading Mastery Course',style:GoogleFonts.alef( color:Colors.black,fontSize: 25,fontWeight: FontWeight.bold),)
        // .shimmer(primaryColor: Vx.red900,secondaryColor: Colors.white,)
      ),
      body: Column(
        children: [
          ListWidget(
            items: [
              ListItem(
                title: "Lesson 1",
                subtitle: "Introduction And Fundamentals",
                duration: "8:43 min", imageUrl: 'https://i.ytimg.com/vi/SjwrUybbzc4/maxresdefault.jpg',
                videoUrl: 'assets/fbl1.mp4',
              ),
              ListItem(
                title: "Lesson 2",
                subtitle: "Why Trading?",
                duration: "10:00 min", imageUrl: 'https://i.ytimg.com/vi/hTupDarAahM/maxresdefault.jpg',
                videoUrl: 'assets/lesson2.mp4',
              ), ListItem(
                title: "Lesson 3",
                subtitle: "What We Need to be SuccessFull?",
                duration: "9:40 min", imageUrl: 'https://i.ytimg.com/vi/D1vnWZyEB30/maxresdefault.jpg', videoUrl: '',
              ),
              // Add more items as needed
            ],
          ),
        ],
      ),
    );
  }
}
