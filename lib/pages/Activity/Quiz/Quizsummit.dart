import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewQuizzes extends StatefulWidget {
  const ViewQuizzes({Key? key}) : super(key: key);

  @override
  _ManageQuizzesState createState() => _ManageQuizzesState();
}

class _ManageQuizzesState extends State<ViewQuizzes> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot>? _quizzes;
  List<DocumentSnapshot>? _attemptedQuizzes;

  @override
  void initState() {
    super.initState();
    _fetchQuizzes();
    _fetchAttemptedQuizzes();
  }

  Future<void> _fetchQuizzes() async {
    User? user = _auth.currentUser;
    if (user != null) {
      QuerySnapshot quizSnapshot = await _firestore
          .collection('quizzes')
          .where('teacherId', isEqualTo: user.uid)
          .get();

      setState(() {
        _quizzes = quizSnapshot.docs;
      });
    }
  }

  Future<void> _fetchAttemptedQuizzes() async {
    User? user = _auth.currentUser;
    if (user != null) {
      QuerySnapshot attemptedQuizSnapshot = await _firestore
          .collection('user_performance')
          .where('userId', isEqualTo: user.uid)
          .get();

      setState(() {
        _attemptedQuizzes = attemptedQuizSnapshot.docs;
      });
    }
  }

  bool _isAttempted(String quizId) {
    if (_attemptedQuizzes != null) {
      for (var attemptedQuiz in _attemptedQuizzes!) {
        if (attemptedQuiz['quizId'] == quizId) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Quizzes'),
      ),
      body: _quizzes != null && _quizzes!.isNotEmpty
          ? ListView.builder(
        itemCount: _quizzes!.length,
        itemBuilder: (context, index) {
          DocumentSnapshot quiz = _quizzes![index];
          String quizId = quiz.id;
          Map<String, dynamic>? data =
          quiz.data() as Map<String, dynamic>?;

          if (data != null && data.containsKey('title')) {
            return ListTile(
              title: Text(data['title']),
              subtitle: Text('Quiz ID: $quizId'),
              onTap: () {
               if(_isAttempted(quizId)==true){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Quiz Already Attempted")));
               }
               else {
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) =>
                         SubmitQuizzes(
                           quizId: quizId,
                           quizTitle: data['title'],
                         ),
                   ),
                 );
               }
              },
              trailing: _isAttempted(quizId)
                  ? Text('Attempted')
                  : null, // Show a checkmark if the quiz is attempted
            );
          } else {
            return SizedBox.shrink();
          }
        },
      )
          : Center(
        child: _quizzes == null
            ? CircularProgressIndicator()
            : Text('No quizzes found'),
      ),
    );
  }
}


class SubmitQuizzes extends StatefulWidget {
  final String quizId;
  final String quizTitle;

  const SubmitQuizzes({
    Key? key,
    required this.quizId,
    required this.quizTitle,
  }) : super(key: key);

  @override
  _ModifyQuizPageState createState() => _ModifyQuizPageState();
}

class _ModifyQuizPageState extends State<SubmitQuizzes> {
  List<Map<String, dynamic>> _questions = [];
  List<int?> _selectedAnswers = [];
  List<Color> _selectedAnswerColors = []; // Added list to track colors
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchQuizDetails();
  }

  Future<void> _fetchQuizDetails() async {
    try {
      DocumentSnapshot quizSnapshot = await FirebaseFirestore.instance
          .collection('quizzes')
          .doc(widget.quizId)
          .get();

      if (quizSnapshot.exists) {
        QuerySnapshot questionSnapshot = await FirebaseFirestore.instance
            .collection('quizzes')
            .doc(widget.quizId)
            .collection('questions')
            .get();

        List<Map<String, dynamic>> fetchedQuestions = [];

        for (QueryDocumentSnapshot questionDoc in questionSnapshot.docs) {
          List<Map<String, dynamic>> fetchedOptions = [];

          QuerySnapshot optionSnapshot =
          await questionDoc.reference.collection('options').get();

          optionSnapshot.docs.forEach((optionDoc) {
            fetchedOptions.add({
              'optionId': optionDoc.id,
              'option': optionDoc['option'],
            });
          });

          fetchedQuestions.add({
            'questionId': questionDoc.id,
            'question': questionDoc['question'],
            'options': fetchedOptions,
            'correctAnswer': questionDoc['correctAnswer'],
          });
        }

        setState(() {
          _questions = fetchedQuestions;
          _selectedAnswers = List.generate(_questions.length, (_) => null);
          _selectedAnswerColors =
              List.generate(_questions.length, (_) => Colors.white);
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching quiz details: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _submitQuiz() async {
    int correctAnswers = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_selectedAnswers[i] == _questions[i]['correctAnswer']) {
        correctAnswers++;
        _selectedAnswerColors[i] = Colors.green;
      } else {
        _selectedAnswerColors[i] = Colors.red;
      }
    }

    // Update the UI to reflect the color changes
    setState(() {});

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Upload user performance data to Firestore
        await FirebaseFirestore.instance.collection('user_performance').add({
          'userId': user.uid,
          'quizId': widget.quizId,
          'correctAnswers': correctAnswers,
          'quizAttempt': 1,
        });

        // Update quiz attempt count in user profile or another relevant collection
        DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
        DocumentSnapshot userSnapshot = await userRef.get();
        Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          int quizAttempts = userData['quizAttempts'] ?? 0;

          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({'quizAttempts': quizAttempts + 1});
        } else {
          print('User data is null');
        }
      }
    } catch (e) {
      print('Error submitting quiz: $e');
    }


    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quiz Result'),
        content: Text('Number of correct answers: $correctAnswers'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Quiz'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _questions.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Question ${index + 1}: ${_questions[index]['question']}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                children: List.generate(
                  _questions[index]['options'].length,
                      (optionIndex) {
                    final option =
                    _questions[index]['options'][optionIndex];
                    return RadioListTile<int>(
                      fillColor:
                      MaterialStatePropertyAll(Colors.blue),
                      title: Text(option['option']),
                      value: optionIndex,
                      groupValue: _selectedAnswers[index],
                      onChanged: (value) {
                        setState(() {
                          _selectedAnswers[index] = value;
                        });
                      },
                      activeColor: _selectedAnswerColors[index],
                    );
                  },
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: _submitQuiz,
            child: Text('Submit Quiz'),
          ),
        ),
      ),
    );
  }
}
