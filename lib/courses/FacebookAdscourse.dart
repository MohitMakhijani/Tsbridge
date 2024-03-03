
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsbridgedu/courses/Widget/ListWidget.dart';


class FacebookAds extends StatefulWidget {
  const FacebookAds({Key? key}) : super(key: key);

  @override
  State<FacebookAds> createState() => _FacebookAdsState();
}

class _FacebookAdsState extends State<FacebookAds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,
        title: Text('Facebook Ads',style:GoogleFonts.alef( color:Colors.black,fontSize: 25,fontWeight: FontWeight.bold),)
            // .shimmer(primaryColor: Vx.red900,secondaryColor: Colors.white,)
      ),
      body: Column(
        children: [
          ListWidget(
            items: [
              ListItem(
                title: "Lesson 1",
                subtitle: "Introduction And Fundamentals",
                duration: "8:43 min", imageUrl: 'https://i.ytimg.com/vi/LXsFOrgbg_o/maxresdefault.jpg',
                videoUrl: 'https://drive.google.com/uc?id=1riMHGuifEvUI_R_xfequJ5JDr8AsuljY',
              ),
              ListItem(
                title: "Lesson 2",
                subtitle: "Why FaceBook Ads?",
                duration: "10:00 min", imageUrl: 'https://i.ytimg.com/vi/pgLGwBAfImU/sddefault.jpg',
                videoUrl: 'https://drive.google.com/uc?id=1OYhDPRlLKspZ0-ntU7lVYCNWskq7Pmsj',
              ), ListItem(
                title: "Lesson 3",
                subtitle: "What We Need For SuccessFull Ads?",
                duration: "9:40 min", imageUrl: 'https://i.ytimg.com/vi/c69Vk3AHvF0/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLAHmBQHdBQoPurfeZGBGp_LKrwV0g', videoUrl: '',
              ),
              // Add more items as needed
            ],
          ),
        ],
      ),
    );
  }
}
