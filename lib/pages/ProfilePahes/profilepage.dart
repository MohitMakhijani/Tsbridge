import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsbridgedu/pages/ProfilePahes/editprofile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User? _user;
  String _userName = '';
  String _userEmail = '';
  String _userPhone = '';
  String _gender = '';
  String _dateOfBirth = '';
  String _state = '';
  String imglink = '';
  File? imgFile;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
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
              _userName = userData['Name'];
              _userEmail = userData['Email'];
              _userPhone = userData['Phone'];
              _gender = userData['Gender'] ?? '';
              _dateOfBirth = userData['DateOfBirth'] ?? '';
              _state = userData['State'] ?? '';
              imglink = userData['profilePicture'] ?? '';
            });
          });
        });
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
  }

  void _uploadProfilePicture() async {
    if (imgFile != null) {
      try {
        // Get the user document based on the email
        QuerySnapshot<Map<String, dynamic>> userQuerySnapshot =
        await FirebaseFirestore.instance
            .collection("Users")
            .where("Email", isEqualTo: _userEmail)
            .get();

        if (userQuerySnapshot.docs.isNotEmpty) {
          // If user document exists, update profile picture URL
          String uid = userQuerySnapshot.docs.first.id;

          UploadTask uploadTask = FirebaseStorage.instance
              .ref("profilePicture")
              .child(uid)
              .putFile(imgFile!);

          TaskSnapshot snapshot = await uploadTask;
          String imageUrl = await snapshot.ref.getDownloadURL();

          // Update profile picture URL in the user document
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(uid)
              .update({'profilePicture': imageUrl});

          // Reload user data to reflect changes
          fetchUserData();

          print("Profile picture uploaded successfully");
        } else {
          print("User document does not exist");
        }
      } catch (error) {
        print("Error uploading profile picture: $error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 58.0),
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.blue,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      // Use the image from Firebase Storage here
                      backgroundImage: NetworkImage(
                        imglink.isNotEmpty
                            ? imglink
                            : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await _chooseFile();
                  },
                  icon: Icon(Icons.edit,color: Colors.white,),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              _userName,
              style: GoogleFonts.abhayaLibre(fontSize: 30, fontWeight: FontWeight.bold,),
            ),
            SizedBox(height: 20),
            buildProfileInfo(Icons.phone, _userPhone),
            buildProfileInfo(Icons.email, _userEmail),
            buildProfileInfo(Icons.person, _gender), // Display gender
            buildProfileInfo(Icons.calendar_today, _dateOfBirth), // Display date of birth
            buildProfileInfo(Icons.location_on, _state), // Display state
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EditProfilePage();
                }));
              },
              child: Text(
                'Edit Profile',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileInfo(IconData icon, String text) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(text),
      ),
    );
  }

  Future<void> _chooseFile() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.blue,
          height: 120,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.black, size: 30),
                title: Text(
                    "Camera", style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () async {
                  final pickedFile = await ImagePicker().pickImage(
                    source: ImageSource.camera,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      imgFile = File(pickedFile.path);
                    });
                    _uploadProfilePicture();
                    Navigator.pop(context); // Close the bottom sheet
                    // Upload the profile picture
                  }
                },
              ),
              ListTile(
                leading: Icon(
                    Icons.photo_album_outlined, color: Colors.black, size: 30),
                title: Text(
                    "Gallery", style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () async {
                  final pickedFile = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      imgFile = File(pickedFile.path);
                    });
                    _uploadProfilePicture();
                    Navigator.pop(context); // Close the bottom sheet
                    // Upload the profile picture
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
