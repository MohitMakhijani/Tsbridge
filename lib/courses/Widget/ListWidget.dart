import 'package:flutter/material.dart';
import 'package:tsbridgedu/Utils/PlayVideoFromDrive.dart';

class ListItem {
  final String title;
  final String subtitle;
  final String duration;
  final String imageUrl; // Image URL
  final String videoUrl; // Video URL

  ListItem({
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.imageUrl,
    required this.videoUrl,
  });
}

class ListWidget extends StatelessWidget {
  final List<ListItem> items;

  const ListWidget({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          final listItem = items[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerScreen(videoUrl: listItem.imageUrl,),)) ;
              print('Playing video: ${listItem.title}');
              print('Video URL: ${listItem.videoUrl}');
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListTile(
                title: Container(
                  width: 75,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(listItem.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listItem.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          listItem.subtitle,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          listItem.duration,
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: items.length,
      ),
    );
  }
}