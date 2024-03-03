import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tsbridgedu/Widgets/NAV_PAGE.dart';
import 'package:tsbridgedu/pages/ProfilePahes/forget_password.dart';
import 'package:tsbridgedu/pages/SignUp/signuppage.dart';
import 'package:tsbridgedu/pages/Home/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart'; // Import DateFormat

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late FirebaseAuth _auth;
  String user_name = '';
  String user_email = '';
  String phone = '';
  String formatter = '';

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      final User? user = userCredential.user;
      if (user != null && mounted) {
        print("Login successful");
        print("User UID: ${user.uid}");

        _emailController.clear();
        _passwordController.clear();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavPage()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to sign in: ${e.toString()}'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      print("Error signing in: $e");
    }
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          final googleUser = await googleSignIn.currentUser!;
          final googleEmail = googleUser.email;
          final googleName = googleUser.displayName;

          final phone = _phoneController.text;

          // Get current date
          final DateTime now = DateTime.now();
          final String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now); // Format date

          await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
            'Name': googleName ?? _emailController.text, // Fix this line
            'Email': googleEmail ?? _emailController.text,
            'Phone': phone,
            'Date': formattedDate,
            'profilePicture': "",
            'QuizAttempted': "",
            "Class Attempted": "",
            "StudentScore": "",
          });

          print('Google sign in successful. User UID: ${user.uid}');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NavPage()),
          );
        }
      }
    } catch (error) {
      print('Google sign in failed: $error');
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
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Center(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 100.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 260.0, 0.0, 0.0),
              child: Container(
                width: double.infinity,
                height: (MediaQuery.of(context).size.height) - 260,
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
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                      child: Center(
                        child: Text(
                          "TS Bridge Education",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.blue),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                      child: Center(
                        child: Text("Please login to continue", style: TextStyle(fontSize: 17)),
                      ),
                    ),
                    Form(
                      key: formkey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 25.0),
                            child: TextFormField(
                              controller: _emailController,
                              validator: (email) {
                                if (email!.isEmpty)
                                  return "Please enter email";
                                else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0.9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                ).hasMatch(email)) {
                                  return "Please Enter a valid email";
                                }
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                ),
                                contentPadding: EdgeInsets.all(10.0),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                                labelText: 'E-Mail',
                                labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                hintText: 'Enter Your Email',
                                hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 10.0),
                            child: TextFormField(
                              controller: _passwordController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (password) {
                                if (password!.isEmpty) {
                                  return "Please Enter the password";
                                } else if (password.length < 7) return "Please enter minimum 8 letters";
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                ),
                                contentPadding: EdgeInsets.all(10.0),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                hintText: 'Enter Password',
                                hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Container(
                                  height: 40.0,
                                  width: 120.0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (formkey.currentState!.validate()) {
                                        signInWithEmailAndPassword();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 40.0,
                                width: 120.0,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Signup()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                                  child: Text(
                                    'SIGN UP',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ForgetPass()),
                                    );
                                  },
                                  child: const Text('Forgot your password?', style: TextStyle(fontSize: 14, color: Colors.red)),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: signInWithGoogle,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                              child: Container(
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/images/google.png',
                                    height: 50,
                                    width: 300,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
