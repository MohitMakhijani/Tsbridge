import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsbridgedu/pages/Home/saticDataList/DemoDataList.dart';

import '../../Utils/PlayVideoFromDrive.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Resume Learning",
                style: GoogleFonts.akayaKanadaka(fontSize: 25),
              ),
            ),
            buildCard(context, 2),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Demo Videos",
                style: GoogleFonts.akayaKanadaka(fontSize: 25),
              ),
            ),
            buildCard(context, 10),
          ],
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, int itemCount) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Container(
              color: Colors.red,
              height: 250,
              child: VideoPlayerScreen(videoUrl: VideoUrls[index]),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titles[index],
                  style: GoogleFonts.jacquesFrancois(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
             Row(children: [
               for(int i=0;i<5;i++)

               Icon(Icons.star,color: Colors.yellow,)],)
              ],
            ),
          ),
        );
      },
      itemCount: itemCount,
    );
  }
}