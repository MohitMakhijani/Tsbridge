import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String? _verificationId;
  late DateFormat formatter;
  CollectionReference collRef =
  FirebaseFirestore.instance.collection('Users');
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void signup(BuildContext context) async {
    try {
      // Create user with email and password
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Show success message for signup
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully signed up'),
          duration: Duration(seconds: 2),
        ),
      );

      // Proceed with phone authentication
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: _otpController.text.toString(),
      );
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Check if user already exists with phone number
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance
          .collection("Users")
          .where("phoneNumber", isEqualTo: _phoneController.text.trim())
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // If user already exists, show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User already exists with this phone number')),
        );
        return;
      }

      // Add user details to Firestore
      final now = DateTime.now();
      formatter = DateFormat('yMd');
      String formattedDate = formatter.format(now);

      // Retrieve Google user information if signed in with Google
      final GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();
      String? googleName;
      String? googleEmail;
      if (googleSignInAccount != null) {
        googleName = googleSignInAccount.displayName;
        googleEmail = googleSignInAccount.email;
      }

      collRef.add({
        'Name': googleName ?? _nameController.text,
        'Email': googleEmail ?? _emailController.text,
        'Phone': _phoneController.text,
        'Date': formattedDate,
        'profilePicture': "",
        'QuizAttempted': "",
        "Class Attempted": "",
        "StudentScore": "",
      });

      // Clear text fields after successful signup
      _phoneController.clear();
      _otpController.clear();
      _nameController.clear();
    } catch (e) {
      // Handle errors
      print('Error during signup: $e');
      if (e is FirebaseAuthException && e.code == 'invalid-verification-code') {
        // Handle invalid OTP
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid OTP. Please enter a valid OTP.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error during signup. Please try again later.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 200, 0.0, 0.0),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                      child: Center(
                        child: Text(
                          "Welcome to",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                      child: Center(
                        child: Text(
                          "TS Bridge Edu",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                      child: Center(
                        child: Text(
                          "Please sign up to continue",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                    Form(
                      key: formkey,
                      child: Column(
                        children: [
                          // All other form fields remain unchanged
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30.0, 0.0, 0.0),
              child: Center(
                child: Icon(
                  Icons.manage_accounts_rounded,
                  color: Colors.white,
                  size: 170.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
