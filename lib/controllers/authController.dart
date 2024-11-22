import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:password_manager/Screens/Walkthrough.dart';

import '../Screens/auth/authscreen.dart';


class AuthController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String username = '';
  String? profilePicUrl;
  bool isLoginPage = true;

  Future<String> uploadImageToFirebase(String path, Uint8List imageData) async {
    try {
      print('Starting image upload...');
      Reference storageRef = _storage.ref().child(path);
      print('Storage reference created: $storageRef');
      UploadTask uploadTask = storageRef.putData(imageData);
      print('Upload task started');
      TaskSnapshot snapshot = await uploadTask;
      print('Upload task completed');
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print('Download URL: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      print('Failed to upload image: $e');
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<void> submitForm(BuildContext context, String email, String password,
      String username, Uint8List? imageData) async {
    final auth = FirebaseAuth.instance;

    try {
      if (isLoginPage) {
        final UserCredential authResult = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        String uid = authResult.user!.uid;
        DocumentSnapshot userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        this.username = userDoc['username'];
        this.email = userDoc['email'];
        this.profilePicUrl = userDoc['profilePicUrl'];
      } else {
        final UserCredential authResult =
            await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String uid = authResult.user!.uid;
        String? profilePicUrl;
        if (imageData != null) {
          profilePicUrl =
              await uploadImageToFirebase('user_images/$uid.jpg', imageData);
        }
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'username': username,
          'email': email,
          'profilePicUrl': profilePicUrl,
        });
        this.username = username;
        this.email = email;
        this.profilePicUrl = profilePicUrl;
        isLoginPage = true;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup successful! Please log in.')),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Walkthrough()),
        );
      }
    } catch (error) {
      print('Error during authentication: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Authentication failed: $error')),
      );
    }
  }

  void startAuthentication(BuildContext context, Uint8List? imageData) {
    final validity = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (validity) {
      formKey.currentState!.save();
      submitForm(context, email, password, username, imageData);
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signed out successfully')),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => AuthScreen()),
      );
    } catch (error) {
      print('Error signing out: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign out failed: $error')),
      );
    }
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return {
        'username': userDoc['username'],
        'email': userDoc['email'],
        'profilePicUrl': userDoc['profilePicUrl'],
      };
    }
    throw Exception('No user logged in');
  }
}
