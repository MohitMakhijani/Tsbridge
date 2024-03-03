
import 'package:flutter/material.dart';
class CourseCard extends StatelessWidget {
  final String courseName;
  final String description;
  final String author;
  final String duration;
  final String coverImageUrl;

  CourseCard({
    required this.courseName,
    required this.description,
    required this.author,
    required this.duration,
    required this.coverImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(color: Colors.grey[400],
        margin: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              coverImageUrl,
              height: 150.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0), // Reduced spacing
                  Text(
                    description,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0), // Reduced spacing
                  Row(
                    children: [
                      Text(
                        'Author:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(' $author'),
                      SizedBox(width: 8.0), // Reduced spacing
                      Text(
                        'Duration:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(' $duration'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
