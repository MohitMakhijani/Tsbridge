import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({Key? key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  final TextEditingController _emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('email sent'),
          );
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Check your mail for resetting your password'),
        duration: Duration(seconds: 2),
      ));
      _emailController.clear();
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Password reset failed: $e'),
          );
        },
      );
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
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                      child: Center(
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
                      child: Center(
                        child: Text(
                          "Please enter your email address",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 35.0),
                            child: TextFormField(
                              controller: _emailController,
                              validator: (email) {
                                if (email!.isEmpty)
                                  return "Please enter email";
                                else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(email)) {
                                  return "Please Enter a valid email";
                                }
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                ),
                                contentPadding: EdgeInsets.all(10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                labelText: 'E-Mail',
                                labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                hintText: 'Enter Your Name',
                                hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            height: 40.0,
                            width: 330.0,
                            decoration: BoxDecoration(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: passwordReset,
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                  ),
                                  child: Text(
                                    'SUBMIT',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(context, '/login');
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Colors.blue),
                                  ),
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                  Icons.lock_reset_outlined,
                  color: Colors.white,
                  weight: 10.0,
                  size: 200.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}