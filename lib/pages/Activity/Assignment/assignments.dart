import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewAssignments extends StatelessWidget {
  const ViewAssignments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
        title: Text(
          "Assignments",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('assignments').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No assignments available'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewQuestions(assignmentId: documentSnapshot.id),
                    ),
                  );
                },
                title: Text(documentSnapshot['assignmentName']),
                subtitle: Text(documentSnapshot['teacherId']),
              );
            },
          );
        },
      ),
    );
  }
}
class ViewQuestions extends StatelessWidget {
  final String assignmentId;

  const ViewQuestions({Key? key, required this.assignmentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questions'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('assignments').doc(assignmentId).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Assignment not found'));
          }

          Map<String, dynamic>? assignmentData = snapshot.data!.data() as Map<String, dynamic>?;

          if (assignmentData == null || !assignmentData.containsKey('questions')) {
            return Center(child: Text('No questions available'));
          }

          List<dynamic> questions = assignmentData['questions'] ?? [];
          if (questions.isEmpty) {
            return Center(child: Text('No questions available'));
          }

          return ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              dynamic questionData = questions[index];
              return ListTile(
                title: Text('Question ${index + 1}'),
                subtitle: Text(questionData,style: TextStyle(fontSize: 20),),
                // Add more widgets to display other fields as needed
              );
            },
          );
        },
      ),
    );
  }
}