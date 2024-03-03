import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsbridgedu/pages/Activity/Assignment/assignments.dart';
import 'package:tsbridgedu/pages/Activity/Community/ViewCommunity.dart';
import 'package:tsbridgedu/pages/Activity/Quiz/Quizsummit.dart';

class Activity extends StatelessWidget {// Set the default index for Activity page

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Hello ${user?.displayName ?? 'Utser'}', // Display user's name
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Let\'s test your knowledge',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16.0),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          GestureDetector(onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ViewQuizzes();
            },));
          },child: Text("Quizzes",style: GoogleFonts.adamina(fontSize: 15),)),
          GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ViewAssignments();
                },));
              },
              child: Text("Assignment",style: GoogleFonts.adamina(fontSize: 15),)),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ViewCommunity();
                },));
              },
              child: Text("Community",style: GoogleFonts.adamina(fontSize: 15),)),
        ],),
      ),
          SizedBox(height: 16.0),
          buildQuizCard('Java Fundamentals', 'https://www.dremendo.com/java-programming-tutorial/images/java-programming-tutorial.jpg', '10', '30 min', 4),
          buildQuizCard('Python Fundamentals', 'https://blog.eduonix.com/wp-content/uploads/2018/09/Scientific-Python-Scipy.jpg', '15', '45 min', 3),
          SizedBox(height: 16.0),
          buildContinueQuizCard('Python Fundamentals', 'https://blog.eduonix.com/wp-content/uploads/2018/09/Scientific-Python-Scipy.jpg', 'Resume', 'Delete'),
        ],
      ),
    );
  }
  

  Widget buildQuizCard(String title, String image, String questions, String duration, int starRating) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Container(
            width: 120.0, // Adjust the width as needed
            height: 120.0, // Adjust the height as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Text('No. of Questions: $questions'),
                  SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(Icons.access_time),
                      SizedBox(width: 4.0),
                      Text('Duration: $duration'),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildStarRating(starRating),
                      // Add any other widgets as needed
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStarRating(int rating) {
    return Row(
      children: List.generate(rating, (index) => Icon(Icons.star, color: Colors.amber)),
    );
  }

  Widget buildContinueQuizCard(String title, String image, String resumeLabel, String deleteLabel) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: 180.0, // Adjust the width as needed
            height: 180.0, // Adjust the height as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle resume action
                        },
                        child: Text(resumeLabel),
                      ),
                      IconButton(
                        onPressed: () {
                          // Handle delete action
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }}