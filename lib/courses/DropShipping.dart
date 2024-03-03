import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsbridgedu/courses/Widget/ListWidget.dart';
import 'package:velocity_x/velocity_x.dart';

class Dropshipping extends StatefulWidget {
  const Dropshipping({Key? key}) : super(key: key);

  @override
  State<Dropshipping> createState() => _FacebookAdsState();
}

class _FacebookAdsState extends State<Dropshipping> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,
          title: Text('DropShipping Course',style:GoogleFonts.alef( color:Colors.black,fontSize: 25,fontWeight: FontWeight.bold),)
        // .shimmer(primaryColor: Vx.red900,secondaryColor: Colors.white,)
      ),
      body: Column(
        children: [
          ListWidget(
            items: [
              ListItem(
                title: "Lesson 1",
                subtitle: "Introduction And Fundamentals",
                duration: "8:43 min", imageUrl: 'https://i.ytimg.com/vi/p9qGtMYz8MY/maxresdefault.jpg',
                videoUrl: 'assets/11.mp4',
              ),
              ListItem(
                title: "Lesson 2",
                subtitle: "Why DropShipping?",
                duration: "10:00 min", imageUrl: 'https://i.ytimg.com/vi/6Qq-IzDI8ig/maxresdefault.jpg',
                videoUrl: 'assets/lesson2.mp4',
              ), ListItem(
                title: "Lesson 3",
                subtitle: "What We Need For SuccessFull Dropshipping?",
                duration: "9:40 min", imageUrl: 'https://media.licdn.com/dms/image/D4E12AQFf939t3kZYhQ/article-cover_image-shrink_720_1280/0/1696863005458?e=2147483647&v=beta&t=p_4Qj4o1hnNKuqFTL_GLZh6_HeZ4VaAsBVHH28zrJik', videoUrl: '',
              ),
              // Add more items as needed
            ],
          ),
        ],
      ),
    );
  }
}
