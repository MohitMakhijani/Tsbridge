import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late User? _user;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _dobController;
  late TextEditingController _genderController;
  late TextEditingController _addressController;

  late TextEditingController _streetController;
  late TextEditingController _districtController;
  late TextEditingController _stateController;
  late TextEditingController _universityController;
  late TextEditingController _collegeMarksController;
  late TextEditingController _intermediateCollegeController;
  late TextEditingController _intermediateMarksController;
  late TextEditingController _schoolController;
  late TextEditingController _schoolMarksController;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _dobController = TextEditingController();
    _genderController = TextEditingController();
    _addressController = TextEditingController();

    _streetController = TextEditingController();
    _districtController = TextEditingController();
    _stateController = TextEditingController();
    _universityController = TextEditingController();
    _collegeMarksController = TextEditingController();
    _intermediateCollegeController = TextEditingController();
    _intermediateMarksController = TextEditingController();
    _schoolController = TextEditingController();
    _schoolMarksController = TextEditingController();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    if (_user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('Users')
            .where('Email', isEqualTo: _user!.email)
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
            setState(() {
              _nameController.text = userData['Name'];
              _emailController.text = userData['Email'];
              _phoneController.text = userData['Phone'];
              _dobController.text = userData['DateOfBirth'];
              _genderController.text = userData['Gender'];
              _addressController.text = userData['Address'];

              _streetController.text = userData['Street'];
              _districtController.text = userData['District'];
              _stateController.text = userData['State'];
              _universityController.text = userData['UniversityName'];
              _collegeMarksController.text = userData['CollegeMarks'];
              _intermediateCollegeController.text = userData['IntermediateCollegeName'];
              _intermediateMarksController.text = userData['IntermediateMarks'];
              _schoolController.text = userData['SchoolName'];
              _schoolMarksController.text = userData['SchoolMarks'];
            });
          });
        });
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
  }

  Future<void> updateUserData() async {
    if (_user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('Users')
            .where('Email', isEqualTo: _user!.email)
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            doc.reference.update({
              'Name': _nameController.text,
              'Phone': _phoneController.text,
              'DateOfBirth': _dobController.text,
              'Gender': _genderController.text,
              'Address': _addressController.text,

              'Street': _streetController.text,
              'District': _districtController.text,
              'State': _stateController.text,
              'UniversityName': _universityController.text,
              'CollegeMarks': _collegeMarksController.text,
              'IntermediateCollegeName': _intermediateCollegeController.text,
              'IntermediateMarks': _intermediateMarksController.text,
              'SchoolName': _schoolController.text,
              'SchoolMarks': _schoolMarksController.text,
            });
          });
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile updated successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      } catch (e) {
        print("Error updating user data: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, '/home');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                updateUserData();
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  readOnly: true,
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Phone'),
                ),
                TextFormField(
                  controller: _dobController,
                  decoration: InputDecoration(labelText: 'Date of Birth'),
                ),
                TextFormField(
                  controller: _genderController,
                  decoration: InputDecoration(labelText: 'Gender'),
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                ),

                TextFormField(
                  controller: _streetController,
                  decoration: InputDecoration(labelText: 'Street'),
                ),
                TextFormField(
                  controller: _districtController,
                  decoration: InputDecoration(labelText: 'District'),
                ),
                TextFormField(
                  controller: _stateController,
                  decoration: InputDecoration(labelText: 'State'),
                ),
                TextFormField(
                  controller: _universityController,
                  decoration: InputDecoration(labelText: 'University / College Name'),
                ),
                TextFormField(
                  controller: _collegeMarksController,
                  decoration: InputDecoration(labelText: 'Marks in College (in %)'),
                ),
                TextFormField(
                  controller: _intermediateCollegeController,
                  decoration: InputDecoration(labelText: 'Intermediate / Diploma College Name'),
                ),
                TextFormField(
                  controller: _intermediateMarksController,
                  decoration: InputDecoration(labelText: 'Marks (in %)'),
                ),
                TextFormField(
                  controller: _schoolController,
                  decoration: InputDecoration(labelText: 'School Name'),
                ),
                TextFormField(
                  controller: _schoolMarksController,
                  decoration: InputDecoration(labelText: 'Marks (in %)'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
