import 'package:flutter/material.dart';

class LiveClasses extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildLiveClassCardsList(),
    );
  }

  Widget buildLiveClassCardsList() {
    return ListView(
      children: [
        LiveClassCard(
          className: 'Advanced Java Concepts',
          topic: 'Understanding Multithreading in Java',
          time: '@8PM',
          thumbnailUrl: 'https://www.dremendo.com/java-programming-tutorial/images/java-programming-tutorial.jpg',
        ),
        LiveClassCard(
          className: 'Python for Data Science',
          topic: 'Introduction to Pandas Library',
          time: '@3PM',
          thumbnailUrl: 'https://blog.eduonix.com/wp-content/uploads/2018/09/Scientific-Python-Scipy.jpg',
        ),
        // Add more LiveClassCard widgets as needed
      ],
    );
  }

}

class LiveClassCard extends StatelessWidget {
  final String className;
  final String topic;
  final String time;
  final String thumbnailUrl;

  LiveClassCard({
    required this.className,
    required this.topic,
    required this.time,
    required this.thumbnailUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    className,
                    style: TextStyle(fontSize: 18), //, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    topic,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(height: 4.0),
                  Text(time),
                ],
              ),
            ),
          ),
          Container(
            width: 120.0, // Adjust the width as needed
            height: 190.0, // Adjust the height as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage(thumbnailUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
