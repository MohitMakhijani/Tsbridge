import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the home page
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          '''
         
          Empowering tomorrow's entrepreneurs with practical skills for success in business, finance, technology, and digital marketing.
                        Join us to thrive.
          ''',
          style: TextStyle(fontSize: 16.0),
          textAlign: TextAlign.justify, // Adjust the alignment as needed
        ),
      ),
    );
  }
}
